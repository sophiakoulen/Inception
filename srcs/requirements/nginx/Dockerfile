FROM alpine:3.17

RUN apk add --no-cache nginx bash

#copy config file
COPY srcs/requirements/nginx/conf/default.conf /etc/nginx/http.d/default.conf

#copy SSL certificate
COPY .secrets/certs/ /etc/nginx/certs

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
