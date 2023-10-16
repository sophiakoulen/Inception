FROM alpine:3.17

RUN apk update && apk upgrade && apk add vsftpd

EXPOSE 20 21 990 5000-5042

COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

COPY tools/vsftpd-entrypoint.sh /

ENTRYPOINT ["/vsftpd-entrypoint.sh"]

ARG FTP_USER
ARG FTP_PASSWORD

RUN addgroup -g 4242 ftp_group && \ 
	adduser -S $FTP_USER -G ftp_group && \
	echo $FTP_USER:$FTP_PASSWORD | chpasswd

CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf", "-ovsftpd_log_file=/proc/1/fd/1"]

