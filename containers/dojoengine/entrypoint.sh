#!/bin/sh

export PATH="$PATH:/root/.local/bin:/root/.dojo/bin"

. /root/.cargo/env

exec "$@"
