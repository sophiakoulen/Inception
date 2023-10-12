# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: skoulen <skoulen@student.42lausann>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/08/22 11:55:07 by skoulen           #+#    #+#              #
#    Updated: 2023/10/04 14:08:01 by skoulen          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

include ./srcs/.env

#tool to execute a script with a .env file
ENV=			./srcs/requirements/tools/run-with-env.sh ./srcs/.env

ROOT_CA_DIR=	.secrets/root-ca/
ROOT_CA_NAME=	rootCA
ROOT_CA=		$(ROOT_CA_DIR)/$(ROOT_CA_NAME).crt

SSL_CERT_DIR=	./srcs/requirements/nginx/certs/
SSL_CERT_NAME=	$(DOMAIN)
SSL_CERT=		$(SSL_CERT_DIR)/$(SSL_CERT_NAME).crt

all: volumes self-signed-cert build up

#directories for the bind mounts
volumes:
	mkdir -p	${WORDPRESS_VOLUME} ${DATABASE_VOLUME}

rm-volumes:
	rm -rf		${WORDPRESS_VOLUME} ${DATABASE_VOLUME}


#generate self signed certificate
self-signed-cert: $(SSL_CERT)

root-cert: $(ROOT_CA)

rm-self-signed-cert:
	rm -rf $(SSL_CERT_DIR)

rm-root-cert:
	rm -rf $(ROOT_CA_DIR)

$(ROOT_CA_DIR):
	mkdir -p $@

$(SSL_CERT_DIR):
	mkdir -p $@

$(ROOT_CA): | $(ROOT_CA_DIR)
	$(ENV) ./srcs/requirements/nginx/tools/gen-root-certificate.sh $(ROOT_CA_DIR) $(ROOT_CA_NAME)

$(SSL_CERT): $(ROOT_CA) | $(SSL_CERT_DIR)
	$(ENV) ./srcs/requirements/nginx/tools/gen-self-signed-certificate.sh $(ROOT_CA_DIR) $(ROOT_CA_NAME) $(SSL_CERT_DIR)


#build all the containers
up: down $(SSL_CERT)
	 docker compose -f srcs/docker-compose.yml up -d

build: down $(SSL_CERT)
	 docker compose -f srcs/docker-compose.yml build

rebuild: down $(SSL_CERT)
	 docker compose -f srcs/docker-compose.yml build --no-cache

re: rebuild up

down:
	 docker compose -f srcs/docker-compose.yml down

logs:
	 docker compose -f srcs/docker-compose.yml logs


#building and running individual services
build-%:
	docker compose -f srcs/docker-compose.yml build	$*

up-%:
	docker compose -f srcs/docker-compose.yml up	$*

stop-%:
	docker compose -f srcs/docker-compose.yml stop	$*


.PHONY: all \
		volumes rm-volumes \
		self-signed-cert rm-self-signed-cert \
		root-cert rm-root-cert \
		build rebuild \
		re up down logs
