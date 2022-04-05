#!/bin/bash

v1="notnull"
[ -n $v1 ] && echo "not null"

if [ $1 -lt 0 ] ; then
    echo "$1 is lt 0"
else
    echo "$1 is gt 0"
fi

case $1 in
    5) echo "ok";;
    ([6-9]) echo "okay";;
    *) exit 1;;
esac
