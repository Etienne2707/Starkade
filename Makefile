NODE_VERSION = 20
CONTAINER = docker
DEV_PORT = 3000
DOJO_VERSION = 0.7.1

dev:
	${CONTAINER} run -it -v ./starkade-web:/usr/src/app -w /usr/src/app -p ${DEV_PORT}:3000 docker.io/library/node:${NODE_VERSION} npm run dev

install:
	${CONTAINER} run -v ./starkade-web:/usr/src/app -w /usr/src/app docker.io/library/node:${NODE_VERSION} npm install

build_dojo:
	${CONTAINER} build -f Containerfile --build-arg DOJO_VERSION="${DOJO_VERSION}" -t dojo:${DOJO_VERSION} containers/dojoengine

game_init:
	${CONTAINER} run -v ./starkade-cairo:/usr/src/app -w /usr/src/app localhost/dojo:${DOJO_VERSION} sozo init ${GAME_INIT}

.PHONY: dev install build_dojo game_init
