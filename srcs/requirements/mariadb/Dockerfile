# srcs/mariadb/Dockerfile
FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server \
	&& rm -rf /var/lib/apt/lists/*