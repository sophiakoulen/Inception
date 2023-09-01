FROM alpine:3.17

RUN apk update && apk add redis

EXPOSE 6379

RUN mkdir /etc/redis && \
	mkdir /var/redis

#COPY srcs/requirements/redis-cache/tools/redis_init_script /etc/init.d/redis_6379

COPY srcs/requirements/redis-cache/conf/redis.conf /etc/redis/redis.conf

#RUN mkdir /var/redis/6379

#RUN update-rc.d redis_6379 defaults

COPY srcs/requirements/redis-cache/tools/redis-entrypoint.sh /

ENTRYPOINT ["/redis-entrypoint.sh"]

CMD ["redis-server", "/etc/redis/redis.conf"]
