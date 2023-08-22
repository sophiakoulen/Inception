#!/bin/bash

#This script generates the nginx default.conf by replacing some environment
#variable in default.conf.template

if [[ $# -ne 1 ]]; then
	echo "Usage: $0 [nginx conf directory]"
	exit 2
fi

if [[ -z "$DOMAIN" ]]; then
	echo "Error: DOMAIN is blank."
	exit 1
fi

nginx_conf_dir=$1
sed s/DOMAIN/$DOMAIN/g $nginx_conf_dir/default.conf.template > $nginx_conf_dir/default.conf
