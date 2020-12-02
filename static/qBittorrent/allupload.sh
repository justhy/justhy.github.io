#! /bin/bash

fileName=""
moved=true
#moved=false

downDir="/root/Download"

file="${downDir}"

software=fclone
transfers=4
cloudName=moe
cloudFolder=

if $moved; then
		$software move --transfers=$transfers "$file"/ "$cloudName:$cloudFolder/" --delete-empty-src-dirs
	else
		$software copy --transfers=$transfers "$file"/ "${cloudName}:${cloudFolder}/"
fi
