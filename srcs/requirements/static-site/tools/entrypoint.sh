#!/bin/sh

set -e

rm -rf /var/www/zola/public
zola --root /var/www/zola build --output-dir /var/www/zola/public

exec "$@"
