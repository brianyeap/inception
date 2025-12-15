FROM debian:bookworm

# 1) Install nginx and openssl
RUN apt-get update && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

# 2) Generate a self-signed SSL certificate
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 \
        -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/selfsigned.key \
        -out /etc/nginx/ssl/selfsigned.crt \
        -subj "/CN=localhost"

# 3) Copy our HTML into the default web root
COPY index.html /var/www/html/index.html

# 4) Use our own nginx site config (we’ll create this file next)
COPY default /etc/nginx/sites-available/default

# 5) Expose HTTP and HTTPS
EXPOSE 80 443

# 6) Run nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
