#!/bin/sh

if [[ -z "$INPUT_AUTH_CHECK" ]]; then
    INPUT_AUTH_CHECK=true
fi

if [[ "$INPUT_AUTH_CHECK" = "true" ]]; then
    swift auth > /dev/null 2>&1

    if [[ $? -ne 0 ]]; then
        echo "[Error] Unable to authenticate against Swift provider."
        echo -e "\tPlease ensure all your keystone variables are set and check your credentials."
        exit 1
    fi
fi

sh -c "swift $*"