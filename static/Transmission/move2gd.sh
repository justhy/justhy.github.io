#! /bin/bash

file="$TR_TORRENT_DIR/$TR_TORRENT_NAME"

cloudName=moe
cloudFolder=.transmission

software=fclone
transfers=4

if [ -d "$file" ];then
	$software move --transfers=$transfers "$file" "$cloudName:$cloudFolder/$TR_TORRENT_NAME" --delete-empty-src-dirs
elif [ -f "$file" ]; then
	$software move "$file" "$cloudName:$cloudFolder/"
fi
