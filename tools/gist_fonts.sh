#!/bin/bash

#
# install nerd fonts
#
set -e
mkdir -p /tmp/work
pushd /tmp/work

sudo mkdir -p /usr/local/share/fonts/ttf/fonts-fantasquesansmono-nerd
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FantasqueSansMono.zip
sudo unzip -d /usr/local/share/fonts/ttf/fonts-fantasquesansmono-nerd FantasqueSansMono.zip

sudo mkdir -p /usr/local/share/fonts/ttf/fonts-dejavusansmono-nerd
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DejaVuSansMono.zip
sudo unzip -d /usr/local/share/fonts/ttf/fonts-dejavusansmono-nerd DejaVuSansMono.zip

fc-cache -f -v

popd
rm -rf /tmp/work
