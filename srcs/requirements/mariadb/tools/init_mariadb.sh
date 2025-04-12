#!/bin/sh

#set -eo pipefail
set -e pipefail

DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
DB_INITIALIZED="/var/lib/mysql/inited"

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
	mkdir -p /var/lib/mysql
	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

if [ ! -f "$DB_INITIALIZED" ]; then
	echo "> starting mysql daemon in background"
	mysqld_safe --user=mysql --datadir=/var/lib/mysql &
	DB_PID="$!"
	
	while ! mysqladmin ping --silent; do
		sleep 2
	done

	echo "CREATE DATABASE IF NOT EXISTS $DB_DATABASE ;" > db1.sql
	echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD' ;" >> db1.sql
	echo "GRANT ALL PRIVILEGES ON $DB_DATABASE.* TO '$DB_USER'@'%' ;" >> db1.sql
	echo "FLUSH PRIVILEGES;" >>  db1.sql
	echo "> parsing input into mysql"
	mysql < db1.sql

	mysqladmin shutdown
	wait "$DB_PID" || true

	touch $DB_INITIALIZED
	echo "> database initialized"
fi

echo "> executing mysql"