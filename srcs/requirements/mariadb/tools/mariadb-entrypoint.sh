#!/bin/sh


mariadb-install-db --basedir=/usr  --datadir=/var/lib/mysql

mariadbd-safe --datadir='/var/lib/mysql' --no-watch

chmod -R 755 /var/run/mysqld
chmod -R 755 /var/lib/mysql

mariadb <<-EOF
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED VIA '' USING PASSWORD('$DB_ROOT_PASSWORD');
EOF

exec "$@"
