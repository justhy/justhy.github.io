#! /bin/bash

Info_font_prefix="\033[32m" && Error_font_prefix="\033[31m" && Info_background_prefix="\033[42;37m" && Error_background_prefix="\033[41;37m" && Font_suffix="\033[0m"

set_dns(){
	read -p "是否设置Google DNS？（y/n, default: y）：" GoogleDNS
	if  [ ! -n "$GoogleDNS" ]; then
		GoogleDNS="y"
	fi
	if [ $GoogleDNS == y ]; then
		apt install -y resolvconf
		echo "nameserver 8.8.8.8
nameserver 114.114.114.114" > /etc/resolvconf/resolv.conf.d/base
		resolvconf -u
	fi
}

set_file_max(){
	sed -i '/vm.swappiness/d' /etc/sysctl.conf
	sed -i '/fs.file-max/d' /etc/sysctl.conf
	sed -i '/fs.inotify.max_user_instances/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_syncookies/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_fin_timeout/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_tw_reuse/d' /etc/sysctl.conf
	sed -i '/net.ipv4.ip_local_port_range/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_syn_backlog/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_tw_buckets/d' /etc/sysctl.conf
	sed -i '/net.ipv4.route.gc_timeout/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_syn_retries/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_synack_retries/d' /etc/sysctl.conf
	sed -i '/net.core.somaxconn/d' /etc/sysctl.conf
	sed -i '/net.core.netdev_max_backlog/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_timestamps/d' /etc/sysctl.conf
	sed -i '/net.ipv4.tcp_max_orphans/d' /etc/sysctl.conf
	sed -i '/# forward ipv4/d' /etc/sysctl.conf
	sed -i '/net.ipv4.ip_forward/d' /etc/sysctl.conf
	echo "vm.swappiness=100
fs.file-max = 6553500
fs.inotify.max_user_instances = 8192
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_tw_reuse = 1
net.ipv4.ip_local_port_range = 1024 65000
net.ipv4.tcp_max_syn_backlog = 16384
net.ipv4.tcp_max_tw_buckets = 6000
net.ipv4.route.gc_timeout = 100
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_synack_retries = 1
net.core.somaxconn = 32768
net.core.netdev_max_backlog = 32768
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_max_orphans = 32768
# forward ipv4
net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
	
	sed -i '/soft memlock/d' /etc/security/limits.conf
	sed -i '/hard memlock/d' /etc/security/limits.conf
	sed -i '/soft nofile/d' /etc/security/limits.conf
	sed -i '/hard nofile/d' /etc/security/limits.conf
	sed -i '/soft nproc/d' /etc/security/limits.conf
	sed -i '/hard nproc/d' /etc/security/limits.conf
	echo "* soft memlock unlimited
* hard memlock unlimited
* soft nofile 1024000
* hard nofile 1024000
* soft nproc 1024000
* hard nproc 1024000

root soft memlock unlimited
root hard memlock unlimited
root soft nofile 1024000
root hard nofile 1024000
root soft nproc 1024000
root hard nproc 1024000
" >> /etc/security/limits.conf

	sed -i '/session required pam_limits.so/d' /etc/pam.d/common-session
	echo "session required pam_limits.so" >> /etc/pam.d/common-session
}

set_timezone(){
	ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	timedatectl set-timezone Asia/Shanghai
	timedatectl set-ntp true
}

set_utf(){
	sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
	echo 'LANG="en_US.UTF-8"' > /etc/default/locale
	dpkg-reconfigure --frontend=noninteractive locales
	update-locale LANG=en_US.UTF-8
}

install_def(){
	apt-get -yqq update; apt-get -yqq upgrade; \
	apt-get -y install sudo wget curl zip unzip screen
}

set_finished(){
	read -p "是否重启，以应用优化？（y/n, default: y）：" reooted
	if [ $reooted == n ]; then
		echo -e "${Info_font_prefix}[信息]${Font_suffix} 优化结束。"
	else
		echo -e "${Info_font_prefix}[信息]${Font_suffix} 系统将会重启..."
		reboot
	fi
}

main(){
	echo -e "${Info_font_prefix}[信息]${Font_suffix} 正在进行优化..."
	set_dns
	set_file_max
	set_timezone
	set_utf
	install_def
	set_finished
}

main