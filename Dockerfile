# Base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy backend code
COPY backend/ ./backend/

# Install dependencies
COPY backend/requirements.txt ./requirements.txt
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Add backend to Python path so 'agent' can be imported
ENV PYTHONPATH="${PYTHONPATH}:/app/backend"

# Unbuffered logs
ENV PYTHONUNBUFFERED=1

# Expose FastAPI port
EXPOSE 8000

# Run the agent
CMD ["python", "backend/agent/run.py"]
