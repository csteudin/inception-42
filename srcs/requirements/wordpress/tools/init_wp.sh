#!/bin/sh

export WP_PASSWORD=$(cat /run/secrets/wp_password)
export WP_ROOT_PASSWORD=$(cat /run/secrets/wp_root_password)
export DB_PASSWORD=$(cat /run/secrets/db_password)


# checks if the folders are existing and creates them
# then also cleans the whole folder to set up a fresh wp config like we want it to be
mkdir -p /var/www/
mkdir -p /var/www/html
cd /var/www/html
rm -rf *

#TESTING IF PHP IS ABLE TO BE SEEN
mv /tmp/info.php .
ls -lrah
pwd

# here we creat the folder which has the php socket inside which is needed to connect with fpm
mkdir -p /run/php

#echo "> waiting for mariadb. . ."
#until mysqladmin ping -h "$DB_DATABASE" -u "$DB_USER" --password="$DB_PASSWORD" --silent; do
#	sleep 1
#done


sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf
echo "> php/fpm listens on port:9000 now"

#download this to use wordpress in cli


#move it into bin files so it can be used in cli

#add checks here if it is already installed and set up 
#download the wp core
wp core download --allow-root

# renaming the sample config so we can use it
mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# set up the credentials for the database
wp config set DB_NAME "$DB_DATABASE" --allow-root
wp config set DB_USER "$DB_USER" --allow-root
wp config set DB_PASSWORD "$DB_PASSWORD" --allow-root
wp config set DB_HOST "mariadb" --allow-root
#--skip-email is missin
wp core install --url=$DOMAIN --title=$WP_TITLE --admin_user=$WP_ROOT --admin_password=$WP_ROOT_PASSWORD --admin_email=$WP_ADMIN_MAIL --allow-root

wp redis enable --allow-root

chown -R www-data:www-data /var/www/html/

#create std usr

exec /usr/sbin/php-fpm7.4 -F
