+++
title = "Nginx"
weight = 1
date = 2023-10-07
+++

## About
Nginx is a webserver.
We will use an instance of nginx to serve our wordpress files.

## Dockerfile

```Dockerfile
FROM alpine:3.17

RUN apk add --no-cache nginx gettext

#copy config files
COPY conf/ /etc/nginx/http.d/

#copy SSL certificate
COPY certs/ /etc/nginx/certs

EXPOSE 443 8080

COPY tools/nginx-entrypoint.sh /

ENTRYPOINT ["/nginx-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
```

## Entrypoint
```sh
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
```

## config

```nginx
server {
	server_name			${DOMAIN};
    
	listen 				443 ssl;
	listen				[::]:443 ssl;
	
	ssl_certificate		/etc/nginx/certs/${DOMAIN}.crt;
	ssl_certificate_key	/etc/nginx/certs/${DOMAIN}.key;
	ssl_protocols		TLSv1.2 TLSv1.3;
	ssl_certificate_key	HIGH:!aNULL:!MD5;

    access_log  /var/log/nginx/wp.access.log;
    error_log   /var/log/nginx/wp.error.log;

	root /var/www/html;
    index index.php; 

    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    rewrite /wp-admin$ $scheme://$host$uri/ permanent;

    location ~ \.php$ {
		try_files $uri =404;
		fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass   wordpress:9000;
        fastcgi_index  index.php; 
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO       $fastcgi_path_info;
        fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;
    } 
}
```