# GIT

install()
{
  if ! command -v git >/dev/null 2>&1; then
      warn "git is not installed!\n"
      return 1
  fi

  info "Configuring git...\n"

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

  success "\t DONE.\n"
}

install
