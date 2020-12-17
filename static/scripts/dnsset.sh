#! /bin/bash

# 解决dns重启还原的问题
# mkdir -p /root/.config/dnssetscript && cd /root/.config/dnssetscript
# wget https://github.com/Godcic/script_center/raw/main/script/dnsset.sh && chmod +x dnsset.sh
# 添加开机自启
# vim /etc/rc.local
# /root/.config/dnssetscript/dnsset.sh

sleep 3s

echo "nameserver 8.8.8.8
nameserver 8.8.4.4" > /etc/resolv.conf

apt update
