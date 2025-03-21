#!/bin/sh

export DB_PASSWORD=$(cat /run/secrets/db_password)
export DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

#echo "DB_PASSWORD: $DB_PASSWORD"
#echo "DB_ROOT_PASSWORD: $DB_ROOT_PASSWORD"

mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};"
mysql -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${DB_DATABASE}.* TO '${DB_USER}'@'%';"
mysql -u${DB_ROOT_USER} -p${DB_ROOT_PASSWORD} -e "ALTER USER '${DB_ROOT_USER}'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

exec mysqld