#!/bin/bash

RESULT=`mysql -u root --skip-column-names -e "SHOW DATABASES LIKE '${MYSQL_DATABASE}'"`
if [ "$RESULT" = "${MYSQL_DATABASE}" ]; then
	echo "Database exists"
else
	echo "Database does not exist. Creating..."
	mysql -u root <<MYSQL_SCRIPT
USE mysql;
ALTER USER 'root'@'localhost' IDENTIFIED with mysql_native_password;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT SELECT, INSERT, UPDATE, DELETE ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
MYSQL_SCRIPT
fi
