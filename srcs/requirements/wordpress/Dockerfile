FROM alpine

RUN apk update && apk add bash && apk add curl && apk add php

COPY srcs/requirements/wordpress/tools/install-wp-cli.sh /

RUN ["/bin/bash", "/install-wp-cli.sh"]

RUN ["/bin/bash", "wp core download"]
