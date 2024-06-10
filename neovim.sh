COL="\e[32m"
ERR="\e[31m"
CEND="\e[0m"

cechon() {
	echo -e -n ${COL}$@${CEND}
}
cecho() {
	echo -e ${COL}$@${CEND}
}

# Setup XDG_CONFIG_HOME variable (if not configured)
cechon "Configuring XDG_CONFIG_HOME variable... "
if [ -z ${XDG_CONFIG_HOME} ]; then
	export ${XDG_CONFIG_HOME}=~/.config
	echo "export ${XDG_CONFIG_HOME}=~/.config" >> ~/.profile
	echo "OK"
else
	echo "Not required"
fi

cechon "Configuring ~/.profile... "
[ $(grep "alias vi" ~/.profile | wc -l) -eq 0 ] && echo "alias vi=\"nvim\"" >> ~/.profile && echo "alias vim=\"nvim\"" >> ~/.profile && echo "OK" || echo "Not required"

# Identify Ubuntu, if not exit for now
cecho "Updating and installing any missing build dependencies..."
if [ $(grep DISTRIB_ID /etc/lsb-release | sed 's/^.*=//g' | wc -l) -eq 1 ]; then
	# Prep environment
	sudo apt-get update
	sudo apt-get -y upgrade

	# Build tools for neovim
	sudo apt-get install -y ninja-build gettext cmake unzip curl build-essential make

	# Remove basic vim
	sudo apt-get -y autoremove
else
	echo -e ${ERR}"Fatal: Did not detect Ubuntu distro (required)."${CEND}
	exit 1
fi
cecho "- Finished updating and installing any missing build dependencies."

# Clean down nvim config (if it exists)
cechon "Clean down any existing build dependencies... "
[ -d "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim ] && rm -rf "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim && echo "OK" || echo "FAILED"

# Download build and install neovim
cecho "Downloading and building NeoVim from source..."
[ -d neovim ] && rm -rf neovim
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
cecho "Finished downloading and building NeoVim from source."

# Install kickstart
cechon "Configuring NeoVim... "
#git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
mkdir -p ${XDG_CONFIG_HOME}/nvim
cd ..
cp neovim.init.lua ${XDG_CONFIG_HOME}/nvim/init.lua && echo "OK" || echo "FAILED"
echo

mkdir -p ${XDG_CONFIG_HOME}/lua/custom/plugins/

cecho "NeoVim installation complete!"
