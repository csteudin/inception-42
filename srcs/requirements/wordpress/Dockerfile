# srcs/wordpress/Dockerfile

FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y php7.4 iputils-ping php7.4-fpm php7.4-mysql curl mariadb-client\
	&& rm -rf /var/lib/apt/lists/*

COPY ./cnf/info.php /tmp/info.php
RUN chmod +x /tmp/info.php

COPY ./tools/init_wp.sh /tmp/init_wp.sh
RUN chmod +x /tmp/init_wp.sh

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp




ENTRYPOINT ["bash", "/tmp/init_wp.sh"]
