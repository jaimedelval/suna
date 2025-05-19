# Use official Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy backend requirements and install
COPY backend/requirements.txt ./requirements.txt
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copy backend code
COPY backend/ ./backend/

# Set environment variable to prevent buffering
ENV PYTHONUNBUFFERED=1

# ➕ Add backend to Python path so `agent` can be found
ENV PYTHONPATH="${PYTHONPATH}:/app/backend"

# Run the agent
CMD ["python", "backend/agent/run.py"]
