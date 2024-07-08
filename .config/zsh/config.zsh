export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

export ZSH_AI_COMMANDS_OPENAI_API_KEY=$OPENAI_API_KEY
export ZSH_ASK_API_KEY=$OPENAI_API_KEY

# export MPLBACKEND=module://matplotlib-backend-wezterm
export MPLBACKEND=module://itermplot
export MPLBACKEND_TRANSPARENT=1
export ITERM_LINES=20


PLUGIN_PATH=$HOME/.config/zsh/plugins

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

alias vi="nvim"
alias ll="k -h"
alias c="clear"

# . "$HOME/.atuin/bin/env"
export PATH=/opt/nvim-linux64/bin:~/.local/bin:$PATH

eval "$(zoxide init zsh --cmd cd)"
eval "$(atuin init zsh --disable-up-arrow)"

source $PLUGIN_PATH/powerlevel10k/powerlevel10k.zsh-theme
source $PLUGIN_PATH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $PLUGIN_PATH/zsh-ask/zsh-ask.zsh
source $PLUGIN_PATH/zsh-ai-commands/zsh-ai-commands.zsh
source $PLUGIN_PATH/k/k.sh


conda activate tf

[[ ! -f $HOME/.config/zsh/.p10k.zsh ]] || source $HOME/.config/zsh/.p10k.zsh


# add a function to ssh and attach to tmux if it exists, or start a session if it doesn't
function tsh {
  ssh $1 -t "tmux -CC new-session -A -s main"
}

