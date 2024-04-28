FROM debian:bullseye

ARG MYSQL_DATABASE MYSQL_USER MYSQL_PASSWORD MYSQL_ROOT_PASSWORD WP_USER WP_HASH WP_ADM_USER WP_ADM_HASH

RUN apt-get update && DEBIAN_FRONTEND=noninteractive \
apt-get install -y mariadb-server netcat

RUN echo "[mysqld]\n\
skip-networking=0\n\
bind-address=0.0.0.0\n" >> /etc/mysql/my.cnf && \
mkdir -p /var/run/mysqld && \
chown -R mysql:mysql /var/run/mysqld && \
mkdir -p /var/lib/mysql && \
chown -R mysql:mysql /var/lib/mysql && \
mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY ./tools/db_init.sh .
COPY ./conf/dump.sql .

RUN ./db_init.sh && rm -f db_init.sh dump.sql

EXPOSE 3306

CMD ["mysqld_safe"]
