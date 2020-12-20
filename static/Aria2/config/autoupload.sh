#!/bin/bash

path=$3
downloadpath='/root/.config/aria2/Download'

copySoftware=fclone
cloudName=moe
cloudFolder=.aria2

if [ $2 -eq 0 ]
        then
                exit 0
fi
while true; do
filepath=$path
path=${path%/*}; 
if [ "$path" = "$downloadpath" ] && [ $2 -eq 1 ]
    then
    ${copySoftware} move "$filepath" ${cloudName}:${cloudFolder}/     
    exit 0
elif [ "$path" = "$downloadpath" ]
    then
	while [[ "`ls -A "$filepath/"`" != "" ]]; do
    ${copySoftware} move "$filepath"/ ${cloudName}:${cloudFolder}/"${filepath##*/}"/ --delete-empty-src-dirs
	done
	rm -rf "$filepath/"
    exit 0
fi
done
