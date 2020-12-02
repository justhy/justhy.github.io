#! /bin/bash

FILE_NAME=""
MOVED=true
#MOVED=false

SOFTWARE=fclone
transfers=4
CLOUD_NAME=moe
CLOUD_DIR=

QB_DL_DIR="/root/Download"
FILE="$QB_DL_DIR/$FILE_NAME"

if [ -d "$FILE" ];then
	if $MOVED;then
		$SOFTWARE move --transfers=$transfers "$FILE"/ "$CLOUD_NAME:$CLOUD_DIR/$FILE_NAME/" --delete-empty-src-dirs
	else
		$SOFTWARE copy --transfers=$transfers "$FILE"/ "$CLOUD_NAME:$CLOUD_DIR/$FILE_NAME/"
	fi
elif [ -f "$FILE" ]; then
	if $MOVED;then
		$SOFTWARE move "$FILE" "$CLOUD_NAME:$CLOUD_DIR/"
	else
		$SOFTWARE copy "$FILE" "$CLOUD_NAME:$CLOUD_DIR/"
	fi
fi

