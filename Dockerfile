# Use a Python base image
FROM python:3.9-slim

# Install Nginx and supervisor
RUN apt-get update && \
    apt-get install -y nginx supervisor && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt /app/
WORKDIR /app
RUN pip install --no-cache-dir -r requirements.txt

# Copy your app code into the container
COPY . /app/

# Copy the Nginx config file into the container
COPY nginx.conf /etc/nginx/nginx.conf

# Add supervisor configuration file to manage both Nginx and Gunicorn
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose port 80 to communicate with the outside world
EXPOSE 80

# Command to run supervisor (which will manage Nginx and Gunicorn)
CMD ["/usr/bin/supervisord"]
