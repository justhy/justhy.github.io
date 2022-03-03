#! /bin/bash

SHTZWZM="色花堂中文字幕"

file="$1"
category="$3"

software=fclone
transfers=8

cloudName=moe
cloudFolder=qBittorrent

isShtzwzm=false
spCloudName=sp-download

if [ -n "$category" ] && [[ "$SHTZWZM" =~ "$category" ]]; then
		isShtzwzm=true
		spCloudName=sp-shtzwzmfp
		cloudFolder=RSSHub
		fclone --max-size 100M delete "$1"
fi

if [ -d "${file}" ];then
	${software} move --transfers=$transfers "$1" "$cloudName:${cloudFolder}/$2/" --delete-empty-src-dirs
	rm -rf "$1"
	
	if $isShtzwzm; then
		${software} move --transfers=$transfers "$cloudName:${cloudFolder}/$2/" "$spCloudName:${cloudFolder}/" --delete-empty-src-dirs --onedrive-no-versions --ignore-checksum --ignore-size --ignore-errors --drive-acknowledge-abuse
	else
		# GD还没完蛋之前使用 copy ，复制完成后移动到 $cloudName:moved
		${software} move --transfers=$transfers "$cloudName:${cloudFolder}/$2/" "$spCloudName:${cloudFolder}/$2/" --delete-empty-src-dirs --onedrive-no-versions --ignore-checksum --ignore-size --ignore-errors --drive-acknowledge-abuse
		#${software} move --transfers=$transfers "$cloudName:${cloudFolder}/$2/" "$cloudName:moved/$2/" 
	fi
	${software} rmdirs "$cloudName:${cloudFolder}/$2/"
elif [ -f "${file}" ]; then
	${software} move "$1" "$cloudName:${cloudFolder}/"
	
	if $isShtzwzm; then
		${software} move "$cloudName:${cloudFolder}/$2" "$spCloudName:/" --onedrive-no-versions --ignore-checksum --ignore-size --ignore-errors --drive-acknowledge-abuse
	else
		# GD还没完蛋之前使用 copy ，复制完成后移动到 $cloudName:moved
		${software} move "$cloudName:${cloudFolder}/$2" "$spCloudName:${cloudFolder}/" --onedrive-no-versions --ignore-checksum --ignore-size --ignore-errors --drive-acknowledge-abuse
		#${software} move "$cloudName:${cloudFolder}/$2" "$cloudName:moved/" 
	fi
fi

