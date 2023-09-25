#!/bin/sh

set -e

mv /adminer.php /var/www/adminer 

exec "$@"
