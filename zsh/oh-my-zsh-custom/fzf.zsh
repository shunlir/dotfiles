#
# FZF
#
export PATH=$PATH:~/.cargo/bin/

setopt HIST_IGNORE_ALL_DUPS
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  # Use fd (https://github.com/sharkdp/fd) instead of the default find
  # command for listing path candidates.
  # - The first argument to the function ($1) is the base path to start traversal
  # - See the source code (completion.{bash,zsh}) for the details.
  _fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
  }
  # Use fd to generate the list for directory completion
  _fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
  }
fi

if command -v fzf >/dev/null 2>&1 && command -v fd >/dev/null 2>&1; then
  ctrlp() { </dev/tty vim $(fzf) }
  zle -N ctrlp                                                                   
  bindkey "^p" ctrlp            
fi
