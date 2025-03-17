# srcs/wordpress/Dockerfile
FROM debian:bullseye

RUN apt-get update && apt-get install -y php php-fpm php-mysql curl tini \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/tini", "--"]

# Passwort aus Secret lesen
#RUN export DB_PASSWORD=$(cat /run/secrets/db_password) \
#&& export DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
