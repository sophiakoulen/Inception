FROM alpine:3.17

RUN apk add --no-cache lighttpd

COPY srcs/requirements/static-site/conf/lighttpd.conf /

COPY srcs/requirements/static-site/site/ /var/www/html

EXPOSE 8081

CMD ["lighttpd", "-D", "-f", "lighttpd.conf"]
