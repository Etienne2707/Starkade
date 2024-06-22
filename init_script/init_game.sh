#!/bin/bash
set -e

add_module() {
    type=$1
    shift
    for module in "$@"; do
        cp init_script/${type}/${module}.cairo starkade-cairo/${game_name}/src/${type}/
        sed -i "s/^mod ${type} {/&\n    mod ${module};/" starkade-cairo/${game_name}/src/lib.cairo
    done
}

game_name=$1

# Create project
make CONTAINER=podman GAME_INIT=${game_name} game_init

# Cleanup project
rm -rf starkade-cairo/${game_name}/.git
rm -rf starkade-cairo/${game_name}/.github
rm -rf starkade-cairo/${game_name}/.gitignore
rm -rf starkade-cairo/${game_name}/.vscode

# New additions
cp init_script/Makefile starkade-cairo/${game_name}/Makefile
sed -i "1s/^/GAME = ${game_name}\n/" starkade-cairo/${game_name}/Makefile
echo "/__container_cache__" > starkade-cairo/${game_name}/.gitignore
add_module models player queue game
add_module systems privateRoom publicRoom
add_module tests test_privateRoom
