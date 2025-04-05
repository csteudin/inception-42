# srcs/mariadb/Dockerfile

FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-server	\
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY ./cnf/50-server.cnf  /etc/mysql/mariadb.conf.d/

#RUN sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/init_mariadb.sh /tmp/init_mariadb.sh

RUN chmod +x /tmp/init_mariadb.sh

ENTRYPOINT ["/tmp/init_mariadb.sh"]
