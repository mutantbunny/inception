FROM debian:bullseye

RUN apt-get update && DEBIAN_FRONTEND=noninteractive \
apt-get install -y nginx openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/ssl/private/nginx-selfsigned.key \
-out /etc/ssl/certs/nginx-selfsigned.crt \
-subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=42/OU=42 SP/CN=gmachado.42.fr"

COPY ./conf/nginx.conf /etc/nginx/conf.d/

EXPOSE 443

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
