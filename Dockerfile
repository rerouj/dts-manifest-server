FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy the manifest_server directory
COPY manifest_server/ /app/

# Expose port 8005
EXPOSE 8005

# Run the server
CMD ["python", "server.py"]