# Set working directory
WORKDIR /app

# Copy backend code
COPY backend/ ./backend/

# Install dependencies
COPY backend/requirements.txt ./requirements.txt
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Expose port 8000 for Railway
EXPOSE 8000

# Optional: Add backend to PYTHONPATH
ENV PYTHONPATH="${PYTHONPATH}:/app/backend"

# Start web server — update to your actual framework and file
CMD ["python", "backend/agent/run.py"]
