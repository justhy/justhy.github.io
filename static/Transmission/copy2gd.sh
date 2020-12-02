#! /bin/bash

file="$TR_TORRENT_DIR/$TR_TORRENT_NAME"

software=fclone
transfers=4
cloudName=moe
cloudFolder=

if [ -d "$file" ];then
	$software copy --transfers=$transfers "$file" "$cloudName:$folder/$TR_TORRENT_NAME"
elif [ -f "$file" ]; then
	$software copy "$file" "$cloudName:$folder/"
fi
