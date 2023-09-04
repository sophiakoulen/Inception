FROM alpine:3.17

RUN apk update && apk upgrade  && apk add vsftpd

EXPOSE 20 21

COPY srcs/requirements/vsftpd/conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

COPY srcs/requirements/vsftpd/tools/vsftpd-entrypoint.sh /

ENTRYPOINT ["/vsftpd-entrypoint.sh"]

CMD ["vsftpd"]

