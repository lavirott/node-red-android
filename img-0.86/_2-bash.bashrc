if [ -x /data/data/com.termux/files/usr/libexec/termux/command-not-found ]; then
	command_not_found_handle() {
		/data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
	}
fi

PS1='\$ '

FILE=$PREFIX/etc/not_first-launch
if [ -f "$FILE" ]; then
	clear
	cat $PREFIX/etc/motd_enact
	echo
	echo "This is NOT the first launch"
	echo "Initial setup is already done"
	echo "starting node-red..."
	sleep 4
	node-red
else
	echo "This is the first launch"
	echo "running ENACT bootscripts..."
	echo "Please ALLOW any access requests"
	echo "and always type Y when prompt"
	sleep 10
	echo
#---
	termux-setup-storage
	apt update
	apt -y upgrade
	clear
#---

#---
	echo
	echo "Setup done successfully"
	echo "Please wait until the App exits"
	echo "then launch the App again"
	echo
	sleep 10
	touch $PREFIX/etc/not_first-launch
	exit
fi
