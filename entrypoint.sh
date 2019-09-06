#!/bin/sh

sh -c "swift $*" 2>/dev/null

if [ $? -ne 0 ]; then
    echo "[Error] Unable to authenticate against Swift provider."
    echo -e "\tPlease ensure all your keystone variables are set and check your credentials."
    exit 1
fi