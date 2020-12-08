#!/bin/bash

set -e

#
# text mode
#

if [ "$(lsb_release -rs | cut -d. -f1)" = 18 ]; then
  add-apt-repository -y ppa:neovim-ppa/stable
  add-apt-repository -y ppa:kelleyk/emacs
  apt update -y
fi
apt install -y git vim wget lua5.1 zsh emacs27 tmux \
    neovim python-neovim python3-neovim golang

if ! command -v diff-so-fancy >/dev/null 2>&1; then
  wget -P /usr/local/bin/ https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
  chmod a+x /usr/local/bin/diff-so-fancy
fi

[ -d /tmp/work] || mkdir -p /tmp/work

if ! command -v fd >/dev/null 2>&1; then
  wget -P /tmp/work https://github.com/sharkdp/fd/releases/download/v8.2.1/fd_8.2.1_amd64.deb
  dpkg -i /tmp/work/fd_8.2.1_amd64.deb
fi

if ! command -v rg >/dev/null 2>&1; then
  wget -P /tmp/work https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
  dpkg -i /tmp/work/ripgrep_12.1.1_amd64.deb
fi

if ! command -v fzf >/dev/null 2>&1; then
  wget -P /tmp/work https://github.com/junegunn/fzf/releases/download/0.24.4/fzf-0.24.4-linux_amd64.tar.gz
  tar xf /tmp/work/fzf-0.24.4-linux_amd64.tar.gz -C /usr/local/bin
  chmod a+x /usr/local/bin/fzf
fi

if ! command -v node >/dev/null 2>&1; then
  curl -sL install-node.now.sh/lts | bash
fi

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
