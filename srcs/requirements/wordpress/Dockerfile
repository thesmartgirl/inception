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
    curl \
    mariadb-client

RUN ln -s /usr/bin/php83 /usr/bin/php
RUN sed -i 's|listen = 127.0.0.1:9000|listen = 9000|' \
    /etc/php83/php-fpm.d/www.conf
    
#RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN curl -L \
    https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    -o /usr/local/bin/wp \
    && chmod +x /usr/local/bin/wp

COPY tools/setup_wordpress.sh /setup_wordpress.sh

RUN chmod +x /setup_wordpress.sh

EXPOSE 9000

ENTRYPOINT ["/setup_wordpress.sh"]
