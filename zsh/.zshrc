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
FZF_TAB_COMMAND=(
    fzf
    --ansi   # Enable ANSI color support, necessary for showing groups
    --expect='$continuous_trigger,$print_query' # For continuous completion and print query
    '--color=hl:$(( $#headers == 0 ? 40 : 255 )),hl+:41'
    --nth=2,3 --delimiter='\x00'  # Don't search prefix
    --layout=reverse --height='${FZF_TMUX_HEIGHT:=35%}'
    --tiebreak=begin -m --bind=tab:down,btab:up,change:top,ctrl-space:toggle --cycle
    '--query=$query'   # $query will be expanded to query string at runtime.
    '--header-lines=$#headers' # $#headers will be expanded to lines of headers at runtime
    --print-query
)
zstyle ':fzf-tab:*' command $FZF_TAB_COMMAND
zstyle ':completion:complete:git-checkout:argument-rest' sort false
local extract="
# trim input
local in=\${\${\"\$(<{f})\"%\$'\0'*}#*\$'\0'}
# get ctxt for current completion
local -A ctxt=(\"\${(@ps:\2:)CTXT}\")
# real path
local realpath=\${ctxt[IPREFIX]}\${ctxt[hpre]}\$in
realpath=\${(Qe)~realpath}
"
zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap

# Fish-like autosuggestions
zinit light zsh-users/zsh-autosuggestions

# syntax highlighting
zinit light zdharma/fast-syntax-highlighting

# Ctrl-R fuzzy completion
if (( $+commands[fzf] )); then
  zinit light zdharma/history-search-multi-word
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
export PATH=$PATH:~/.local/bin:~/.dotfiles/emacs/.emacs.d-doom-emacs/bin

# local zshrc
[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local
