#! /bin/bash

file=$1

cloudName=moe
cloudFolder=.qBittorrent

software=fclone
transfers=16

if [ -d "${file}" ];then
	${software} copy --transfers=$transfers "$1" ${cloudName}:${cloudFolder}/"$2" 
elif [ -f "${file}" ]; then
	${software} copy "$1" ${cloudName}:${cloudFolder}/ 
fi
