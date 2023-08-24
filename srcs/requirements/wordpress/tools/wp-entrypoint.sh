#!/bin/bash

#create the config
echo "Creating wp-config..."
cd /var/www/html && wp config create \
	--allow-root \
	--skip-check \
	--dbname=$DB_NAME \
	--dbuser=$DB_USER \
	--dbpass=$DB_PASSWORD \
	--dbhost=mariadb

#creating users in database
echo "Proceding to install wordpress..."
cd /var/www/html && wp core install \
	--url=https://$DOMAIN \
	--title=$SITE_TITLE \
	--admin_user=$WP_ADMIN_USER \
	--admin_email=$WP_ADMIN_EMAIL \
	--admin_password=$WP_ADMIN_PWD \
	--allow-root

echo "Adding regular user to database..."
cd /var/www/html && wp user create $WP_REGULAR_USER $WP_REGULAR_EMAIL \
	--user_pass=$WP_REGULAR_PWD \
	--role=author \
	--allow-root

exec "$@"
