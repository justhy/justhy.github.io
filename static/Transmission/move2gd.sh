#! /bin/bash

file="$TR_TORRENT_DIR/$TR_TORRENT_NAME"

software=fclone
transfers=4
cloudName=moe
cloudFolder=

if [ -d "$file" ];then
	$software move --transfers=$transfers "$file" "$cloudName:$folder/$TR_TORRENT_NAME" --delete-empty-src-dirs
elif [ -f "$file" ]; then
	$software move "$file" "$cloudName:$folder/"
fi