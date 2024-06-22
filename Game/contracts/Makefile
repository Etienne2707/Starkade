GAME = tictactoe
DOJO_VERSION = 0.7.1
CONTAINER = docker
PUBLISH = --publish 8080:8080
NETWORK = network
NETWORK_OPTS =

CACHES = __container_cache__/cargo_registry\
		 __container_cache__/cargo_git\
		 __container_cache__/scarb\
		 __container_cache__/rustup

dev : build katana migrate

migrate: network
	${CONTAINER} run \
		-v ./:/usr/src/app \
		-w /usr/src/app \
		--${NETWORK} ${GAME} \
		--replace \
		--name ${GAME}-migrate \
		localhost/dojo:${DOJO_VERSION} \
		sozo migrate apply --rpc-url http://${GAME}-katana:5050

torii :
	${CONTAINER} run \
		--${NETWORK} ${GAME} \
		--replace \
		--name ${GAME}-torii \
		${PUBLISH} \
		localhost/dojo:${DOJO_VERSION} \
		torii \
		--world 0xb4079627ebab1cd3cf9fd075dda1ad2454a7a448bf659591f259efa2519b18 \
		--allowed-origins "*" \
		--rpc http://${GAME}-katana:5050

build : | ${CACHES}
	${CONTAINER} run \
		-v ./:/usr/src/app \
		-v ./__container_cache__/cargo_registry:/root/.cargo/registry \
		-v ./__container_cache__/cargo_git:/root/.cargo/git \
		-v ./__container_cache__/scarb:/root/.cache/scarb \
		-v ./__container_cache__/rustup:/root/.rustup \
		-w /usr/src/app \
		--replace \
		--name ${GAME}-build \
		localhost/dojo:${DOJO_VERSION} \
		sozo build

test : | ${CACHES}
	${CONTAINER} run \
		-v ./:/usr/src/app \
		-v ./__container_cache__/cargo_registry:/root/.cargo/registry \
		-v ./__container_cache__/cargo_git:/root/.cargo/git \
		-v ./__container_cache__/scarb:/root/.cache/scarb \
		-v ./__container_cache__/rustup:/root/.rustup \
		-w /usr/src/app \
		--replace \
		--name ${GAME}-build \
		localhost/dojo:${DOJO_VERSION} \
		sozo test

katana : network
	-${CONTAINER} run -d \
		--${NETWORK} ${GAME} \
		--name ${GAME}-katana \
		localhost/dojo:${DOJO_VERSION} \
		katana --disable-fee --allowed-origins "*"

_katana : network
	${CONTAINER} run -d \
		--${NETWORK} ${GAME} \
		--replace \
		--name ${GAME}-katana \
		localhost/dojo:${DOJO_VERSION} \
		katana --disable-fee --allowed-origins "*"

network :
	-${CONTAINER} ${NETWORK} create ${NETWORK_OPTS} ${GAME}

${CACHES} :
	mkdir -p $@

clean :
	-${CONTAINER} container rm -f ${GAME}-build
	-${CONTAINER} container rm -f ${GAME}-katana
	-${CONTAINER} container rm -f ${GAME}-migrate
	-${CONTAINER} container rm -f ${GAME}-torii
	-${CONTAINER} ${NETWORK} rm ${GAME}

fclean : clean
	rm -rf ${CACHES}

.PHONY : dev build katana network torii migrate clean _katana fclean
