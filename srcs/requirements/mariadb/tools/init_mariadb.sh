#!/bin/sh

mysqld &
export DB_PID=$!

echo $DB_PID

while ! mysqladmin ping --silent; do
	sleep 2
done

export DB_PASSWORD=$(cat /run/secrets/db_password)
export DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

echo "CREATE DATABASE IF NOT EXISTS $DB_DATABASE ;" > db1.sql
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD' ;" >> db1.sql
echo "GRANT ALL PRIVILEGES ON $DB_DATABASE.* TO '$DB_USER'@'%' ;" >> db1.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD' ;" >> db1.sql
echo "FLUSH PRIVILEGES;" >>  

mysql < db1.sql

#mysql -u root <<EOF
#ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$DB_ROOT_PASSWORD';
#FLUSH PRIVILEGES;
#EOF

#mysql -u root -p"$DB_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};"
#mysql -u root -p"$DB_ROOT_PASSWORD" -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
#mysql -u root -p"$DB_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON ${DB_DATABASE}.* TO '${DB_USER}'@'%';"
#mysql -u root -p"$DB_ROOT_PASSWORD" -e "ALTER USER '${DB_ROOT_USER}'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
#mysql -u root -p"$DB_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

wait