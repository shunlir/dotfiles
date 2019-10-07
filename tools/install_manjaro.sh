#!/bin/bash

# required
sudo pacman -S git diff-so-fancy\
     zsh wget curl subversion lua \
     rxvt-unicode-pixbuf \
     neovim python-neovim vim \
     emacs npm \
     i3 rofi i3status-rust-git polybar \
     nerd-fonts-fantasque-sans-mono nerd-fonts-inconsolata ttf-font-awesome-4 ttf-unifont

sudo npm install -g vmd

# optional
sudo pacman -S lxappearance-gtk3 \
     ripgrep fd \
     wqy-microhe

sudo yay -S fcitx-qt
