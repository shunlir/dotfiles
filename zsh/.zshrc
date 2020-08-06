# -*- mode: shell-script -*-
# vim:ft=zsh

# self install
if [ ! -e ~/.zinit ]; then
    mkdir ~/.zinit
    git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi

# load Zinit
source ~/.zinit/bin/zinit.zsh
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
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting

# Ctrl-R
zinit light zdharma/history-search-multi-word
zstyle ":history-search-multi-word" page-size "8"
zstyle ":history-search-multi-word" highlight-color "fg=48,bold" # SpringGreen

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
alias ls='ls --color=auto'
alias la='ls --color=auto -A'
alias grep='grep --color=auto'

#
export PATH=$PATH:~/.dotfiles/emacs/.emacs.d-doom-emacs/bin

# local zshrc
[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local
