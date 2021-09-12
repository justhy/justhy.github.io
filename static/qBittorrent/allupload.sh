#! /bin/bash

fileName=""
moved=true
#moved=false

downDir="/root/Download"

file="${downDir}"

cloudName=moe
cloudFolder=.qBittorrent

software=fclone
transfers=8

if ${moved};then
		${software} move --transfers=$transfers "${file}"/ ${cloudName}:${cloudFolder}/ --delete-empty-src-dirs
	else
		${software} copy --transfers=$transfers "${file}"/ ${cloudName}:${cloudFolder}/
fi
