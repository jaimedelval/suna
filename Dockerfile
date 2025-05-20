# ✅ Base image must come first!
FROM python:3.11-slim

# ✅ Set working directory
WORKDIR /app

# ✅ Copy backend code
COPY backend/ ./backend/

# ✅ Copy requirements and install
COPY backend/requirements.txt ./requirements.txt
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# ✅ Set unbuffered output
ENV PYTHONUNBUFFERED=1

# ✅ Expose the port (important for Railway)
EXPOSE 8000

# ✅ Set the default command to run your app
CMD ["python", "backend/agent/run.py"]
