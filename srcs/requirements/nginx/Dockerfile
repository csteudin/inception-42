# srcs/nginx/Dockerfile

FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT []

CMD ["bash"]

#RUN ["nginx"]