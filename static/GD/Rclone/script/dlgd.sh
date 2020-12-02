#!/bin/bash

SOFTWARE=fclone
CLOUD_NAME=gd
CLOUD_DIR=
LOCAL_DIR=/root/GD/

WROK_DIR=$(cd $(dirname $0); pwd)
DL_NAMES="files_names_dl_and_up.conf"
DL_NAMES_FILE="$WROK_DIR/$DL_NAMES"

Info_font_prefix="\033[32m" && Error_font_prefix="\033[31m" && Info_background_prefix="\033[42;37m" && Error_background_prefix="\033[41;37m" && Font_suffix="\033[0m"

download(){
	FILE="${CLOUD_NAME}:${CLOUD_DIR}/$1"
	FILE_NAME=${FILE##*/}
	$SOFTWARE copy --transfers 8 "$FILE" "$LOCAL_DIR/$FILE_NAME"
}

main(){
	if [ ! -f "$DL_NAMES_FILE" ]; then
		echo -e "${Error_font_prefix}[错误]${Font_suffix} 文件名记录文件不存在，无法读取文件名！$DL_NAMES_FILE"
		exit 1
	fi
	
	cat "$DL_NAMES_FILE" | while read LINE
	do
		if [[ -z "$LINE" ]]; then
			echo -e "${Error_font_prefix}[错误]${Font_suffix} 读取到的文件名为空，请检查！"
			exit 1
		fi
		download "$LINE"
	done
}
main
