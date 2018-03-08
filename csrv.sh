#!/bin/bash

TFILE="/var/log/secure"
TSVC="ssh"
EMSG="Failed password"
IPNO="11"
lcat () {
    cat "$TFILE" | grep "$TSVC" | grep "$EMSG";
}

lcat | while read line; do
    flds=($line)
    fsvc=${flds[4]:0:3}; fbip=${flds[10]};fdt=`date -d"${flds[0]} ${flds[1]} ${flds[2]}"`
    echo "${fdt}" "===>" "${fsvc}" "${fbip}"
#    echo "${flds[0]}" "${flds[1]}" "${flds[2]}" "${flds[4.3]}" "${flds[10]}"
#    for i in fields; do
#        echo line[i]
#    done
done
