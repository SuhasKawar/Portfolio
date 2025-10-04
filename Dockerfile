# Use a lightweight web server image
FROM nginx:alpine

# Copy all your HTML, CSS, and image files to the nginx web directory
COPY . /usr/share/nginx/html

# Expose port 80 (default HTTP port)
EXPOSE 80

# nginx starts automatically by default in this image