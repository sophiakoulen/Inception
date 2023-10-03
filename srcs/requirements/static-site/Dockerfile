FROM alpine:3.17

RUN apk add --no-cache lighttpd

COPY conf/lighttpd.conf /

COPY site/ /var/www/html

EXPOSE 8081

CMD ["lighttpd", "-D", "-f", "lighttpd.conf"]
