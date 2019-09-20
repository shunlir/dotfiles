# Prompt
local ret_status="%(?,,rc:%{$fg[red]%}%?%{$reset_color%})"
local git_info='$(git_prompt_info)'
PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%(#,%{$fg[red]%}%n%{$reset_color%},%{$fg[cyan]%}%n)\
@\
%m \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}\
${git_info}\
 \
$ret_status
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[white]%}on%{$reset_color%} git:%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*"
ZSH_THEME_GIT_PROMPT_CLEAN=""
