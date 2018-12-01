#!/bin/sh

#
# Test platforms: RHEL 6, 7, Ubuntu 16.04, 18.04, SuSE 12
# To keep it simple, this script doesn't install any package that
# should usually be installed via package manager for the distribution
#

main()
{
  # Use colors, but only if connected to a terminal, and that terminal
  # supports them.
  if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    MAGENTA="$(tput setaf 5)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    MAGENTA=""
    BOLD=""
    NORMAL=""
  fi

  set -e

  BASEDIR=$(dirname "$0")
  
  # zshrc

  if ! command -v zsh >/dev/null 2>&1; then
      printf "${YELLOW}zsh is not installed!\n${NORMAL}"
      exit 1
  fi

  if [ ! -d ~/.oh-my-zsh ]; then
    printf "${YELLOW}Oh-my-zsh is not installed${NORMAL}, suggest to install Oh My Zsh using the following command:\n"
    printf '  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"\n'
    exit 1
  fi

  if [ -f ~/.zshrc ]; then
    printf "${MAGENTA}Configuring zsh...${NORMAL}\n"
    sed -i '/^#seg_zshrc-begin/,/^#seg_zshrc-end/d' ~/.zshrc
    cat $BASEDIR/seg_zshrc >> ~/.zshrc

    if ! grep -c "vi-mode" ~/.zshrc >/dev/null 2>&1; then
      sed -i '/^plugins=(/a \ \ vi-mode' ~/.zshrc
    fi
  fi

  if [ -f /etc/zsh/zshrc ]; then
    if lsb_release -i | grep -i Ubuntu >/dev/null 2>&1; then
      if ! grep '. /etc/profile' /etc/zsh/zshrc >/dev/null 2>&1; then
          echo '. /etc/profile' >> /etc/zsh/zshrc
      fi
    fi
  fi

  printf "${GREEN}\t DONE.${NORMAL}\n"

  # vim

  if ! command -v vim >/dev/null 2>&1; then
    printf "${YELLOW}Vim is not installed!${NORMAL} Please install vim first!\n"
    exit 1
  fi

  printf "${MAGENTA}Configuring vim...${NORMAL}\n"

  if [ -f /etc/vimrc ]; then
    VIMRC=/etc/vimrc
  else
    VIMRC=/etc/vim/vimrc
  fi

  if [ -f $VIMRC ]; then
    UID=$(id -u)
    if [ "$UID" -eq 0 ]; then
      sed -i '/seg_vimrc-begin/,/seg_vimrc-end/d' ~/.zshrc
      cat $BASEDIR/seg_sys_vimrc >> $VIMRC
    fi
  fi

  if [ ! -e ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    cat $BASEDIR/seg_vimrc >> ~/.vimrc
    vim +'PlugInstall --sync' +qa
  fi

  printf "${GREEN}\t DONE.${NORMAL}\n"

  # git

  if ! command -v git >/dev/null 2>&1; then
      printf "${YELLOW}git is not installed!${NORMAL}\n"
      exit 0
  fi

  if command -v git >/dev/null 2>&1; then

    printf "${MAGENTA}Configuring git...${NORMAL}\n"

    git config --global core.editor vim
    git config --global core.excludesfile ~/.gitignore_global
    git config --global alias.ci     commit
    git config --global alias.co     checkout
    git config --global alias.st     status
    git config --global alias.br     branch
    git config --global alias.df     diff --color
    git config --global alias.visual !gitk
    git config --global alias.lg     "log --graph --pretty=format:'%Cred%h%Creset %C(bold yellow)<%an>%Creset -%Cgreen%cr%Creset %s' --abbrev-commit"
    git config --global alias.lg2    "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

    echo 'compile_commands.json' >~/.gitignore_global

    printf "${GREEN}\t DONE.${NORMAL}\n"
  fi

  # tmux
  printf "${MAGENTA}Configuring tmux...${NORMAL}\n"
  cp -uvf $BASEDIR/seg_tmux.conf ~/.tmux.conf
  printf "${GREEN}\t DONE.${NORMAL}\n"

  # neovim
  if command -v nvim >/dev/null 2>&1; then
    printf "${MAGENTA}Configuring nvim...${NORMAL}\n"

    [ ! -e ~/.config/nvim/ ] && mkdir -p ~/.config/nvim/
    if [ ! -e ~/.config/nvim/init.vim ]; then
        cat << EOF >~/.config/nvim/init.vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
EOF
    fi
    printf "${GREEN}\t DONE.${NORMAL}\n"
  fi

  # ls colors
  printf "${MAGENTA}Configuring ls colors...${NORMAL}\n"
  if [ ! -f ~/.dircolors ]; then
      [ ! -d ~/.config ] && mkdir ~/.config
      cp -rv $BASEDIR/dircolors ~/.config/
      ln -s ~/.config/dircolors/solarized-dark-256 ~/.dircolors
  fi
  printf "${GREEN}\t DONE.${NORMAL}\n"

  if [ "$1" != "--extra" ]; then
      printf "${YELLOW}If you want to install fd, ripgrep and fzf, please run with '--extra' again!\n${NORMAL}"
      exit 0
  else
    printf "${GREEN}Please re-login to take effect.${NORMAL}\n"
  fi

  # fd & ripgrep
  if ! command -v cargo >/dev/null 2>&1; then
    printf "${MAGENTA}Installing rust & cargo...${NORMAL}\n"
    curl -sSf https://static.rust-lang.org/rustup.sh | sh
    echo 'export PATH=$PATH:~/.cargo/bin' >> ~/.zshrc
  fi
  if ! command -v fd >/dev/null 2>&1; then
    printf "${MAGENTA}Installing fd...${NORMAL}\n"
    cargo install fd-find
  fi
  if ! command -v rg >/dev/null 2>&1; then
    printf "${MAGENTA}Installing ripgrep...${NORMAL}\n"
    cargo install ripgrep
  fi

  # fzf
  if [ ! ~/.fzf ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --completion --key-bindings --update-rc --no-bash
  fi
}

main $@
