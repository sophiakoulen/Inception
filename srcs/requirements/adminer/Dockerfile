FROM alpine:3.17

RUN apk add --no-cache \
		curl \
		php81-fpm \
		php81-session \
		php81-pdo_mysql

RUN curl -fsSL https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -o adminer.php

RUN sed -i 's#^listen = 127.0.0.1:9000#listen = 9001#' /etc/php81/php-fpm.d/www.conf

EXPOSE 9001

COPY srcs/requirements/adminer/tools/entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm81", "--nodaemonize"]

