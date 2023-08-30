#!/bin/bash

download_wp()
{
	if test -f "/var/www/html/wp-config-sample.php"; then
		echo "wp-config-sample.php exists! Not downloading wordpress."
	else
		echo "wp-config-sample.php not found. Let's download wordpress."
		wp core download --path=/var/www/html
	fi
}

create_config()
{
	if test -f "/var/www/html/wp-config.php"; then
		echo "wp-config.php already exists! Not recreating it."
	else
		echo "Creating wp-config.php because it doesn't exist..."
		cd /var/www/html && wp config create \
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
		--admin_email=$WP_ADMIN_EMAIL
}

config_users()
{
	wp user get $WP_REGULAR_USER ||
	(
		echo "Adding regular user to database..."
		cd /var/www/html && wp user create $WP_REGULAR_USER $WP_REGULAR_EMAIL \
			--user_pass=$WP_REGULAR_PWD \
			--role=author
	)
}

setup_redis()
{
	wp config set WP_REDIS_PATH --raw "__DIR__ . '/../redis.sock'"
	wp config set WP_REDIX_SCHEME "unix"
	wp plugin install redis-cache --activate
}

# Setup wordpress
# If any step fails, the script will fail.
# (That's what set -e does)

set -e

download_wp
create_config
core_install
config_users
setup_redis

exec "$@"
