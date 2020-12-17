#! /bin/bash

THIS_NAME="iCopy"
ICOPY_DIR="/root/iCopy/"
PYTHON3_VER=3.9.0
Info_font_prefix="\033[32m" && Error_font_prefix="\033[31m" && Info_background_prefix="\033[42;37m" && Error_background_prefix="\033[41;37m" && Font_suffix="\033[0m"

source /etc/os-release &>/dev/null
check_sys(){
	if [[ "${ID}" == "debian" && ${VERSION_ID} -ge 8 ]];then
		VER_ID=${VERSION_ID}
	else
		echo -e "${Error_font_prefix}[错误]${Font_suffix} 只支持Debian8及以上版本"
		exit 1
	fi
}

compilePython(){
	wget https://www.python.org/ftp/python/${PYTHON3_VER}/Python-${PYTHON3_VER}.tgz && tar -xf Python-*.tgz && rm -rf Python-*.tgz && cd Python-*
	./configure --enable-optimizations
	make -j$(nproc) && make install
	cd ~
	rm -rf Python-*
}
compilePython3(){
	check_sys
	echo -e "${Info_font_prefix}[信息]${Font_suffix} 将要编译安装Python${PYTHON3_VER}..."
	if [ $VER_ID -eq 8 ]; then
		echo "deb http://deb.debian.org/debian stretch main" >> /etc/apt/sources.list
		apt-get update
		apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev
		sed -i '$d' /etc/apt/sources.list
		apt-get update
		compilePython
	elif [ $VER_ID -gt 8 ]; then
		apt update 
		apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev
		compilePython
	else
		echo -e "${Error_font_prefix}[错误]${Font_suffix} 只支持Debian8及以上版本"
		exit 1
	fi

}

main(){
	compilePython3
}

main