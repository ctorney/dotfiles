export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

export ZSH_AI_COMMANDS_OPENAI_API_KEY=$OPENAI_API_KEY
export ZSH_ASK_API_KEY=$OPENAI_API_KEY

PLUGIN_PATH=$HOME/.config/zsh/plugins

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

alias vi="nvim"
alias ll="ls -l --color=auto"
alias c="clear"


# PROMPT='$ %f'
# case $TERM in 
#     xterm*|termite|alacritty|foot)
#       if [[ $HOST == MACLAP* ]]; then
#         precmd () { print -Pn "\e]0;ctorney@macbook: %~\a" }
#       else
#         precmd () { print -Pn "\e]0;ctorney@%m: %~\a" }
#       fi
#         ;;
# esac


      

eval "$(zoxide init zsh --cmd cd)"
eval "$(atuin init zsh --disable-up-arrow)"


# fpath+=$PLUGIN_PATH/pure
# autoload -U promptinit; promptinit
# prompt pure

source $PLUGIN_PATH/powerlevel10k/powerlevel10k.zsh-theme
source $PLUGIN_PATH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $PLUGIN_PATH/zsh-ask/zsh-ask.zsh
source $PLUGIN_PATH/zsh-ai-commands/zsh-ai-commands.zsh
source $PLUGIN_PATH/zsh-window-title/zsh-window-title.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

conda activate tf

bindkey -v
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.config/zsh/.p10k.zsh ]] || source $HOME/.config/zsh/.p10k.zsh
