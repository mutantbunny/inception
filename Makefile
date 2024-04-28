COMPOSE_FILE=./srcs/docker-compose.yml
DB_VOLUME_DIR= /home/coelho/data/mariadb
WP_VOLUME_DIR= /home/coelho/data/wordpress

all: down build up

up: vols
	docker-compose -f ${COMPOSE_FILE} up -d

build: vols
	docker-compose -f ${COMPOSE_FILE} build --no-cache

vols:
	mkdir -p ${DB_VOLUME_DIR}
	mkdir -p ${WP_VOLUME_DIR}

down:
	docker-compose -f ${COMPOSE_FILE} down

clean:
	docker-compose -f ${COMPOSE_FILE} rm -s -f

fclean: down
	docker-compose -f ${COMPOSE_FILE} rm -s -f -v
	rm -rf ${DB_VOLUME_DIR}
	rm -rf ${WP_VOLUME_DIR}

.PHONY: all build clean down fclean vols up
