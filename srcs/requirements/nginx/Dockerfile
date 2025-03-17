# srcs/nginx/Dockerfile
FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx tini \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/tini", "--"]