#! /bin/bash

SHTZWZM="色花堂中文字幕"

file="$1"
category="$3"

software=fclone
transfers=16

cloudName=moe
cloudFolder=.qBittorrent

if [ -n "$category" ]; then
	if [[ "$SHTZWZM" =~ "$category" ]];then
		cloudName=shtzwzm
		cloudFolder=RSSHub
	fi
fi

if [ -d "${file}" ];then
	${software} move --transfers=$transfers "$1" "${cloudName}:${cloudFolder}/$2/" --delete-empty-src-dirs
	rm -rf "$1"
elif [ -f "${file}" ]; then
	${software} move "$1" ${cloudName}:${cloudFolder}/ 
fi
