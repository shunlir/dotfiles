#!/bin/bash

set -eux

get_distro_ver() {
  [ -e /etc/os-release ] && . /etc/os-release
  local platform="$ID${VERSION_ID:+.${VERSION_ID}}"
  case "$platform" in
    "ubuntu.20.04")
      echo "ubuntu.20.04"
      return 0
      ;;
    "ubuntu.18.04")
      echo "ubuntu.18.04"
      return 0
      ;;
    "ubuntu.16.04")
      echo "ubuntu.16.04"
      return 0
      ;;
    "debian.11")
      echo "debian.11"
      return 0
      ;;
  esac
  return 1
}

has_cmd() {
  command -v "$1" >/dev/null 2>&1
}

ins_delta() {
  if ! command -v delta >/dev/null 2>&1; then
    cd "$work"
    local version="0.13.0"
    wget https://github.com/dandavison/delta/releases/download/${version}/git-delta_${version}_amd64.deb
    dpkg -i git-delta_${version}_amd64.deb
  fi
}

ins_fd() {
  if ! has_cmd fd; then
    cd "$work"
    local version="8.4.0"
    wget https://github.com/sharkdp/fd/releases/download/v${version}/fd_${version}_amd64.deb
    dpkg -i fd_${version}_amd64.deb
  fi
}

ins_rg() {
  if ! has_cmd rg; then
    cd "$work"
    local version="13.0.0"
    wget https://github.com/BurntSushi/ripgrep/releases/download/${version}/ripgrep_${version}_amd64.deb
    dpkg -i ripgrep_${version}_amd64.deb
  fi

}

ins_fzf() {
  if ! has_cmd fzf; then
    cd "$work"
    local version="0.30.0"
    wget https://github.com/junegunn/fzf/releases/download/${version}/fzf-${version}-linux_amd64.tar.gz
    tar xf /tmp/work/fzf-${version}-linux_amd64.tar.gz -C /usr/local/bin
    chmod a+x /usr/local/bin/fzf
    wget -P /usr/local/bin/ https://raw.githubusercontent.com/junegunn/fzf/master/bin/fzf-tmux
    chmod a+x /usr/local/bin/fzf-tmux
  fi
}

ins_bat() {
  if ! has_cmd bat; then
    cd "$work"
    local version="0.21.0"
    wget https://github.com/sharkdp/bat/releases/download/v${version}/bat_${version}_amd64.deb
    dpkg -i bat_${version}_amd64.deb
  fi
}

ins_node() {
  if ! has_cmd node; then
    curl -sL install-node.now.sh/lts | bash
  fi
}

ins_zsh() {
  apt-get install -y libncurses5-dev
  cd "$work"
  local version="5.7"
  wget https://www.zsh.org/pub/old/zsh-${version}.tar.xz
  tar xf zsh-${version}.tar.xz
  cd zsh-${version}
  ./configure
  make -j2
  make install
  apt-get remove --purge -y libncurses5-dev
}

ins_nerd_fonts() {
  local ttf_dir="/usr/local/share/fonts/ttf"
  [ -d "${ttf_dir}" ] || mkdir -p "${ttf_dir}"

  local curr_font_dir="${ttf_dir}/fonts-fantasquesansmono-nerd"
  if [ ! -d "${curr_font_dir}" ]; then
    mkdir -p "${curr_font_dir}" && cd "$curr_font_dir"
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FantasqueSansMono.zip
    unzip FantasqueSansMono.zip
    rm FantasqueSansMono.zip
  fi

  curr_font_dir="${ttf_dir}/fonts-dejavusansmono-nerd"
  if [ ! -d "${curr_font_dir}" ]; then
    mkdir -p "${curr_font_dir}" && cd "$curr_font_dir"
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DejaVuSansMono.zip
    unzip DejaVuSansMono.zip
    rm DejaVuSansMono.zip
  fi

  curr_font_dir="${ttf_dir}/fonts-hack-nerd"
  if [ ! -d "${curr_font_dir}" ]; then
    mkdir -p "${curr_font_dir}" && cd "$curr_font_dir"
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
    unzip Hack.zip
    rm Hack.zip
  fi
}

ins_i3status_rust() {
  if ! has_cmd i3status-rs; then
    if [ ! -f ~/.cargo/env ]; then
      curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable --no-modify-path -y
    fi
    . ~/.cargo/env
    apt-get install -y libdbus-1-dev libssl-dev libsensors-dev
    cd "$work"
    git clone --depth=1 https://github.com/greshake/i3status-rust.git
    cd i3status-rust && cargo build --release
    cp target/release/i3status-rs /usr/local/bin/
    mkdir -p /usr/share/i3status-rust
    cp -r files/* /usr/share/i3status-rust/
  fi
}


prep_ubuntu1804() {
  add-apt-repository -y ppa:kelleyk/emacs
  apt-get update
  apt-get install -y git wget curl tmux emacs28 zsh
  ins_delta
  ins_fd
  ins_rg
  ins_fzf
  ins_node

  [ "$1" == "--gui" ] || return 0
  apt-get install -y rxvt-unicode-256color fonts-font-awesome \
      i3 rofi
  ins_nerd_fonts
  ins_i3status_rust
}

prep_ubuntu2004() {
  add-apt-repository -y ppa:kelleyk/emacs
  apt-get update
  apt-get install -y git wget curl tmux emacs28 zsh
  ins_delta
  ins_fd
  ins_rg
  ins_fzf
  ins_node

  [ "$1" == "--gui" ] || return 0
  apt-get install -y rxvt-unicode-256color fonts-font-awesome \
      i3 rofi
  ins_nerd_fonts
  ins_i3status_rust
}

prep_debian11() {
  apt-get install -y git wget curl emacs zsh build-essential
  ins_fzf
  ins_node
  test -d /home/linuxbrew/.linuxbrew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install rg fd delta exa bat zoxide broot tmux

  [ "${1:-no}" == "--gui" ] || return 0
  apt-get install -y rxvt-unicode-256color fonts-font-awesome \
      i3 rofi
  ins_nerd_fonts
  ins_i3status_rust
}

work="/tmp/work"
platform="$(get_distro_ver)"

[ -d "$work" ] || mkdir -p "$work"

case "$platform" in
  "ubuntu.20.04")
    echo "ubuntu.20.04"
    prep_ubuntu2004 $@
    ;;
  "ubuntu.18.04")
    echo "ubuntu.18.04"
    prep_ubuntu1804 $@
    ;;
  "ubuntu.16.04")
    echo "ubuntu.16.04"
    prep_ubuntu1604 $@
    ;;
  "debian.11")
    echo "debian.11"
    prep_debian11 $@
    ;;
  *)
    echo "unsupported distro: $platform"
    ;;
esac

rm -rf /tmp/work
