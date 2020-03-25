#!/bin/bash

set -xe

PS4='+ $(date +"%F %T%z") ${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'

UBUNTU_DELAY="${UBUNTU_DELAY:=10}"

if [[ "${UBUNTU_DELAY}" != "" ]]; then
    while [[  "${UBUNTU_DELAY}" > 1 ]]; do
        /dev/stdout < "Waiting for the application start, ${UBUNTU_DELAY} seconds left.." 
        sleep 1
        UBUNTU_DELAY="$[UBUNTU_DELAY - 1]"
    done
fi

if [[ "${@}" != "" ]]; then
    exec "${@}"
else
    nginx -g daemon off
fi
