#!/bin/bash

# CLI
sudo pacman -S \
     stow \
     make \
     git diff-so-fancy\
     fzf ripgrep fd \
     zsh wget curl \
     neovim python-neovim vim \
     emacs-native-comp-git \
     go \
     nodejs npm \
     python-pip \
     python-jedi \
     dotnet-sdk \
     jdk-openjdk

sudo npm install -g dockerfile-language-server-nodejs bash-language-server

# GUI
sudo pacman -S \
     rxvt-unicode-pixbuf \
     i3 rofi i3status-rust-git \
     nerd-fonts-fantasque-sans-mono nerd-fonts-inconsolata ttf-font-awesome ttf-unifont wqy-microhe \
     lxappearance-gtk3

# optional
sudo pacman -S \
     lua
