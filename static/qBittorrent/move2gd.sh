#! /bin/bash

SHTZWZM="色花堂中文字幕"

filePath="$1"
fileName="$2"
category="$3"
tags="$4"

software=fclone
transfers=8

cloudName=moe
cloudFolder=qBittorrent

spCloudName=sp-download

isShtzwzm=false
shtName=sp-shtzwzmfp

# 一些标签的SP


# 分类区分
if [ -n "$category" ] && [[ "$SHTZWZM" =~ "$category" ]]; then
		isShtzwzm=true
		spCloudName=$shtName
		cloudFolder=RSSHub
		fclone --max-size 100M delete "${filePath}"
fi

# 根据标签上传
#if [ -n "$tag" ]; then
#fi

if [ -d "${filePath}" ];then
	${software} move "${filePath}" "${cloudName}:${cloudFolder}/${fileName}/" --transfers=$transfers --delete-empty-src-dirs
	rm -rf "${filePath}"
	
	if $isShtzwzm; then
		${software} move "${cloudName}:${cloudFolder}/${fileName}/" "$spCloudName:${cloudFolder}/" --transfers=$transfers --delete-empty-src-dirs --onedrive-no-versions --ignore-checksum --ignore-size --ignore-errors --drive-acknowledge-abuse
	else
		${software} move "${cloudName}:${cloudFolder}/${fileName}/" "$spCloudName:${cloudFolder}/${fileName}/" --transfers=$transfers --delete-empty-src-dirs --onedrive-no-versions --ignore-checksum --ignore-size --ignore-errors --drive-acknowledge-abuse
	fi
	${software} rmdirs "${cloudName}:${cloudFolder}/${fileName}/"
elif [ -f "${filePath}" ]; then
	${software} move "$1" "${cloudName}:${cloudFolder}/"
	
	if $isShtzwzm; then
		${software} move "${cloudName}:${cloudFolder}/${fileName}/" "$spCloudName:${cloudFolder}/" --delete-empty-src-dirs --onedrive-no-versions --ignore-checksum --ignore-size --ignore-errors --drive-acknowledge-abuse
	else
		${software} move "${cloudName}:${cloudFolder}/${fileName}" "$spCloudName:${cloudFolder}/" --onedrive-no-versions --ignore-checksum --ignore-size --ignore-errors --drive-acknowledge-abuse
	fi
fi

