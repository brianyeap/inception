#!/bin/sh
set -eu

if [ ! -f /var/www/html/wp-config.php ]; then
    # Download wp files
    wp core download --allow-root

    # Create wp-config.php
    wp config create --dbname=$DB_NAME --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD --dbhost=$DB_HOST --allow-root --skip-check

    # Install wordpress
    wp core install --url="https://$DOMAIN_NAME" --title=$WP_TITLE --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL \
        --allow-root

    wp option update comments_notify 0 --allow-root
    wp option update moderation_notify 0 --allow-root
    wp option update comment_moderation 0 --allow-root

    wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root

    wp config set FORCE_SSL_ADMIN 'false' --allow-root # local it's http, nginx already handling ssl
    wp config set WP_CACHE 'true' --allow-root

    chmod 777 /var/www/html/wp-content

    wp theme install twentyfifteen --allow-root
    wp theme activate twentyfifteen --allow-root
    wp theme update twentyfifteen --allow-root
fi

# php-fpm version matches the default PHP packaged with Debian Bullseye (7.4)
exec php-fpm7.4 -F
