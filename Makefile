COMPOSE_FILE=./srcs/docker-compose.yml
DB_VOLUME_DIR=/home/coelho/data/mariadb
WP_VOLUME_DIR=/home/coelho/data/wordpress
HOSTS_FILE=/etc/hosts

all: up

host:
	grep -qx "127\.0\.0\.1[[:space:]]gmachado\.42\.fr" ${HOSTS_FILE} \
	|| echo "127.0.0.1\tgmachado.42.fr" >> ${HOSTS_FILE}

mk_vols:
	mkdir -p ${DB_VOLUME_DIR}
	mkdir -p ${WP_VOLUME_DIR}

build: mk_vols host
	docker-compose -f ${COMPOSE_FILE} build

up:
	docker-compose -f ${COMPOSE_FILE} up -d

down:
	docker-compose -f ${COMPOSE_FILE} down

clean: down
	docker-compose -f ${COMPOSE_FILE} rm -s -f

fclean: down
	docker-compose -f ${COMPOSE_FILE} rm -s -v -f

.PHONY: all build clean down fclean host mk_vols up
