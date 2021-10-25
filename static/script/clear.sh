#! /bin/bash
# 0 0 * * 1 /root/script/clear.sh

deleteLogs(){
	#find /tmp -type f -mmin -300 -delete;
	workdir="/"
	cd "$workdir"
	#for i in `find . -name "*.log"`; do cat /dev/null > $i; done
	for i in `find . -name "*.log"`; do rm -rf $i; done
	
	echo > /var/log/wtmp
	echo > /var/log/btmp
	echo > /var/log/lastlog
	echo > /var/log/secure
	echo > /var/log/messages
	echo > /var/log/syslog
	echo > /var/log/xferlog
	echo > /var/log/auth.log
	echo > /var/log/user.log
	cat /dev/null > /var/adm/sylog
	cat /dev/null > /var/log/maillog
	cat /dev/null > /var/log/openwebmail.log
	cat /dev/null > /var/log/mail.info
	echo > /var/run/utmp
	echo > ~/.bash_history
	history -c
	echo > .bash_history
	history -cw
	rm -f ~/.wget-hsts
}

deleteTorrents(){
	rm -f /root/.config/*.zip
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