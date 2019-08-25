# zshrc

install()
{
  if ! command -v zsh >/dev/null 2>&1; then
    warn "zsh is not installed!\n"
    return 1
  fi

  if [ ! -d ~/.oh-my-zsh ]; then
    warn "Oh-my-zsh is not installed.\n"
    info "suggest to install Oh My Zsh using the following command:\n"
    info '  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"\n'
    return 1
  fi

  info "Configuring zsh...\n"

  if [ -f ~/.zshrc ]; then
    sed -i 's/^ZSH_THEME.*/ZSH_THEME=simple/' ~/.zshrc

    if ! egrep -c "^\s*ZSH_CUSTOM" ~/.zshrc >/dev/null 2>&1; then
      sed -E -i '/ZSH_CUSTOM=/a ZSH_CUSTOM=~/.dotfiles/zsh/oh-my-zsh-custom' ~/.zshrc
    fi

    if ! grep -c "vi-mode" ~/.zshrc >/dev/null 2>&1; then
      sed -E -i '/^plugins=\(\s*$/a \ \ vi-mode' ~/.zshrc
      sed -E -i 's/^plugins=\((.*)\)\s*$/plugins=\(\1 vi-mode\)/g'  ~/.zshrc
    fi
  fi

  # let ubuntu source bash profile
  if [ "$UID" -eq 0 -a -f /etc/os-release -a -f /etc/zsh/zshrc ]; then
    if grep -i -c Ubuntu /etc/os-release >dev/null 2>&1; then
      if [ -f /etc/zsh/zshrc ]; then
        if ! grep '. /etc/profile' /etc/zsh/zshrc >/dev/null 2>&1; then
            echo '. /etc/profile' >> /etc/zsh/zshrc
        fi
      fi
    fi
  fi

  success "\t DONE.\n"
}

install
