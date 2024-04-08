FROM debian:bullseye

ARG MYSQL_DATABASE MYSQL_USER MYSQL_PASSWORD MYSQL_ROOT_PASSWORD

RUN apt-get update && DEBIAN_FRONTEND=noninteractive \
apt-get install -y mariadb-server

RUN echo "[mysqld]\n\
skip-networking=0\n\
bind-address=0.0.0.0\n" >> /etc/mysql/my.cnf

RUN mkdir -p /var/run/mysqld && \
chown -R mysql:mysql /var/run/mysqld && \
chmod 777 /var/run/mysqld

COPY ./tools/db_init.sh .

RUN service mariadb start && ./db_init.sh && rm -f db_init.sh

EXPOSE 3306

CMD ["mysqld_safe"]
