# ls colors

info "Configuring ls colors...\n"
if [ ! -f ~/.dircolors ]; then
    ln -s $DOT_ROOT/dircolors/solarized-256dark ~/.dircolors
fi
success "\t DONE.\n"
