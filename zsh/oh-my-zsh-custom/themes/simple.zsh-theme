local ret_status="%(?,,rc:%F{red}%?%{$reset_color%} )"
local git_info='$(git_prompt_info)'

PROMPT="
%(#,%F{red},%F{cyan})%n%{$reset_color%}@%F{cyan}%m \
%F{8}%c%{$reset_color%}\
${git_info}\
 \
$ret_status\
%F{red}$ %{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%} %F{cyan}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}*"
ZSH_THEME_GIT_PROMPT_CLEAN=""
