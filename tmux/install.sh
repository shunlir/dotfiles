# tmux

info "Configuring tmux...\n"
if [ ! -e ~/.tmux.conf ]; then
    ln -s $DOT_ROOT/tmux/tmux.conf ~/.tmux.conf
fi
success "\t DONE.\n"
