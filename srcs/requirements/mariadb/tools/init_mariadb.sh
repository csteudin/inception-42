#!/bin/sh

mysqld &
export DB_PID=$!

echo $DB_PID

sleep 15

export DB_PASSWORD=$(cat /run/secrets/db_password)
export DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$DB_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

mysql -u root -p"$DB_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};"
mysql -u root -p"$DB_ROOT_PASSWORD" -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -u root -p"$DB_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON ${DB_DATABASE}.* TO '${DB_USER}'@'%';"
mysql -u root -p"$DB_ROOT_PASSWORD" -e "ALTER USER '${DB_ROOT_USER}'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
mysql -u root -p"$DB_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

wait