#!/bin/bash
set -e

# Create project
make CONTAINER=podman GAME_INIT=$1 game_init

# Cleanup project
rm -rf starkade-cairo/$1/.git
rm -rf starkade-cairo/$1/.github
rm -rf starkade-cairo/$1/.gitignore
rm -rf starkade-cairo/$1/.vscode

# New additions
cp ./dojo_make starkade-cairo/$1/Makefile
sed -i "1s/^/GAME = $1\n/" starkade-cairo/$1/Makefile
echo "/__container_cache__" > starkade-cairo/$1/.gitignore
