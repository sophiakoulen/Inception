FROM alpine:3.17

RUN apk add --no-cache lighttpd zola

COPY conf/lighttpd.conf /

COPY tools/entrypoint.sh /

EXPOSE 8081

ENTRYPOINT ["./entrypoint.sh"]

CMD ["lighttpd", "-D", "-f", "lighttpd.conf"]
