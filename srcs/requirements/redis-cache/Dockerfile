FROM alpine:3.17

RUN apk update && apk add redis && apk add redis

EXPOSE 6379

RUN mkdir /etc/redis && \
	mkdir /var/redis

ARG REDIS_PASSWORD

RUN wget https://raw.githubusercontent.com/redis/redis/7.0.12/redis.conf && \
	mv /redis.conf /etc/redis/redis.conf && \
	sed -i "s/bind 127.0.0.1 -::1/# bind 127.0.0.1 -::1/g" /etc/redis/redis.conf && \	
	sed -i "s/# requirepass foobared/requirepass $REDIS_PASSWORD/g" /etc/redis/redis.conf

COPY srcs/requirements/redis-cache/tools/redis-entrypoint.sh /

ENTRYPOINT ["/redis-entrypoint.sh"]

CMD ["redis-server", "/etc/redis/redis.conf"]
