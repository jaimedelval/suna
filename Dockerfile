# Use official Python base
FROM python:3.11-slim

# Set working dir
WORKDIR /app

# Install dependencies
COPY backend/requirements.txt ./requirements.txt
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copy backend only
COPY backend/ ./

# Expose port (if needed for UI or API)
EXPOSE 8000

# Set environment variable to prevent buffering
ENV PYTHONUNBUFFERED=1

# Start the application
CMD ["python", "start.py"]
