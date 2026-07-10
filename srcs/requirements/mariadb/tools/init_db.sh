#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."

    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    mariadbd --user=mysql --skip-networking &
    PID=$!

    until mysqladmin ping --silent
    do
        sleep 1
    done

    mysql << EOF
ALTER USER 'root'@'localhost'
IDENTIFIED BY '$(cat /run/secrets/db_root_password)';

CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%'
IDENTIFIED BY '$(cat /run/secrets/db_password)';

GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';

FLUSH PRIVILEGES;
EOF

    mysqladmin \
        -uroot \
        -p"$(cat /run/secrets/db_root_password)" \
        shutdown

    wait "$PID"
fi

exec mariadbd --user=mysql
