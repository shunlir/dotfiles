#!/bin/sh

set -e

sudo yum groupinstall "Development Tools"

mkdir ~/code
#
# emacs 26.3
#
sudo yum-builddep emacs
cd ~/code
export VER="26.3"
wget https://ftp.gnu.org/gnu/emacs/emacs-${VER}.tar.xz
tar xf emacs-${VER}.tar.xz
cd emacs-*
./configure && make
sudo make install

#
# git2
#
sudo yum -y install -y wget perl-CPAN gettext-devel perl-devel openssl-devel zlib-devel
cd ~/code
export VER="2.22.0"
wget https://github.com/git/git/archive/v${VER}.tar.gz
tar -xf v${VER}.tar.gz
cd git-*
make prefix=/usr/local/git all
sudo make prefix=/usr/local/git install
# add /usr/local/git/bin into $PATH

#
# i3
#
sudo yum -y install libev-devel startup-notification-devel xcb-util-devel xcb-util-cursor-devel xcb-util-keysyms-devel xcb-util-wm xorg-x11-util-macros
cd ~/code && git clone https://github.com/Airblader/xcb-util-xrm.git
cd xcb-util-xrm && rm -rf m4 && git clone https://gitlab.freedesktop.org/xorg/util/xcb-util-m4 m4
cd ~/code && git clone https://github.com/i3/i3.git

cd ~/code/xcb-util-xrm && ./autogen.sh && make && sudo make install
[ ! -r /etc/ld.so.conf.d/local.conf ] || sudo echo '/usr/local/bin' > /etc/ld.so.conf.d/local.conf
cd ~/code/i3
autoreconf -fi
mkdir -p build && cd build
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig ../configure
make -j8
sudo make install

# fonts
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FantasqueSansMono/Regular/complete/Fantasque%20Sans%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.ttf
fc-cache -f

sudo yum -yu install adobe-source-code-pro-fonts

# flex, for building rofi
sudo yum install gettext-devel texinfo-tex Gettext-autopoint
cd ~/code
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

#
# ccls
#
sudo yum install -y centos-release-scl
sudo yum install -y llvm-toolset-7.0
scl enable llvm-toolset-7.0 bash

cd ~/code
git clone https://github.com/llvm/llvm-project.git
cd llvm-project
cmake -Hllvm -BRelease -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS=clang -DLLVM_TARGETS_TO_BUILD=X86
ninja

cd ~/code
git clone --depth=1 --recursive https://github.com/MaskRay/ccls
cd ccls
LLVM=$HOME/src/llvm-project
cmake -H. -BRelease -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_EXE_LINKER_FLAGS=-fuse-ld=lld -DCMAKE_PREFIX_PATH="$LLVM/Release;$LLVM/llvm;$LLVM/clang"
ninja -C Release
cp Release/ccls /usr/local/bin

#
# vim 8
#
cd ~/code
git clone https://github.com/vim/vim.git
cd vim
./configure --enable-multibyte --enable-cscope --prefix=$HOME/.local \
    --enable-multibyte \
    --enable-rubyinterp \
    --enable-pythoninterp \
    --enable-perlinterp \
    --enable-luainterp \
    --enable-python3interp
make && make install

