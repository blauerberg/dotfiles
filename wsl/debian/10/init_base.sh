#!/bin/sh

# install base packages
PACKAGES="
git
git-flow
zsh
tmux
rsync
neovim
python3-neovim
diffstat
wget
unzip
jq
ranger
python3-pip
sqlite3
mariadb-client
"

sudo apt-get update
sudo apt-get -y install $PACKAGES

# install Docke CE
# see: https://docs.docker.com/install/linux/docker-ce/debian/
sudo apt-get -y remove docker docker-engine docker.io containerd runc
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker ${USER}

# install DejaVu Sans Mono for Powerline
# see: https://github.com/powerline/fonts/tree/master/DejaVuSansMono
#mkdir -p ${HOME}/.local/share/fonts
#curl -o "${HOME}/.local/share/fonts/DejaVu Sans Mono for Powerline.ttf" https://github.com/powerline/fonts/raw/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf
#fc-cache -f
