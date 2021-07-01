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
dnsutils
man
unzip
nmap
tree
traceroute
net-tools
dnsutils
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

# install gcloud SDK
# see: https://cloud.google.com/sdk/docs/install#deb
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get -y install apt-transport-https ca-certificates gnupg
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get -y install google-cloud-sdk

