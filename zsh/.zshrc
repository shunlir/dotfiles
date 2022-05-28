# -*- mode: shell-script -*-
# vim:ft=zsh

# self install
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -e "$(dirname $ZINIT_HOME)" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# load Zinit
source "${ZINIT_HOME}/zinit.zsh"
unset ZINIT_HOME

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# some useful functions/settings from oh-my-zsh
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/theme-and-appearance.zsh

# git alias
zinit snippet OMZ::plugins/git/git.plugin.zsh

# vi mode line editing
zinit snippet OMZ::plugins/vi-mode/vi-mode.plugin.zsh
setopt promptsubst
bindkey '^[[3~' delete-char

# man pages syntax
#zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
if [[ "$(command -v bat)" ]]; then
  export MANPAGER="sh -c 'col -bx | bat --theme=OneHalfDark -l man -p'"
fi

if [[ "$(command -v nvim)" ]]; then
  export EDITOR='nvim'
fi

#
# tab fuzzy completion
#
zinit light Aloxaf/fzf-tab
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':completion:complete:git-checkout:argument-rest' sort false
#zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'

# Fish-like autosuggestions
zinit light zsh-users/zsh-autosuggestions

# syntax highlighting
zinit light zdharma-continuum/fast-syntax-highlighting

# Ctrl-R fuzzy completion
if (( $+commands[fzf] )); then
  zinit light zdharma-continuum/history-search-multi-word
  zstyle ":history-search-multi-word" page-size "8"
  zstyle ":history-search-multi-word" highlight-color "fg=48,bold" # SpringGreen
fi

# prompt theme
zinit snippet https://raw.githubusercontent.com/shunlir/oh-my-zsh-custom/master/themes/clean.zsh-theme

# Z auto jump
if (( $+commands[lua] )); then
  _ZL_MATCH_MODE=1
  _ZL_ADD_ONCE=1
  zinit light skywind3000/z.lua
fi

# compinit after all loading all plugins
autoload -Uz compinit
compinit
zinit cdreplay -q

# p <project>
if [ -e ~/repo ]; then
    _p () {
        local commands
        commands=(`ls ~/repo`)
        _describe -t commands 'command' commands
    }
    function p () {
        cd ~/repo/$1
    }
    compdef _p p
fi

# aliases
if [ "$(uname)" = "Linux" ]; then
  alias ls='ls --color=auto'
  alias la='ls --color=auto -A'
elif [ "$(uname)" = "Linux" ]; then
  alias ls='ls -G'
fi
alias grep='grep --color=auto'
alias gg='git status'
type nvim 2>&1 >/dev/null && alias vim='nvim'
alias weather='clear && curl wttr.in'

#
export PATH=$PATH:~/.local/bin:~/.config/doomemacs/bin

# local zshrc
[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local
