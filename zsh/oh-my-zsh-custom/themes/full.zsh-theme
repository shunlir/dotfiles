local ret_status="%(?,,rc:%F{red}%?%{$reset_color%})"
local git_info='$(git_prompt_info)'

PROMPT="
%F{blue}#%{$reset_color%} \
%(#,%F{red}%n%{$reset_color%},%F{cyan}%n%{$reset_color%})\
@\
%F{cyan}%m \
%F{8}%~%{$reset_color%}\
${git_info}\
 \
$ret_status
%F{red}$ %{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%} git:%F{cyan}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}*"
ZSH_THEME_GIT_PROMPT_CLEAN=""
