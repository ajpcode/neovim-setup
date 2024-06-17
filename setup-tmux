#!/bin/bash

# Setup XDG_CONFIG_HOME variable (if not configured)
if [ -z ${XDG_CONFIG_HOME} ]; then
	export XDG_CONFIG_HOME=~/.config
	echo "export XDG_CONFIG_HOME=~/.config" >> ~/.profile
fi

# Prerequisites
echo "Setting up prerequisites..."
echo "==============================================================================="
#sudo apt update
#sudo apt -y upgrade
#sudo apt -y autoremove
#sudo apt install -y automake pkg-config libevent-dev bison flex libncurses-dev git

echo "Clearing any existing coinfig, build or installed tmux files"
echo "==============================================================================="
[ -d tmux ] && rm -rf tmux
[ $(which tmux | wc -l) -gt 0 ] && echo "Deleting existing tmux install" && sudo rm -f $(which tmux)
rm -rf ~/.config/tmux ~/.tmux

echo "Preparing to (re)build and (re)install"
echo "==============================================================================="
# Clone build and install TMUX
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure && make -j 8 && sudo make install

# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

mkdir -p ${XDG_CONFIG_HOME}/tmux
cp ../tmux-files/tmux.conf ${XDG_CONFIG_HOME}/tmux/tmux.conf

# Run TPM to install plugins
~/.tmux/plugins/tpm/bin/install_plugins 
