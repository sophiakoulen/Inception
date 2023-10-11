#!/bin/sh

set -e

rm -f /var/www/zola/content/README.md
cat > /var/www/zola/content/README.md <<-EOF
+++
date = $(date '+%Y-%m-%d')
title = "README"
+++
EOF

cat /README.md >> /var/www/zola/content/README.md

rm -rf /var/www/html

zola --root /var/www/zola build --output-dir /var/www/html

exec "$@"
