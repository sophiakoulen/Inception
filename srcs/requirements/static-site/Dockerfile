FROM alpine:3.17

RUN apk add --no-cache lighttpd zola

COPY srcs/requirements/static-site/conf/lighttpd.conf /

COPY README.md /README.md

COPY srcs/requirements/static-site/tools/entrypoint.sh /

EXPOSE 8081

ENTRYPOINT ["./entrypoint.sh"]

CMD ["lighttpd", "-D", "-f", "lighttpd.conf"]
