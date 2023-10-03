FROM alpine:3.17

RUN apk update && apk upgrade && apk add vsftpd

EXPOSE 20 21 990 5000-5042

COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

COPY tools/vsftpd-entrypoint.sh /

ENTRYPOINT ["/vsftpd-entrypoint.sh"]

ARG FTP_USER
ARG FTP_PASSWORD

RUN addgroup -S $FTP_USER && \
	 adduser -S $FTP_USER -G $FTP_USER && \
	 echo $FTP_USER:$FTP_PASSWORD | chpasswd

#USER $FTP_USER

CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]

