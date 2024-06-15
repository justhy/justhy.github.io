#!/bin/bash

path=$3
downloadpath='/root/.config/aria2/Download'

software=fclone
cloudName=moe
cloudFolder=Aria2

spCloudName=sp-download
transfers=2

if [ $2 -eq 0 ]
        then
                exit 0
fi
while true; do
filepath=$path
path=${path%/*}; 
if [ "$path" = "$downloadpath" ] && [ $2 -eq 1 ]
    then
    ${software} move "$filepath" ${cloudName}:${cloudFolder}/
	
	${software} move "$cloudName:${cloudFolder}/${filepath##*/}" "${spCloudName}:${cloudFolder}/" --onedrive-no-versions --ignore-checksum --ignore-size --ignore-errors --drive-acknowledge-abuse
	exit 0
elif [ "$path" = "$downloadpath" ]
    then
	while [[ "`ls -A "$filepath/"`" != "" ]]; do
    ${software} move "$filepath"/ ${cloudName}:${cloudFolder}/"${filepath##*/}"/ --delete-empty-src-dirs
	done
	rm -rf "$filepath/"
	
	${software} move ${cloudName}:${cloudFolder}/"${filepath##*/}"/ ${spCloudName}:${cloudFolder}/"${filepath##*/}"/ --transfers=$transfers --delete-empty-src-dirs --onedrive-no-versions --ignore-checksum --ignore-size --ignore-errors --drive-acknowledge-abuse
	${software} rmdir ${cloudName}:${cloudFolder}/"${filepath##*/}"/
	exit 0
fi
done
