FROM alpine:3.17

RUN apk add --no-cache nginx gettext

#copy config files
COPY conf/ /etc/nginx/http.d/

#copy SSL certificate
COPY certs/ /etc/nginx/certs

EXPOSE 443 8080

COPY tools/nginx-entrypoint.sh /

ENTRYPOINT ["/nginx-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
