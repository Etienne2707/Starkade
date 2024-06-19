#!/bin/bash
set -e

make CONTAINER=podman GAME_INIT=$1 game_init
cp ./dojo_make starkade-cairo/$1/Makefile
sed -i "1s/^/GAME = $1\n/" starkade-cairo/$1/Makefile
