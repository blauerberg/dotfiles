#!/bin/sh

# install base packages
PACKAGES="
git
git-flow
zsh
tmux
vim
rsync
rxvt-unicode-256color
fonts-font-awesome
fonts-noto-cjk
ttf-dejavu"

sudo apt-get update
sudo apt-get -y install $PACKAGES

# install vscode
# see: https://code.visualstudio.com/docs/setup/linux
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/packages.microsoft.gpg
sudo install -o root -g root -m 644 /tmp/packages.microsoft.gpg /usr/share/keyrings/
sudo rm -f /tmp/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get -y install apt-transport-https
sudo apt-get update
sudo apt-get -y install code

# install Docke CE
# see: https://docs.docker.com/install/linux/docker-ce/debian/
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
sudo systemctl enable docker
sudo systemctl restart docker

# install DejaVu Sans Mono for Powerline
# see: https://github.com/powerline/fonts/tree/master/DejaVuSansMono
mkdir -p ${HOME}/.local/share/fonts
curl -o "${HOME}/.local/share/fonts/DejaVu Sans Mono for Powerline.ttf" https://github.com/powerline/fonts/raw/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf
fc-cache -f

# install urxvt-resize-font
# see: https://github.com/simmel/urxvt-resize-font
mkdir -p ${HOME}/.urxvt/ext/
curl -o ${HOME}/.urxvt/ext/resize-font https://raw.githubusercontent.com/simmel/urxvt-resize-font/master/resize-font

