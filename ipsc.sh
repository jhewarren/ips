#!/bin/bash

PWD=`/usr/bin/pwd`

if [ $1 -eq "1" ]; then
    rfrq="*/1"
else
    rfrq="*/$1"
fi

csrv="$PWD/csrv.sh"

if [ $# -eq 4 ]; then
#    crontab -l > mycron
    echo $rfrq "* * * *" $csrv $2 $3 $4  >> mycron
    crontab mycron
#    rm mycron
else
    echo "Usage $0 [check-frequency] [number] [test-period] [lockout-duration]"
fi
