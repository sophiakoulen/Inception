#!/bin/bash

#This script generates a self-signed SSL certificate.
#Location and name of root certificate must be specified as
#First and second argument.
#Example: ./gen-self-signed-certificate.sh ../root-certificates rootCA ../certs

if [[ $# -ne 3 ]]; then
	echo "Usage: $0 [CA directory] [CA name] [Dest directory]"
	exit 2
fi

ca_dir=$1
ca_name=$2
certs_dir=$3

if [[ -z "$DOMAIN" ]]; then
	echo "Error: DOMAIN environment variable is blank."
	exit 1
fi

#info for the certificate
domain=$DOMAIN
commonname="Sophia Koulen"
country=CH
state=Geneva
locality=Bernex
organization=42Lausanne
organizationalunit=""
email=sophia.koulen@outlook.com

rm -rf		$certs_dir
mkdir -p	$certs_dir

#create the server private key
openssl genrsa -out $certs_dir/$domain.key 2048

#create certificate signing request using server private key
openssl req -new -key $certs_dir/$domain.key -out $certs_dir/$domain.csr \
	-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"

#create configuration for the ssl certificate
cat > $certs_dir/cert.conf << EOF

authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = $domain

EOF

#generate certificate
openssl x509 -req \
	-in $certs_dir/$domain.csr \
	-CA $ca_dir/$ca_name.crt -CAkey $ca_dir/$ca_name.key \
	-CAcreateserial -out $certs_dir/$domain.crt \
	-days 365 \
	-sha256 -extfile $certs_dir/cert.conf
