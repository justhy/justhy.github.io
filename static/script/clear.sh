#! /bin/sh
# 0 0 * * 1 /root/script/clear.sh

deleteLogs(){
	#rm -rf /tmp/*
	workdir="/"
	cd "$workdir"
	#for i in `find . -name "*.log"`; do cat /dev/null > $i; done
	for i in `find . -name "*.log"`; do rm -rf $i; done
}

deleteTorrents(){
	workdir="/root/.config"
	cd "$workdir"
	for i in `find . -name "*.torrent"`; do rm -rf $i; done
}

deleteEmpty(){
	workdir="/root/.config"
	cd "$workdir"
    find ${1:-.} -mindepth 1 -maxdepth 1 -type d | while read -r dir
    do
        if [[ -z "$(find "$dir" -mindepth 1 -type f)" ]] >/dev/null
        then
            echo "$dir"
            rm -rf ${dir} 2>&- && echo "Empty, Deleted!" || echo "Delete error"
        fi
        if [ -d ${dir} ]
        then
            deleteEmpty "$dir"
        fi
    done
}

deleteLogs
deleteTorrents
deleteEmpty