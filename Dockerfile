FROM python:3.9-slim

# Install Nginx and supervisor
RUN apt-get update && \
    apt-get install -y nginx supervisor

# Install Python dependencies
COPY requirements.txt /app/
WORKDIR /app
RUN pip install -r requirements.txt

# Copy your Python app and Nginx config
COPY . /app/

# Copy the Nginx config file into the container
COPY nginx.conf /etc/nginx/nginx.conf

# Add supervisor configuration file
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose the necessary ports
EXPOSE 80

# Start supervisord to manage both services
CMD ["/usr/bin/supervisord"]
