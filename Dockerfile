# Use official Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy backend requirements and install them
COPY backend/requirements.txt ./requirements.txt
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copy full backend app
COPY backend/ .

# Expose FastAPI port (if needed)
EXPOSE 8000

# Set environment variable
ENV PYTHONUNBUFFERED=1

# Run the Suna agent via run.py
CMD ["python", "run.py"]
