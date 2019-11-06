#!/bin/bash

set -e

#
# text mode
#

apt install -y git vim wget lua50 zsh emacs tmux \
    neovim python-neovim python3-neovim

wget -P /usr/local/bin/ https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
chmod a+x /usr/local/bin/diff-so-fancy 

[ -d /tmp/work] || mkdir -p /tmp/work

wget -P /tmp/work https://github.com/sharkdp/fd/releases/download/v7.4.0/fd_7.4.0_amd64.deb
dpkg -i /tmp/work/fd_7.4.0_amd64.deb

wget -P /tmp/work https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
dpkg -i /tmp/work/ripgrep_11.0.2_amd64.deb

rm -rf /tmp/work

#
# GUI
#
[ "$1" == "--gui" ] || exit 0

apt install -y rxvt-unicode-256color fonts-font-awesome \
    i3 rofi

dest=/usr/local/share/fonts/truetype/fonts-fantasquesansmono-nerd
if [ ! -d $dest ]; then
    mkdir -p $dest
fi
wget -P $dest https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/FantasqueSansMono.zip
unzip -d $dest FantasqueSansMono.zip

[ -d /tmp/work ] || mkdir /tmp/work
cd /tmp/work

apt install -y libdbus-1-dev
git clone https://github.com/greshake/i3status-rust.git
cd i3status-rust && cargo build --release
cp target/release/i3status-rs /usr/local/bin/

rm -rf /tmp/work
