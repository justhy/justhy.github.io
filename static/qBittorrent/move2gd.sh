#! /bin/bash

file=$1

cloudName=moe
cloudFolder=.qBittorrent

software=fclone
transfers=16

if [ -d "${file}" ];then
	${software} move --transfers=$transfers "$1" ${cloudName}:${cloudFolder}/"$2"/ --delete-empty-src-dirs
elif [ -f "${file}" ]; then
	${software} move "$1" ${cloudName}:${cloudFolder}/ 
fi
