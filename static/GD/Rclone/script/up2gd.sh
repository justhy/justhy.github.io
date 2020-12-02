#! /bin/bash

#MOVED=true
MOVED=false

SOFTWARE=fclone
CLOUD_NAME=moe
CLOUD_DIR=

WROK_DIR=$(cd $(dirname $0); pwd)
UPLOAD_NAMES="files_names_dl_and_up.conf"
UPLOAD_NAMES_FILE="$WROK_DIR/$UPLOAD_NAMES"

Info_font_prefix="\033[32m" && Error_font_prefix="\033[31m" && Info_background_prefix="\033[42;37m" && Error_background_prefix="\033[41;37m" && Font_suffix="\033[0m"

upload() {
	FILE="$1"
	FILE_NAME=${FILE##*/}
	if [ -d "$FILE" ]; then
        if $MOVED; then
                $SOFTWARE move --transfers 8 "$FILE"/ "$CLOUD_NAME:$CLOUD_DIR/$FILE_NAME/" --delete-empty-src-dirs
        else
                $SOFTWARE copy --transfers 8 "$FILE"/ "$CLOUD_NAME:$CLOUD_DIR/$FILE_NAME/"
        fi
	elif [ -f "$FILE" ]; then
        if $MOVED; then
                $SOFTWARE move "$FILE" "$CLOUD_NAME:$CLOUD_DIR/"
        else
                $SOFTWARE copy "$FILE" "$CLOUD_NAME:$CLOUD_DIR/"
        fi
	else
		echo -e "${Error_font_prefix}[错误]${Font_suffix} $FILE 文件不存在！"
	fi
}

main(){
	if [ ! -f "$UPLOAD_NAMES_FILE" ]; then
		echo -e "${Error_font_prefix}[错误]${Font_suffix} 文件名记录文件不存在，无法读取文件名！$UPLOAD_NAMES"
		exit 1
	fi
	
	cat "$UPLOAD_NAMES_FILE" | while read LINE
	do
		if [[ -z "$LINE" ]]; then
			echo -e "${Error_font_prefix}[错误]${Font_suffix} 读取到的文件名为空，请检查！"
			exit 1
		fi
		upload "$LINE"
	done
}
main