#!/bin/bash

wp create user $WP_ADMIN_USER $WP_ADMIN_EMAIL \
	--user_pass=$WP_ADMIN_PWD \
	--role=administrator \
	--allow-root --path=/var/www/html 

wp create user $WP_REGULAR_USER $WP_REGULAR_EMAIL \
	--user_pass=$WP_REGULAR_PWD \
	--role=author \
	--allow-root --path=/var/www/html 
