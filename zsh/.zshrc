# -*- mode: shell-script -*-
# vim:ft=zsh

# self install
if [ ! -e ~/.zplugin ]; then
    mkdir ~/.zplugin
    git clone https://github.com/zdharma/zplugin.git ~/.zplugin/bin
fi

# load ZPlug
source ~/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

# some useful functions/settings from oh-my-zsh
zplugin snippet OMZ::lib/completion.zsh
zplugin snippet OMZ::lib/git.zsh
zplugin snippet OMZ::lib/history.zsh
zplugin snippet OMZ::lib/theme-and-appearance.zsh

# git alias
zplugin snippet OMZ::plugins/git/git.plugin.zsh

# vi mode line editing
zplugin snippet OMZ::plugins/vi-mode/vi-mode.plugin.zsh
setopt promptsubst
bindkey '^[[3~' delete-char

# man pages syntax
zplugin snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/fast-syntax-highlighting

# Ctrl-R
zplugin light zdharma/history-search-multi-word
zstyle ":history-search-multi-word" page-size "8"
zstyle ":history-search-multi-word" highlight-color "fg=48,bold" # SpringGreen

# prompt theme
zplugin snippet https://raw.githubusercontent.com/shunlir/oh-my-zsh-custom/master/themes/clean.zsh-theme

# Z auto jump
if (( $+commands[lua] )) && (( $+commands[svn] )); then
  _ZL_MATCH_MODE=1
  _ZL_ADD_ONCE=1
  zplugin ice svn; zplugin snippet https://github.com/skywind3000/z.lua/trunk
fi

# compinit after all loading all plugins
autoload -Uz compinit
compinit
zplugin cdreplay -q

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

# local zshrc
[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local
