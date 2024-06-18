NODE_VERSION=20
CONTAINER=docker
DEV_PORT=3000
KATANA_PORT=5050
DOJO_VERSION=0.7.1

dev:
	${CONTAINER} run -it -v ./starkade-web:/usr/src/app -w /usr/src/app -p ${DEV_PORT}:3000 docker.io/library/node:${NODE_VERSION} npm run dev

install:
	${CONTAINER} run -v ./starkade-web:/usr/src/app -w /usr/src/app docker.io/library/node:${NODE_VERSION} npm install

build_dojo:
	${CONTAINER} build -f Containerfile --build-arg DOJO_VERSION="${DOJO_VERSION}" -t dojo:${DOJO_VERSION} containers/dojoengine

dojo:
	${CONTAINER} run -it localhost/dojo:${DOJO_VERSION} sh

katana:
	${CONTAINER} run -it -p ${KATANA_PORT}:5050 localhost/dojo:${DOJO_VERSION} katana --disable-fee

sozo_build:
	${CONTAINER} run -it -v ./games/test:/usr/src/app -w /usr/src/app localhost/dojo:${DOJO_VERSION} sozo build

sozo_migrate:
	${CONTAINER} run -it -v ./games/test:/usr/src/app -w /usr/src/app localhost/dojo:${DOJO_VERSION} sozo build

.PHONY: dev install build_dojo dojo katana sozo_build sozo_migrate
