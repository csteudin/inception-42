# srcs/wordpress/Dockerfile

FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y php php-fpm php-mysql curl \
	&& rm -rf /var/lib/apt/lists/*

COPY ./tools/init_wp.sh /tmp/init_wp.sh


ENTRYPOINT ["bash", "/tmp/init_wp.sh"]
