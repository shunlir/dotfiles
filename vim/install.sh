# vim

install()
{
  # vim
  if ! command -v vim >/dev/null 2>&1; then
    warn "Vim is not installed! Please install vim first!\n"
    return 1
  fi

  info "Configuring vim...\n"

  if [ -f /etc/vimrc ]; then
    VIMRC=/etc/vimrc
  else
    VIMRC=/etc/vim/vimrc
  fi

  if [ -f "$VIMRC" ]; then
    if [ "$UID" -eq 0 -a  -f $VIMRC ]; then
      sed -i '/seg_vimrc-begin/,/seg_vimrc-end/d' ~/.zshrc
      cat $DOT_ROOT/vim/seg_sys_vimrc >> $VIMRC
    fi
  fi

  if [ ! -e ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    rm -fv ~/.vimrc
    ln -s $DOT_ROOT/vim/vimrc ~/.vimrc
    vim +'PlugInstall --sync' +qa
  fi

  success "\t DONE.\n"

  # neovim
  if command -v nvim >/dev/null 2>&1; then
    info "Configuring nvim...\n"
    [ ! -e ~/.config/nvim/ ] && mkdir -p ~/.config/nvim/
    if [ ! -e ~/.config/nvim/init.vim ]; then
cat << EOF >~/.config/nvim/init.vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
EOF
    fi
    success "\t DONE.\n"
  fi

}

install
