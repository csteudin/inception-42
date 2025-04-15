#!/bin/sh

set -e

export WP_PASSWORD=$(cat /run/secrets/wp_password)
export WP_ROOT_PASSWORD=$(cat /run/secrets/wp_root_password)
export DB_PASSWORD=$(cat /run/secrets/db_password)

# here we creat the folder which has the php socket inside which is needed to connect with fpm
mkdir -p /run/php

sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf
echo "> php/fpm listens on port:9000 now"

echo "> waiting for mariadb. . ."
until mysqladmin ping -h "mariadb" -u "$DB_USER" --password="$DB_PASSWORD" --silent; do
	sleep 1
done

if [ ! -f "/var/www/html/wp-config.php" ]; then
echo "> making a fresh WP installation"

# checks if the folders are existing and creates them
# then also cleans the whole folder to set up a fresh wp config like we want it to be
mkdir -p /var/www/
mkdir -p /var/www/html
cd /var/www/html
rm -rf *

#add checks here if it is already installed and set up 
#download the wp core
wp core download --allow-root

wp config create \
	--dbname="${DB_DATABASE}"\
	--dbhost="mariadb:3306"\
	--dbuser="${DB_USER}"\
	--dbpass="${DB_PASSWORD}"\
	--allow-root

wp config set WP_HOME 'https://csteudin.42.fr' --allow-root
wp config set WP_SITEURL 'https://csteudin.42.fr' --allow-root

# the main wp install
wp core install \
	--url="https://$DOMAIN"\
	--title=${WP_NAME}\
	--admin_user=${WP_ROOT}\
	--admin_password=${WP_ROOT_PASSWORD}\
	--admin_email=${WP_ADMIN_MAIL}\
	--allow-root

# creation of the wp user
wp user create "${WP_USER}" "${WP_EMAIL}" --user_pass="${WP_PASSWORD}" --allow-root

#instals and activates the astra wp theme  DOES NOT WORK !
#wp theme install astra --activate --allow-root
#wp theme activate astra --allow-root
#wp theme update astra --allow-root

wp redis enable --allow-root
chown -R www-data:www-data /var/www/html/
chown -R www-data:www-data /var/www/html/wp-content
chmod -R 755 /var/www/html/wp-content

#TESTING IF PHP IS ABLE TO BE SEEN
mv /tmp/info.php /var/www/html/info.php

fi

echo "> letting php handler run"
exec /usr/sbin/php-fpm7.4 -F
