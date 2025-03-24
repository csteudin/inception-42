#!/bin/sh

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

exec /usr/sbin/php-fpm7.3 -F
