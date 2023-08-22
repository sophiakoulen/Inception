#!/bin/bash

#This script generates a root certificate that can be used to sign
#SSL certificates
#Usage: ./gen-root-certificate.sh [CA directory] [CA name]
#Exmaple ./gen-root-certificate.sh ../root-ca rootCA

if [[ $# -ne 2 ]]; then
	echo "Usage: $0 [CA directory] [CA name]"
	exit 2
fi

ca_dir=$1
ca_name=$2

mkdir -p $ca_dir

#create certificate authority
openssl req -x509 \
	-sha256 -days 365 \
	-nodes \
	-newkey rsa:2084 \
	-subj "/CN=skoulen.42.fr/C=CH/L=Bernex" \
	-keyout $ca_dir/$ca_name.key -out $ca_dir/$ca_name.crt
