PACKAGE="hiracchi/squid"
TAG=latest
CONTAINER_NAME="squid"

.PHONY: all build

all: build

build:
	docker build -t "${PACKAGE}:${TAG}" . 2>&1 | tee build.log

start:
	docker run -d \
		--rm \
		--name ${CONTAINER_NAME} \
		-p "3128:3128" \
		"${PACKAGE}:${TAG}" ${ARG}

stop:
	docker rm -f ${CONTAINER_NAME}


restart: stop start


term:
	docker exec -it ${CONTAINER_NAME} /bin/bash


logs:
	docker logs -f ${CONTAINER_NAME}
