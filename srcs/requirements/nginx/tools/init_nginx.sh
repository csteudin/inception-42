#!/bin/sh

set -e

if [ ! -f "$SSL_PATH/nginx-selfsigned.crt" ]; then
    echo "> creating SSL cerfitikate"
    mkdir -p $SSL_PATH
    openssl req -x509 \
		-nodes \
		-days 365 \
        -newkey rsa:2048 \
        -keyout "$SSL_PATH/nginx-selfsigned.key" \
        -out "$SSL_PATH/nginx-selfsigned.crt" \
        -subj "/C=DE/ST=Baden-Württemberg/L=Heilbronn/O=csteudin/CN=Inception"
fi

echo "> executing nginx"

exec nginx -g "daemon off;"