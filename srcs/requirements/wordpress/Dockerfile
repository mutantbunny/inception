FROM debian:bullseye

ARG MYSQL_HOST MYSQL_DATABASE MYSQL_USER MYSQL_PASSWORD

WORKDIR /var/www/html

RUN apt-get update && DEBIAN_FRONTEND=noninteractive \
apt-get install -y php-fpm php-mysql mariadb-client wget

RUN wget https://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz && \
rm latest.tar.gz && \
sed -i "s/^listen\s=.*/listen = 0.0.0.0:9000/g" /etc/php/7.4/fpm/pool.d/www.conf && \
mv ./wordpress/wp-config-sample.php ./wordpress/wp-config.php && \
sed -i "s/localhost/${MYSQL_HOST}/g" ./wordpress/wp-config.php && \
sed -i "s/database_name_here/${MYSQL_DATABASE}/g" ./wordpress/wp-config.php && \
sed -i "s/username_here/${MYSQL_USER}/g" ./wordpress/wp-config.php && \
sed -i "s/password_here/${MYSQL_PASSWORD}/g" ./wordpress/wp-config.php && \
mkdir -p /run/php

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]
