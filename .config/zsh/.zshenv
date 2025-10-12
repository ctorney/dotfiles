
export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

export XDG_CONFIG_HOME=$HOME/.config

export ZSH_AI_COMMANDS_OPENAI_API_KEY=$OPENAI_API_KEY
export ZSH_ASK_API_KEY=$OPENAI_API_KEY

export MPLBACKEND=module://matplotlib-backend-terminal
export MPLBACKEND_TRANSPARENT=1
export MPLBACKEND_CHAFA_OPTS="-f kitty --passthrough tmux"

export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

export PATH=/opt/nvim-linux64/bin:~/.local/bin:~/.local/go/bin:/opt/.fzf/bin:$PATH
