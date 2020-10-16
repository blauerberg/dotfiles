#!/bin/sh

# create /etc/wsl.conf
if [ ! -e "/etc/wsl.conf" ]; then
  sudo cp wsl.conf /etc/wsl.conf
fi

# symbolic link for Windows Desktop
ln -fs "/mnt/c/Users/$(whoami)/Desktop" ~/Desktop

# symbolic link for vscode
VSCODE_BIN="/mnt/c/Users/$(whoami)/AppData/Local/Programs/Microsoft VS Code/bin/code"
if [ -e "$VSCODE_BIN" ]; then
  sudo ln -fs "$VSCODE_BIN" /usr/local/bin/code
fi

# symbolic link for clip.exe
sudo ln -fs  "/mnt/c/Windows/system32/clip.exe" /usr/local/bin/clip
