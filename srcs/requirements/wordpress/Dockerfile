FROM alpine:3.17

RUN apk add --no-cache bash curl ca-certificates tzdata zip \
    libmcrypt-dev zlib-dev gmp-dev \
    freetype-dev libjpeg-turbo-dev libpng-dev \
    php81-fpm php81-json php81-zlib php81-xml php81-xmlwriter php81-simplexml php81-pdo php81-phar php81-openssl \
    php81-pdo_mysql php81-mysqli php81-session \
    php81-gd php81-iconv php81-gmp php81-zip \
    php81-curl php81-opcache php81-ctype php81-apcu \
	php81-tokenizer \
	php81-intl php81-bcmath php81-dom php81-mbstring php81-xmlreader mysql-client mariadb-client && apk add -u musl && \
	rm -rf /var/cache/apk/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

RUN sed -i 's#^listen = 127.0.0.1:9000#listen = 9000#' /etc/php81/php-fpm.d/www.conf

COPY tools/wp-entrypoint.sh /

ENV SERVICE_NAME="wordpress"

RUN addgroup -g 4242 wordpress_group && \
	adduser $SERVICE_NAME --disabled-password -G wordpress_group && \
	touch /var/log/php81/error.log && \
	chown $SERVICE_NAME:wordpress_group /var/log/php81/error.log && \
	chmod 644 /var/log/php81/error.log

USER $SERVICE_NAME

ENTRYPOINT ["/wp-entrypoint.sh"]

EXPOSE 9000

CMD ["php-fpm81", "--nodaemonize"]
