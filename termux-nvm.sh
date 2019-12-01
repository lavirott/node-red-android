#!/data/data/com.termux/files/usr/bin/bash

#---------------
# Node.JS via NVM
#---------------
# https://github.com/cncjs/cncjs/wiki/Setup-Guide:-Raspberry-Pi-%7C-Install-Node.js-via-Node-Version-Manager-(NVM)
# Install Node Version Manager (NVM)
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
# Rerun Profile script to start NVM
source ~/.bashrc  # Rerun profile after installing nvm
# Install Node.js using Node Version Manager
nvm install 8  # Installs Node v8, (nvm install stable) installs Latest version of node
nvm use 8  # Sets Node to use v8