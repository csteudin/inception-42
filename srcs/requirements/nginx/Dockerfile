# srcs/nginx/Dockerfile

FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx openssl \
	&& rm -rf /var/lib/apt/lists/*

COPY ./cnf/default.conf /etc/nginx/conf.d/

COPY ./tools/init_nginx.sh /tmp/init_nginx.sh

RUN chmod +x /tmp/init_nginx.sh

RUN rm /etc/nginx/sites-enabled/*

ENTRYPOINT ["/tmp/init_nginx.sh"]
