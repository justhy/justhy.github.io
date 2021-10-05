#! /bin/bash

SHTZWZM="色花堂中文字幕"

file="$1"
category="$3"

software=fclone
transfers=8

cloudName=moe
cloudFolder=.qBittorrent

if [ -n "$category" ]; then
	if [[ "$SHTZWZM" =~ "$category" ]];then
		cloudName=sp-shtzwzmfp
		cloudFolder=RSSHub
		fclone --max-size 100M delete "$1"
	fi
fi

if [ -d "${file}" ];then
	${software} copy --transfers=$transfers "$1" ${cloudName}:${cloudFolder}/"$2"/
elif [ -f "${file}" ]; then
	${software} copy "$1" ${cloudName}:${cloudFolder}/ 
fi
