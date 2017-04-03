#!/bin/bash


function defaults {
    LD_LIBRARY_PATH="${MAKE_PREFIX}"/lib:$LD_LIBRARY_PATH
    PATH="${MAKE_PREFIX}"/bin:$PATH

    export LD_LIBRARY_PATH PATH
}


trap exit SIGHUP SIGINT SIGTERM
defaults

set -x
# shellcheck disable=SC2086 disable=SC2048
exec blasr "$@"
