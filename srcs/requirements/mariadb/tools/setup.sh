#!/bin/bash

set -e

DB_PASSWORD=$(cat /run/secrets/db_password)
ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

# Initialize database only first time

    echo "Initializing MariaDB..."

    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    echo "Starting temporary MariaDB..."

    mysqld_safe --skip-networking &

    sleep 5

    echo "Configuring database..."

    mysql << EOF

ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';

CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';

GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

FLUSH PRIVILEGES;

EOF

    echo "Stopping temporary MariaDB..."

    mysqladmin -u root -p"${ROOT_PASSWORD}" shutdown



echo "Starting MariaDB..."

exec mysqld_safe