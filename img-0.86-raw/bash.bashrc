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