# zshrc

ZPLG_HOME=~/.zplugin

install()
{
  if ! command -v zsh >/dev/null 2>&1; then
    warn "zsh is not installed!\n"
    return 1
  fi

  if [ ! -d "${ZPLG_HOME}" ]; then
    info "Installing ZPlug...\n"

    mkdir "${ZPLG_HOME}"
    chmod g-rwX "${ZPLG_HOME}"

    info "Downloading zplugin to $ZPLG_HOME/bin"
    if [ -d "$ZPLG_HOME/bin/.git" ]; then
      cd "$ZPLG_HOME/bin"
      git pull origin master
    else
      cd "$ZPLG_HOME"
      git clone --depth 10 https://github.com/zdharma/zplugin.git bin
    fi
  fi

  info "Configuring zsh...\n"

  if [ -f ~/.zshrc ]; then
    if ! grep -c "init.zsh" ~/.zshrc >/dev/null 2>&1; then
      echo >> "source ~/.dotfiles/zsh/init.zsh"
    fi
  fi

  # let ubuntu source bash profile
  if [ "$UID" -eq 0 -a -f /etc/os-release -a -f /etc/zsh/zshrc ]; then
    if grep -i -c Ubuntu /etc/os-release >dev/null 2>&1; then
      if [ -f /etc/zsh/zshrc ]; then
        info "enable zsh sourcing /etc/profile"
        if ! grep '. /etc/profile' /etc/zsh/zshrc >/dev/null 2>&1; then
            echo '. /etc/profile' >> /etc/zsh/zshrc
        fi
      fi
    fi
  fi

  success "\t DONE.\n"
}

install
