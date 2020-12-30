#! /bin/bash

THIS_NAME="GD-Utils"
PARENT_DIR="/root/.config"
GDUTILS_DIR="$PARENT_DIR/gd-utils"

CADDY_CONF_FILE="/usr/local/caddy/Caddyfile"

WORK_DIR="$( cd "$( dirname "$0"  )" && pwd  )"
CONFIG_FILE=$WORK_DIR/gdutils-install.ini
source $CONFIG_FILE

Info_font_prefix="\033[32m" && Error_font_prefix="\033[31m" && Info_background_prefix="\033[42;37m" && Error_background_prefix="\033[41;37m" && Font_suffix="\033[0m"

installcaddy() {
	bash <(wget --no-check-certificate -qO- https://github.com/Godcic/script_center/raw/main/Caddy/script/caddy_1.0) install
	echo "http://$BOT_URL {
timeouts none
gzip
proxy / http://127.0.0.1:23333 {
    header_upstream Host {host}
    header_upstream X-Real-IP {remote}
    header_upstream X-Forwarded-For {remote}
    header_upstream X-Forwarded-Proto {scheme}
    }
}

" >> ${CADDY_CONF_FILE}

	/etc/init.d/caddy restart
}

install() {

	echo -e "${Info_font_prefix}[信息]${Font_suffix} 开始安装..."
	
	cd ~
	apt update
	apt install -y zip unzip curl git
	
	if  [[ $NODEJS_INSTALLED != y ]]; then
		curl -sL https://deb.nodesource.com/setup_12.x | bash -
		apt update
		apt install -y nodejs
	fi
	
	rm -rf "$GDUTILS_DIR"
	cd "$PARENT_DIR"
	git clone https://github.com/iwestlin/gd-utils
	cd "$GDUTILS_DIR"
	npm install --unsafe-perm=true --allow-root
	npm install -g pm2
	
	wget --no-check-certificate -q $SA_ZIP_URL -O SA.zip
	unzip -o SA.zip -d sa/ && rm -rf SA.zip
	
	echo "const TIMEOUT_BASE = 7000
const TIMEOUT_MAX = 60000
const LOG_DELAY = 5000
const PAGE_SIZE = 1000
const RETRY_LIMIT = 7
const PARALLEL_LIMIT = $PARALLEL_LIMIT
const DEFAULT_TARGET = '$DEFAULT_TARGET'
const AUTH = {
  client_id: '',
  client_secret: '',
  refresh_token: '',
  expires: 0,
  access_token: '',
  tg_token: '$TG_TOKEN',
  tg_whitelist: ['$TG_USER_ID']
}
module.exports = { AUTH, PARALLEL_LIMIT, RETRY_LIMIT, TIMEOUT_BASE, TIMEOUT_MAX, LOG_DELAY, PAGE_SIZE, DEFAULT_TARGET }
" > "$GDUTILS_DIR"/config.js

	pm2 start server.js --node-args="--max-old-space-size=$MAX_OLD_SPACE_SIZE"

	installcaddy
	
	curl "$BOT_URL/api/gdurl/count?fid=124pjM5LggSuwI1n40bcD5tQ13wS0M6wg"
	curl -F "url=$BOT_URL/api/gdurl/tgbot" "https://api.telegram.org/bot$TG_TOKEN/setWebhook"
	
	pm2 startup
	pm2 save
	
	echo -e "\n${Info_font_prefix}[信息]${Font_suffix} 安装结束，试着给bot发送个 /help 。"
}

main(){
	install
}

main