#! /bin/bash

echo "nameserver 2a09:11c0:f1:bbf0::70
nameserver 2a03:7900:2:0:31:3:104:161" > /etc/resolv.conf

apt update

wget https://github.com/AlexanderOMara/wireguard-go-builds/releases/download/0.0.20181222/wireguard-go-linux-amd64.tar.xz && tar xvJf wireguard-go-*.tar.xz && rm -f wireguard-go-*.tar.xz && chmod +x ./wireguard-go && mv -f ./wireguard-go /usr/bin/

mkdir -p /etc/wireguard
wget "https://msource.ml/static/warp/wgcf-profile.conf" -O /etc/wireguard/wgcf-profile.conf

echo "nameserver 2606:4700:4700::1111
nameserver 2001:4860:4860::8888" > /etc/resolv.conf
apt update

apt-get -y install git wireguard-tools net-tools openresolv
export WG_I_PREFER_BUGGY_USERSPACE_TO_POLISHED_KMOD=1
wg-quick up wgcf-profile
wg-quick down wgcf-profile

echo "[Unit]
Description=WireGuard via wg-quick(8) for %I
After=network-online.target nss-lookup.target
Wants=network-online.target nss-lookup.target
PartOf=wg-quick.target
Documentation=man:wg-quick(8)
Documentation=man:wg(8)
Documentation=https://www.wireguard.com/
Documentation=https://www.wireguard.com/quickstart/
Documentation=https://git.zx2c4.com/wireguard-tools/about/src/man/wg-quick.8
Documentation=https://git.zx2c4.com/wireguard-tools/about/src/man/wg.8
 
[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/wg-quick up %i
ExecStop=/usr/bin/wg-quick down %i
Environment=WG_ENDPOINT_RESOLUTION_RETRIES=infinity
Environment=WG_I_PREFER_BUGGY_USERSPACE_TO_POLISHED_KMOD=1
 
[Install]
WantedBy=multi-user.target" > /lib/systemd/system/wg-quick@.service

systemctl enable wg-quick@wgcf-profile
systemctl start wg-quick@wgcf-profile
sleep 3
systemctl status wg-quick@wgcf-profile

