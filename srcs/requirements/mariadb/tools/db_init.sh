#!/bin/bash

/usr/bin/mysqld_safe --skip-grant-tables &

while ! nc -z localhost 3306; do sleep 1; done

RESULT=`mysql -u root --skip-column-names -e "SHOW DATABASES LIKE '${MYSQL_DATABASE}'"`
if [ "$RESULT" = "${MYSQL_DATABASE}" ]; then
	echo "Database exists"
else
	echo "Database does not exist. Creating..."
	mysql -uroot <<MYSQL_SCRIPT
USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED with mysql_native_password;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

sed -i "s/{WP_ADM_USER}/${WP_ADM_USER}/g" dump.sql
sed -i "s@{WP_ADM_HASH}@${WP_ADM_HASH}@g" dump.sql
sed -i "s/{WP_USER}/${WP_USER}/g" dump.sql
sed -i "s/{WP_HASH}/${WP_HASH}/g" dump.sql

grep "INSERT INTO \`wp_users\` VALUES" dump.sql

mysql -uroot -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE} < dump.sql

fi
