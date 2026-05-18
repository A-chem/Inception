#!/bin/bash

set -e



mkdir -p /var/www/html

cd /var/www/html

echo "Waiting for MariaDB..."

until mysqladmin ping \
    -h mariadb \
    -u"${MYSQL_USER}" \
    -p"${DB_PASSWORD}" \
    --silent
do
    sleep 2
done

echo "MariaDB is ready!"

if ! wp core is-installed --allow-root 2>/dev/null; then

    echo "Downloading WordPress..."

    wp core download --allow-root

    echo "Creating wp-config.php..."

    wp config create \
        --allow-root \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${DB_PASSWORD}" \
        --dbhost="mariadb:3306"

    echo "Installing WordPress..."

    wp core install \
        --allow-root \
        --url="https://${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}"

    echo "Creating normal user..."

    wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
        --allow-root \
        --user_pass="${WP_USER_PASSWORD}"

    echo "WordPress installed successfully!"

else

    echo "WordPress already installed."

fi

mkdir -p /run/php

echo "Starting PHP-FPM..."

exec php-fpm8.2 -F