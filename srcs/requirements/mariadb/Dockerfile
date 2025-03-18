# srcs/mariadb/Dockerfile

FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server	\
	&& rm -rf /var/lib/apt/lists/*

RUN sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/init_mariadb.sh /tmp/init_mariadb.sh

RUN chmod +x /tmp/init_mariadb.sh

ENTRYPOINT ["bash", "/tmp/init_mariadb.sh"]

#CMD ["mysqld"]
