if [ -x /data/data/com.termux/files/usr/libexec/termux/command-not-found ]; then
	command_not_found_handle() {
		/data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
	}
fi

PS1='\$ '

FILE=$PREFIX/etc/not_first-launch
if [ -f "$FILE" ]; then
	echo
	sleep 2
	echo "This is NOT the first launch"
	echo "Initial setup is already done"
	echo "starting node-red..."
	echo
	sleep 4
	node-red
else
	echo
	sleep 2
	echo "This is the first launch"
	echo "running ENACT bootscript..."
	echo "Please ALLOW any access requests"
	echo "and always type Y when prompt"
	echo
	sleep 4
#---
	termux-setup-storage
	apt update --yes
	apt install --yes coreutils binutils nano termux-api nodejs
	npm i -g --unsafe-perm node-red
	cd $HOME
	mkdir .node-red
	cd .node-red
	cp $PREFIX/tmp/flows_localhost.json .
	npm install node-red-admin
	npm install node-red-dashboard
	npm install node-red-contrib-termux-api
	cd $HOME
	clear
#---
	echo
	echo "Setup done successfully"
	echo "Please wait until the Termux PNS exits"
	echo "then launch the Termux again"
	echo
	sleep 4
	touch $PREFIX/etc/not_first-launch
	exit
fi
