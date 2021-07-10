#!/bin/sh

# create /etc/wsl.conf
if [ ! -e "/etc/wsl.conf" ]; then
  sudo cp wsl.conf /etc/wsl.conf
fi

# create symbolic links.
# Windows Desktop
ln -fsn "/mnt/c/Users/$(whoami)/Desktop" ~/Desktop

# Windows Downloads dir
ln -fsn "/mnt/c/Users/$(whoami)/Downloads" ~/Downloads

# clip.exe
sudo ln -fsn "/mnt/c/Windows/system32/clip.exe" /usr/local/bin/clip

# Command Prompt
sudo ln -fsn /mnt/c/Windows/system32/cmd.exe /usr/local/bin/cmd.exe

# PowerShell
sudo ln -fsn /mnt/c/Windows/system32/WindowsPowerShell/v1.0/powershell.exe /usr/local/bin/powershell.exe

# vscode
VSCODE_BIN="/mnt/c/Users/$(whoami)/AppData/Local/Programs/Microsoft VS Code/bin/code"
if [ -e "$VSCODE_BIN" ]; then
  sudo ln -fsn "$VSCODE_BIN" /usr/local/bin/code
fi

# Docker Desktop
DOCKER_DESKTOP_BIN="/mnt/c/Program Files/Docker/Docker/resources/bin/docker-credential-desktop.exe"
if [ -e "$DOCKER_DESKTOP_BIN" ]; then
  sudo ln -fsn "$DOCKER_DESKTOP_BIN" /usr/local/bin/docker-credential-desktop.exe
fi
