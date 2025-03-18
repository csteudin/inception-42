#!/bin/sh

export DB_PASSWD=$(cat /run/secrets/db_passwd.txt)
export DB_ROOT_PASSWD=$(cat /run/secrets/db_root_passwd.txt)
# vielleicht mit ../secrets . . . versuchen

service mysql start

exec mysqld