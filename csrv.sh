#!/bin/bash

TFILE="/var/log/secure"
IPT="/usr/sbin/iptables"
DTX='/usr/bin/date'
#TFILE="secure"
TSVC="ssh"
TAGO=15
EMSG="Failed password"
FBIP="[10]"
FDTM="[0]"
FDTD="[1]"
FDTY="[]"
FSVC="[4]:0:3"
ipqt="$1"
atpr="$2"
bdur="$3"

lcat () {
    cat "$TFILE" | grep "$TSVC" | grep "$EMSG";
}

fcat () {

    cdt=`date +%s -d"$atpr minutes ago"`

    lcat | while read line; do
        flds=($line)
        fsvc=${flds[4]:0:3}; fbip=${flds[10]};
        fdt=`date +%s -d"${flds[0]} ${flds[1]} ${flds[2]}"`
        if [ $fdt -ge $cdt ]
        then
            echo "${fbip}" "${fsvc}"
        fi
    done

}

ipblock () {
    $IPT -A INPUT -s "$1" -j DROP;
    $IPT -L | grep "$1" >> droplog;
    echo "$IPT -D INPUT -s $1 -j DROP" | at now +"$bdur" minutes;
    $IPT -L | grep "$1" >> droplog;
}

fcat | sort |  uniq -c | while read line; do
	flds=($line)
        ffrq=${flds[0]}
	fbip=${flds[1]}
	fsvc=${flds[2]}
    echo $fbip
	abip=`$IPT -L | grep $fbip | wc -l`
	if [ $ffrq -ge $ipqt ] && [ $abip -eq 0 ]  ; then
		ipblock $fbip
	fi
done
