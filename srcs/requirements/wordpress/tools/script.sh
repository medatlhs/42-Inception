#!/bin/bash

mkdir -p /var/www/html
chmod -R 755 /var/www/html 
cd /var/www/html

if echo "${WP_ADMIN}" | grep -iq admin; then
    echo "WP_ADMIN can't contain 'admin' !";
	exit 1
fi

if [ ! -f "wp-config.php" ]; then
    wp core download --allow-root

    wp config create \
        --dbuser="$WP_DB_USER_NAME" \
        --dbpass="$WP_DB_PASSWORD" \
        --dbname="$WP_DB_NAME" \
        --dbhost="$WP_DB_HOST" \
        --allow-root

    wp core install \
        --url="$WP_URL" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN" \
        --admin_password="$WP_ADMIN_PASS" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root

    wp user create "$WP_USR" "$WP_USR_EMAIL" \
        --role="$WP_USR_ROLE" \
        --user_pass="$WP_USR_PASS" \
        --allow-root
fi

chown -R www-data:www-data /var/www/html

sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/8.2/fpm/pool.d/www.conf

exec php-fpm8.2 -F
