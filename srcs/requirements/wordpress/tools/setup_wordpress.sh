#!/bin/sh

set -e

MYSQL_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

until mariadb -h mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT 1" >/dev/null 2>&1
do
    echo "Waiting for MariaDB..."
    sleep 2
done

mkdir -p /var/www/html

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Installing WordPress..."

    cd /var/www/html

    php -d memory_limit=512M /usr/local/bin/wp core download --allow-root
    echo "WordPress downloaded"
    
    wp config create \
    --allow-root \
    --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER \
    --dbpass=$MYSQL_PASSWORD \
    --dbhost=mariadb

    
    wp core install \
    --allow-root \
    --url=https://$DOMAIN_NAME \
    --title="Inception" \
    --admin_user=$WP_ADMIN_USER \
    --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL

    
    wp user create \
    $WP_USER \
    $WP_USER_EMAIL \
    --user_pass=$WP_USER_PASSWORD \
    --allow-root

fi

exec php-fpm83 -F
