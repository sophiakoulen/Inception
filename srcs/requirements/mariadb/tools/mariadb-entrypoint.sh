#!/bin/sh

set -e

mariadb-install-db --user=root --basedir=/usr --datadir=/var/lib/mysql

mkdir -p /run/mysqld

#delete empty user
#delete remote root user
#set a root password
#create wordpress database
#create wordpress user for the database
#give that user access to the wordpress database

mariadbd --user=root --bootstrap <<-EOF
FLUSH PRIVILEGES;

USE mysql;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';

CREATE DATABASE IF NOT EXISTS $DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED by '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';

FLUSH PRIVILEGES;
EOF

sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

exec "$@"
