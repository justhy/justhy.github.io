#! /bin/bash

file="$TR_TORRENT_DIR/$TR_TORRENT_NAME"

echo "$TR_APP_VERSION\n $TR_TIME_LOCALTIME\n $TR_TORRENT_DIR\n $TR_TORRENT_HASH\n $TR_TORRENT_ID\n $TR_TORRENT_NAME\n"

cloudName=moe
cloudFolder=.transmission

software=fclone
transfers=4

if [ -d "$file" ];then
	$software copy --transfers=$transfers "$file" "$cloudName:$cloudFolder/$TR_TORRENT_NAME"
elif [ -f "$file" ]; then
	$software copy "$file" "$cloudName:$cloudFolder/"
fi
