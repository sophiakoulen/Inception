FROM alpine:3.17

RUN apk update && apk add mariadb mariadb-client

COPY tools/mariadb-entrypoint.sh /

EXPOSE 3306

ENTRYPOINT ["/mariadb-entrypoint.sh"]

CMD ["mariadbd", "--user=root"]
