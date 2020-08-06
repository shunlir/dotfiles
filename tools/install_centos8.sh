#!/bin/bash

set -e

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P  )"

sudo dnf groupinstall "Development Tools"
sudo dnf install zsh stow cmake ninja-build

sudo dnf config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
sudo wget -P /etc/yum.repos.d/ https://download.opensuse.org/repositories/shells:zsh-users:zsh-completions/CentOS_8/shells:zsh-users:zsh-completions.repo
sudo dnf install ripgrep zsh-completions

. "$SCRIPTPATH/gist_fd.sh"

mkdir ~/code
#
# emacs 27
#
sudo dnf install texinfo gtk3-devel libXpm-devel libjpeg-turbo-devel giflib-devel libtiff-devel gnutls-devel ncurses-devel
cd ~/code
git clone --depth=1 https://github.com/emacs-mirror/emacs.git -b emacs-27
cd emacs
./autogen.sh
./configure
make
sudo make install

#
# git 2.x
#
sudo dnf install -y wget perl-CPAN gettext-devel perl-devel openssl-devel zlib-devel libcurl-devel expat-devel
cd ~/code
export VER="2.27.0"
wget https://github.com/git/git/archive/v${VER}.tar.gz
tar -xf v${VER}.tar.gz
cd git-*
make prefix=/usr/local/git all
sudo make prefix=/usr/local/git install
# add /usr/local/git/bin into $PATH
echo 'export PATH=/usr/local/git/bin:$PATH' >> ~/.zshrc.local

#
# neovim
#
cd ~/code
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=Release
sudo make install

sudo curl -sL install-node.now.sh/lts | sudo bash
sudo pip3 install pynvim
nvim -c 'CocInstall coc-snippets'
nvim -c 'CocInstall coc-json'

#
# i3
#
sudo dnf -y install libev-devel startup-notification-devel xcb-util-devel xcb-util-cursor-devel \
    xcb-util-keysyms-devel xcb-util-wm-devel xorg-x11-util-macros libxkbcommon-x11-devel yajl-devel
cd ~/code && git clone https://github.com/Airblader/xcb-util-xrm.git
cd xcb-util-xrm && rm -rf m4 && git clone https://gitlab.freedesktop.org/xorg/util/xcb-util-m4 m4

cd ~/code/xcb-util-xrm && ./autogen.sh && make && sudo make install
[ -f /etc/ld.so.conf.d/local.conf ] || sudo echo '/usr/local/lib' > /etc/ld.so.conf.d/local.conf

cd ~/code && git clone https://github.com/i3/i3.git
cd ~/code/i3
autoreconf -fi
mkdir -p build && cd build
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig ../configure
make -j8
sudo make install

# fonts
mkdir -p ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FantasqueSansMono/Regular/complete/Fantasque%20Sans%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.ttf
wget https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Roman.ttf
wget https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Italic.ttf
fc-cache -f

# rofi
sudo dnf install librsvg2-devel
cd ~/code
git clone --recursivehttps://github.com/davatorium/rofi.git
autoreconf -i
mkdir build && cd build
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig ../configure --disable-check
make
sudo make install

#
# ccls
#
dnf install llvm-devel clang-devel
cd ~/code
git clone --depth=1 --recursive https://github.com/MaskRay/ccls
cd ccls
cmake -H. -BRelease -G Ninja -DCMAKE_BUILD_TYPE=Release
ninja -C Release
sudo cp Release/ccls /usr/local/bin
