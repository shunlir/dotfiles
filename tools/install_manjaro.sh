#!/bin/bash

# CLI
# archlinuxcn: emacs-native-comp-git
sudo pacman -S \
     stow \
     make \
     git diff-so-fancy\
     fzf ripgrep fd \
     zsh wget curl \
     neovim python-neovim vim \
     tmux \
     emacs-native-comp-git \
     yay \
     go \
     nodejs npm \
     python-pip \
     python-jedi \
     dotnet-sdk \
     jdk-openjdk

sudo npm install -g dockerfile-language-server-nodejs bash-language-server

# GUI
# aur: xvt-unicode-pixbuf tf-unifont
# archlinuxcn: nerd-fonts-fantasque-sans-mono nerd-fonts-inconsolata
yay -S \
     rxvt-unicode-pixbuf \
     i3-wm rofi i3status-rust \
     nerd-fonts-fantasque-sans-mono nerd-fonts-inconsolata ttf-font-awesome ttf-unifont wqy-microhe \
     lxappearance-gtk3

# optional
sudo pacman -S \
     lua
