FROM alpine:3.17

RUN apk add --no-cache nginx

#copy config file
COPY srcs/requirements/nginx/conf/default.conf /etc/nginx/http.d/default.conf

#copy SSL certificate
COPY .secrets/certs/ /etc/nginx/certs

EXPOSE 443

COPY srcs/requirements/nginx/tools/nginx-entrypoint.sh /

ENTRYPOINT ["/nginx-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
