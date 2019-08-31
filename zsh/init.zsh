# -*- mode: shell-script -*-
# vim:ft=zsh

# load ZPlug
source '/home/shunlir/.zplugin/bin/zplugin.zsh'
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

zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/fast-syntax-highlighting
zplugin light zdharma/history-search-multi-word

# prompt theme
zplugin snippet https://raw.githubusercontent.com/shunlir/oh-my-zsh-custom/master/themes/clean.zsh-theme

