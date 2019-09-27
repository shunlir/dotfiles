#!/bin/sh

set -e

sudo yum groupinstall "Development Tools"

mkdir ~/src
#
# emacs 26.3
#
cd ~/src
export VER="26.3"
sudo yum-builddep emacs
#sudo yum install -y gtk+-devel gtk2-devel libXpm-devel libpng-devel giflib-devel \
#    libtiff-devel libjpeg-devel ncurses-devel gpm-devel \
#    dbus-devel dbus-glib-devel dbus-python GConf2-devel pkgconfig libXft-devel 
wget https://ftp.gnu.org/gnu/emacs/emacs-${VER}.tar.xz
tar xf emacs-${VER}.tar.xz
cd emacs-*
./configure && make
sudo make install

# git2
cd ~/src
sudo yum -y install -y wget perl-CPAN gettext-devel perl-devel openssl-devel zlib-devel
export VER="2.22.0"
wget https://github.com/git/git/archive/v${VER}.tar.gz
tar -xf v${VER}.tar.gz
cd git-*
make install

# i3
sudo yum -y install libev-devel startup-notification-devel xcb-util-devel xcb-util-cursor-devel xcb-util-keysyms-devel xcb-util-wm xorg-x11-util-macros
cd ~/src && git clone https://github.com/Airblader/xcb-util-xrm.git
cd xcb-util-xrm && rm -rf m4 && git clone https://gitlab.freedesktop.org/xorg/util/xcb-util-m4 m4
cd ~/src && git clone https://github.com/i3/i3.git

cd ~/src/xcb-util-xrm && ./autogen.sh && make && sudo make install
[ ! -r /etc/ld.so.conf.d/local.conf ] || sudo echo '/usr/local/bin' > /etc/ld.so.conf.d/local.conf
cd ~/src/i3
autoreconf -fi
mkdir -p build && cd build
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig ../configure
make -j8
sudo make install

# fonts
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FantasqueSansMono/Regular/complete/Fantasque%20Sans%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.ttf
fc-cache -f

# flex
sudo yum install gettext-devel texinfo-tex Gettext-autopoint
cd ~/src
wget https://github.com/westes/flex/archive/flex-2.5.39.tar.gz
tar xf flex-2.5.39.tar.gz
cd flex-2.5.39
sed -i sed '/.*doc \\/d' Makefile.am
./configure --prefix=$HOME/tools/usr --docdir=$HOME/tools/usr/share/doc/flex-2.5.39
make && make install
export PATH=~/tools/usr/bin:$PATH

# rofi
mkdir build && cd build
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig ../configure --disable-check
make
sudo make install
