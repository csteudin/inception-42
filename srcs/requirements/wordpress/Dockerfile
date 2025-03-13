# srcs/wordpress/Dockerfile
FROM debian:bullseye

RUN apt-get update && apt-get install -y php php-fpm php-mysql curl \
	&& rm -rf /var/lib/apt/lists/*