#!/bin/sh

DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
DB_INITALIZED="/var/lib/mysql/inited"

if [ ! -d "/var/lib/mysql/mysql"]; then
	mkdir -p /var/lib/mysql
	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

if [ ! -f "$DB_INITIALIZED"]; then
	
	mysql --user=mysql --datadir=/var/lib/mysql &
	DB_PID=$!
	
	while ! mysqladmin ping --silent; do
		sleep 2
	done

	echo "CREATE DATABASE IF NOT EXISTS $DB_DATABASE ;" > db1.sql
	echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD' ;" >> db1.sql
	echo "GRANT ALL PRIVILEGES ON $DB_DATABASE.* TO '$DB_USER'@'%' ;" >> db1.sql
	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD' ;" >> db1.sql
	echo "FLUSH PRIVILEGES;" >>  db1.sql

	mysql < db1.sql

	mysqladmin shutdown
	wait "$DB_PID" || true

	touch $DB_INITALIZED
fi

exec mysql --user=mysql --console