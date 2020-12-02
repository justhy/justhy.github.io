#! /bin/bash

file=$1

software=fclone
transfers=4
cloudName=moe
cloudFolder=

if [ -d "$file" ];then
	$software copy --transfers=$transfers "$1" "$cloudName:$folder/$2"
elif [ -f "$file" ]; then
	$software copy "$1" "$cloudName:$folder/"
fi