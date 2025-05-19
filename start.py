#!/usr/bin/env python3

import subprocess
import sys
import os

def check_docker_compose_up():
    result = subprocess.run(
        ["docker", "compose", "ps", "-q"],
        capture_output=True,
        text=True
    )
    return len(result.stdout.strip()) > 0

def main():
    # ✅ Detect Railway: Skip all prompts and docker logic
    if os.getenv("RAILWAY_ENVIRONMENT_NAME"):
        print("🚀 Running in Railway. Skipping docker compose.")
        try:
            from backend.agent.run import start_agent
            start_agent()
        except Exception as e:
            print("❌ Failed to start agent:", e)
        return

    # 🔧 Local dev logic
    force = False
    if "--help" in sys.argv:
        print("Usage: ./script.py [OPTION]")
        print("Manage docker-compose services interactively")
        print("\nOptions:")
        print("  -f\tForce start containers without confirmation")
        print("  --help\tShow this help message")
        return

    if "-f" in sys.argv:
        force = True
        print("Force awakened. Skipping confirmation.")

    is_up = check_docker_compose_up()

    if is_up:
        action = "stop"
        msg = "🛑 Stop containers? [y/N] "
    else:
        action = "start"
        msg = "⚡ Start containers? [Y/n] "

    if not force:
        try:
            response = input(msg).strip().lower()
        except EOFError:
            print("❌ No input available. Aborting.")
            return

        if action == "stop" and response != "y":
            print("Aborting.")
            return
        elif action == "start" and response == "n":
            print("Aborting.")
            return

    if action == "stop":
        subprocess.run(["docker", "compose", "down"])
    else:
        subprocess.run(["docker", "compose", "up", "-d"])

if __name__ == "__main__":
    main()
