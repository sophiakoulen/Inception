#!/bin/bash

create_config()
{
	if test -f "/var/www/html/wp-config.php"; then
		echo "wp-config.php already exists! Not recreating it."
	else
		echo "Creating wp-config.php because it doesn't exist..."
		cd /var/www/html && wp config create \
			--allow-root \
			--force \
			--dbname=$DB_NAME \
			--dbuser=$DB_USER \
			--dbpass=$DB_PASSWORD \
			--dbhost=mariadb
	fi
}

core_install()
{
	echo "Proceding to install wordpress..."
	cd /var/www/html && wp core install \
		--url=https://$DOMAIN \
		--title="$SITE_TITLE" \
		--admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PWD \
		--admin_email=$WP_ADMIN_EMAIL \
		--allow-root
}

config_users()
{
	wp user get $WP_REGULAR_USER ||
	(
		echo "Adding regular user to database..."
		cd /var/www/html && wp user create $WP_REGULAR_USER $WP_REGULAR_EMAIL \
			--user_pass=$WP_REGULAR_PWD \
			--role=author \
			--allow-root
	)
}

# Try to setup wordpress. If it fails, we want the container to restart
create_config && core_install && config_users || exit 1

exec "$@"
