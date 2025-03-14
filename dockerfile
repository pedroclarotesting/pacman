FROM nginx
# Copy files from the host into container
COPY src /usr/share/nginx/html
EXPOSE 80
# Run Nginx
CMD ["nginx", "-g", "daemon off;"]