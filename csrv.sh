#!/bin/bash

#TFILE="/var/log/secure"
TFILE="secure"
TSVC="ssh"
TAGO=15
EMSG="Failed password"
FBIP="[10]"
FDTM="[0]"
FDTD="[1]"
FDTY="[]"
FSVC="[4]:0:3"

lcat () {
    cat "$TFILE" | grep "$TSVC" | grep "$EMSG";
}

lcat | while read line; do
    flds=($line)
    fsvc=${flds[4]:0:3}; fbip=${flds[10]};
    fdt=`date -d"${flds[0]} ${flds[1]} ${flds[2]}"`
    if [${fdt} ge `date -d"${TAGO} minutes ago""`];then
        echo "${fdt}" "===>" "${fsvc}" "${fbip}"
    fi
done
