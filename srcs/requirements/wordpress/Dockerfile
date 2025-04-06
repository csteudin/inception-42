# srcs/wordpress/Dockerfile

FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y php7.4 php7.4-fpm php7.4-mysql curl \
	&& rm -rf /var/lib/apt/lists/*

COPY ./tools/init_wp.sh /tmp/init_wp.sh

COPY ./cnf/info.php /tmp/info.php

RUN chmod +x /tmp/init_wp.sh

ENTRYPOINT ["bash", "/tmp/init_wp.sh"]
