NODE_VERSION=20
CONTAINER=docker
DEV_PORT=3000

dev:
	${CONTAINER} run -it -v ./starkade-web:/usr/src/app -w /usr/src/app -p ${DEV_PORT}:3000 docker.io/library/node:${NODE_VERSION} npm run dev

install:
	${CONTAINER} run -v ./starkade-web:/usr/src/app -w /usr/src/app docker.io/library/node:${NODE_VERSION} npm install

.PHONY: dev install
