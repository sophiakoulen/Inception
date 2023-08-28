# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: skoulen <skoulen@student.42lausann>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/08/22 11:55:07 by skoulen           #+#    #+#              #
#    Updated: 2023/08/28 10:43:18 by skoulen          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

include ./srcs/.env

#tool to execute a script with a .env file
ENV=			./srcs/requirements/tools/run-with-env.sh ./srcs/.env

ROOT_CA_DIR=	.secrets/root-ca/
ROOT_CA_NAME=	rootCA
ROOT_CA=		$(ROOT_CA_DIR)/$(ROOT_CA_NAME).crt

SSL_CERT_DIR=	.secrets/certs/
SSL_CERT_NAME=	$(DOMAIN)
SSL_CERT=		$(SSL_CERT_DIR)/$(SSL_CERT_NAME).crt

NGINX_CONF_FILE=./srcs/requirements/nginx/conf/default.conf

all: self-signed-cert nginx-conf

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

rm-nginx-conf:
	rm -f $(NGINX_CONF_FILE)

nginx-conf:
	$(ENV) ./srcs/requirements/nginx/tools/gen-nginx-conf.sh $(dir $(NGINX_CONF_FILE))

up: down $(SSL_CERT) nginx-conf
	 docker compose -f srcs/docker-compose.yml up -d

build: down $(SSL_CERT) nginx-conf
	 docker compose -f srcs/docker-compose.yml build

rebuild: down $(SSL_CERT) nginx-conf
	 docker compose -f srcs/docker-compose.yml build --no-cache

re: rebuild up

down:
	 docker compose -f srcs/docker-compose.yml down

logs:
	 docker compose -f srcs/docker-compose.yml logs

.PHONY: all self-signed-cert root-cert rm-self-signed-cert rm-root-cert 
