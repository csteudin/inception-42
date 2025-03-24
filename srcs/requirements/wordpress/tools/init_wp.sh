#!/bin/sh

export WP_PASSWORD=$(cat /run/secrets/wp_password)
export WP_ROOT_PASSWORD=$(cat /run/secrets/wp_root_password)
export DB_PASSWORD=$(cat /run/secrets/db_password)


mkdir -p /var/www/
mkdir -p /var/www/html
cd /var/www/html

rm -rf *

#download this to use wordpress in cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

#move it into bin files so it can be used in cli
mv wp-cli.phar /usr/local/bin/wp

#download the wp core
wp core download --allow-root

mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# set up the credentials for the database
wp config set DB_NAME "$DB_DATABASE" --allow-root
wp config set DB_USER "$DB_USER" --allow-root
wp config set DB_PASSWORD "$DB_PASSWORD" --allow-root
wp config set DB_HOST "mariadb" --allow-root
#--skip-email is missin
wp core install --url=$DOMAIN/ --title-$WP_TITLE --admin_user=$WP_ROOT --admin_password=$WP_ROOT_PASSWORD --admin_email=$WP_ADMIN_MAIL --allow-root

exec /usr/sbin/php-fpm7.3 -F
