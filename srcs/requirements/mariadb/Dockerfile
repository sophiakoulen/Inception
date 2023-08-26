FROM alpine:3.17

RUN apk update && apk add mariadb mariadb-client

COPY srcs/requirements/mariadb/conf/mariadb-server.cnf /etc/mysql
COPY srcs/requirements/mariadb/conf/mariadb-server.cnf /etc/my.cnf

COPY srcs/requirements/mariadb/tools/mariadb-entrypoint.sh /

EXPOSE 3306

ENTRYPOINT ["/mariadb-entrypoint.sh"]

CMD ["mysqld", "--user=root"]
