#!/bin/bash

set -e

/etc/init.d/squid start

if [ -z "$@" ]; then
    tail -f /dev/null
else
    echo "$@"
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin $@
fi

