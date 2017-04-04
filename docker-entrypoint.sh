#!/bin/bash


function defaults {
    LD_LIBRARY_PATH="${MAKE_PREFIX}"/lib:$LD_LIBRARY_PATH
    PATH="${MAKE_PREFIX}"/bin:$PATH

    : "${LOCAL_USER_ID:=1000}"

    export LD_LIBRARY_PATH PATH LOCAL_USER_ID
}


function local_user {
    addgroup -q --gid "${LOCAL_USER_ID}" user
    adduser --disabled-password --home /home/user --no-create-home --system -q --uid "${LOCAL_USER_ID}" --ingroup user user
    mkdir -p /home/user
    chown user:user /home/user
    export HOME=/home/user
}


trap exit SIGHUP SIGINT SIGTERM
defaults
local_user

set -x
# shellcheck disable=SC2086 disable=SC2048
exec /usr/local/bin/gosu user blasr "$@"
