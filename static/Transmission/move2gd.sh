#! /bin/bash

file="$TR_TORRENT_DIR/$TR_TORRENT_NAME"

cloudName=moe
cloudFolder=Transmission

software=fclone
transfers=8

if [ -d "$file" ];then
	$software move --transfers=$transfers "$file" "$cloudName:$cloudFolder/$TR_TORRENT_NAME" --delete-empty-src-dirs
elif [ -f "$file" ]; then
	$software move "$file" "$cloudName:$cloudFolder/"
fi
