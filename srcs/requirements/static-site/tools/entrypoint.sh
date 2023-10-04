#!/bin/sh

set -e

zola --root /var/www/zola build --output-dir /var/www/zola/public

exec "$@"
