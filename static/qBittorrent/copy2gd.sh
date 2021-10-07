#! /bin/bash

SHTZWZM="色花堂中文字幕"

file="$1"
category="$3"

software=fclone
transfers=8

cloudName=moe
cloudFolder=qBittorrent

spCloudName=sp-download

if [ -n "$category" ]; then
	if [[ "$SHTZWZM" =~ "$category" ]];then
		spCloudName=sp-shtzwzmfp
		cloudFolder=RSSHub
		fclone --max-size 100M delete "$1"
	fi
fi

if [ -d "${file}" ];then
	${software} copy --transfers=$transfers "$1" "${cloudName}:${cloudFolder}/$2/"
	
	${software} move --transfers=$transfers "${cloudName}:${cloudFolder}/$2/" "$spCloudName:${cloudFolder}/$2/" --delete-empty-src-dirs --onedrive-no-versions --ignore-checksum --ignore-size --ignore-errors --drive-acknowledge-abuse
	
	${software} rmdir "${cloudName}:${cloudFolder}/$2/"
elif [ -f "${file}" ]; then
	${software} copy "$1" "${cloudName}:${cloudFolder}/"
	
	${software} move "${cloudName}:${cloudFolder}/$2" "$spCloudName:${cloudFolder}/" --onedrive-no-versions --ignore-checksum --ignore-size --ignore-errors --drive-acknowledge-abuse
fi
