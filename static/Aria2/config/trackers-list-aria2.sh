#!/bin/bash
/etc/init.d/aria2 stop
ARIA2_CONFIG="/root/.config/aria2/config/aria2.conf"
list=`wget -qO- https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_best.txt|awk NF|sed ":a;N;s/\n/,/g;ta"`
if [ -z "`grep "bt-tracker" $ARIA2_CONFIG`" ]; then
    sed -i '$a bt-tracker='${list} $ARIA2_CONFIG
    echo add......
else
    sed -i "s@bt-tracker.*@bt-tracker=$list@g" $ARIA2_CONFIG
    echo update......
fi
#rm -rf /root/.config/aria2/Download/*
/etc/init.d/aria2 start
