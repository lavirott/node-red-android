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
	echo
else
	echo "This is the first launch"
	echo "running ENACT bootscripts..."
	echo "Please ALLOW any access requests"
	echo "and always type Y when prompt"
	sleep 10
	echo

# Determin Compute IP address
IP=`ifconfig wlan0 | grep "inet " | cut -d ' ' -f 10`

# Update/Upgrade installed system
termux-setup-storage
apt update
apt -y upgrade

# Install OpenSSH
apt install -y openssh

echo "Setting up password authentication..."
echo "PasswordAuthentication yes" >> $PREFIX/etc/ssh/ssh_config
echo "Enter a user password:"

passwd
result="$?"
while [ "$result" != "0" ]
do
	echo "Password not correctly set. Retry..."
	passwd
	result="$?"
done
echo "Password correctly set !"
echo

sshd
echo

# From your PC
echo "Setting up public key authentication..."
echo " From you PC, type the following command:"
echo "ssh-copy-id -p 8022 -i id_rsa $IP"
echo "Press \"Enter\" key when done..."
read
while [ ! -e "$HOME/.ssh/authorized_keys" ]
do
  echo "Authorized_keys is not properly set. Retry..."
	echo "Press \"Enter\" key when done..."
	read
done
echo

# Disable password authentication
echo "Disabling password authentication..."
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' $PREFIX/etc/ssh/ssh_config
echo "Password authentication disabled."
echo

# Restart OpenSSH server
pkill sshd
sshd
echo

# Install Node.js
apt -y install coreutils
apt -y install binutils
apt -y install nano
apt -y install nodejs
echo

# Install Node-RED
npm i -g --unsafe-perm node-red
echo

# Install termUX:API to allow node-red-contrib-termux-api nodes to work 
apt -y install termux-api
echo

# To install node packages
cd $HOME/
mkdir .node-red
cd .node-red
npm install node-red-dashboard
npm install node-red-contrib-termux-api
cd $HOME/

# Print Configuration
echo "You are now able to connect with:"
echo " ssh -p 8022 $IP"
echo
	clear

	echo
	echo "Setup done successfully"
	echo "Please wait until the App exits"
	echo "then launch the App again"
	echo
	sleep 10
	touch $PREFIX/etc/not_first-launch
	exit
fi
