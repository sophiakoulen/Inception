#!/bin/sh

set -e
defined_envs=$(printf '${%s} ' $(awk "END { for (name in ENVIRON) { print ( name ~ /${filter}/ ) ? name : \"\" } }" < /dev/null ))
FILES="/etc/nginx/http.d/*.template"
for template in $FILES
do
	output="${template%.*}"
	echo "template: $template"
	echo "output: $output"
	envsubst "$defined_envs" <$template  >$output
done

exec "$@"
