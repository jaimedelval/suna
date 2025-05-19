# Use official Python image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Copy the backend directory into the container
COPY backend /app/backend

# Install dependencies
COPY backend/requirements.txt .
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Expose the FastAPI port (used by agent.api)
EXPOSE 8000

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Run the agent backend
CMD ["python", "backend/agent/run.py"]
