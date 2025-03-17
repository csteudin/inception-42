# srcs/mariadb/Dockerfile
FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server tini \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/tini", "--"]