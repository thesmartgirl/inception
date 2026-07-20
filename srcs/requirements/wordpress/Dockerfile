FROM alpine:3.23

RUN apk add --no-cache \
    php83 \
    php83-fpm \
    php83-mysqli \
    php83-phar \
    php83-curl \
    php83-mbstring \
    php83-iconv \
    php83-session \
    php83-xml \
    php83-dom \
    php83-simplexml \
    php83-json \
    php83-tokenizer \
    curl \
    mariadb-client

# Standardize binary name
RUN ln -s /usr/bin/php83 /usr/bin/php

# Configure PHP-FPM to listen on all interfaces
RUN sed -i 's|listen = 127.0.0.1:9000|listen = 9000|' /etc/php83/php-fpm.d/www.conf

# Setup working directory layout
RUN mkdir -p /var/www/html && chown -R nobody:nobody /var/www/html
WORKDIR /var/www/html

# Download WP-CLI securely
RUN curl -L \
    https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    -o /usr/local/bin/wp \
    && chmod +x /usr/local/bin/wp

# Copy and setup entrypoint script
COPY tools/setup_wordpress.sh /setup_wordpress.sh
RUN chmod +x /setup_wordpress.sh

EXPOSE 9000

ENTRYPOINT ["/setup_wordpress.sh"]

