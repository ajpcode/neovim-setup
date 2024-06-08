# Setup XDG_CONFIG_HOME variable (if not configured)
if [ -z ${XDG_CONFIG_HOME} ]; then
	export ${XDG_CONFIG_HOME}=~/.config
	echo "export ${XDG_CONFIG_HOME}=~/.config" >> ~/.profile
fi

# Identify Ubuntu, if not exit for now
if [ $(grep DISTRIB_ID /etc/lsb-release | sed 's/^.*=//g' | wc -l) -eq 1 ]; then
	# Prep environment
	sudo apt-get update
	sudo apt-get -y upgrade

	# Build tools for neovim
	sudo apt-get install -y ninja-build gettext cmake unzip curl build-essential make

	# Remove basic vim
	sudo apt-get remove -y vim vi
	sudo apt-get -y autoremove
else
	echo "Fatal: Did not detect Ubuntu distro (required)."
	exit 1
fi

# Clean down nvim config (if it exists)
[ -d "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim ] && rm -rf "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

# Download build and install neovim is not installed
if [ $(which nvim | wc -l) -ne 1 ]; then
	[ -d neovim ] && rm -rf neovim
	git clone https://github.com/neovim/neovim.git
	cd neovim
	make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install
fi

# Scrub config
rm -rf ${XDG_CONFIG_HOME}/nvim

# Install kickstart
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim


