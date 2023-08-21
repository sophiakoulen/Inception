#!/bin/bash

domain=skoulen.42.fr
commonname="Sophia Koulen"
country=CH
state=Geneva
locality=Bernex
organization=42Lausanne
organizationalunit=""
email=sophia.koulen@outlook.com

#need to put this in environment!
password=secret

rm -rf ../certs
mkdir -p ../certs

#create certificate authority
openssl req -x509 \
	-sha256 -days 365 \
	-nodes \
	-newkey rsa:2084 \
	-subj "/CN=skoulen.42.fr/C=CH/L=Bernex" \
	-keyout ../certs/rootCA.key -out ../certs/rootCA.crt

#create the server private key
openssl genrsa -out ../certs/$domain.key 2048

#create certificate signing request using server private key
openssl req -new -key ../certs/$domain.key -out ../certs/$domain.csr \
	-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"

#create configuration for the ssl certificate
cat > ../certs/cert.conf << EOF

authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = skoulen.42.fr

EOF

#generate certificate
openssl x509 -req \
	-in ../certs/$domain.csr \
	-CA ../certs/rootCA.crt -CAkey ../certs/rootCA.key \
	-CAcreateserial -out ../certs/$domain.crt \
	-days 365 \
	-sha256 -extfile ../certs/cert.conf
