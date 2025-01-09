export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

export XDG_CONFIG_HOME=$HOME/.config

export ZSH_AI_COMMANDS_OPENAI_API_KEY=$OPENAI_API_KEY
export ZSH_ASK_API_KEY=$OPENAI_API_KEY

export MPLBACKEND=module://matplotlib-backend-terminal
export MPLBACKEND_TRANSPARENT=1
export MPLBACKEND_CHAFA_OPTS="-f kitty --passthrough tmux"

if [ -n "$SSH" ]; then
  /usr/bin/ssh $SSH || printf "SSH connection failed\n"
fi

if [ -z "$TMUX" ]; then
  tmux new-session -A -s TMUX
fi

PLUGIN_PATH=$HOME/.config/zsh/plugins

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

alias vi="nvim"
alias ll="k -h --no-vcs"
alias c="clear"
alias imgcat="wezterm imgcat"

# eval "$(/usr/libexec/path_helper)"    

if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi


export PATH=/opt/nvim-linux64/bin:~/.local/bin:~/.local/go/bin:$PATH

eval "$(zoxide init zsh --cmd cd)"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=245"
source $PLUGIN_PATH/powerlevel10k/powerlevel10k.zsh-theme
source $PLUGIN_PATH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $PLUGIN_PATH/zsh-ask/zsh-ask.zsh
source $PLUGIN_PATH/zsh-ai-commands/zsh-ai-commands.zsh
source $PLUGIN_PATH/k/k.sh
source $PLUGIN_PATH/zsh-autosuggestions/zsh-autosuggestions.zsh
source <(fzf --zsh)


export FZF_DEFAULT_OPTS="--preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} --style=header,grid || cat {}) 2> /dev/null | head -300' --preview-window=right:50%:wrap --bind '?:toggle-preview' --bind 'ctrl-y:become([[ -f {} && -r {} ]] && nvim {} || echo \"Not a readable text file\")'
--header 'Press CTRL-Y to edit the file'"

# Exclude those directories even if not listed in .gitignore, or if .gitignore is missing
FD_OPTIONS="--follow --exclude .git --exclude node_modules"

# Change behavior of fzf dialogue
# export FZF_DEFAULT_OPTS="--multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)' --bind 'enter:become(nvim {})'"

# Change find backend
# Use 'git ls-files' when inside GIT repo, or fd otherwise
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS"

# Find commands for "Ctrl+T" and "Opt+C" shortcuts
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview-window='right:wrap:hidden'
  --color header:italic
  --header ''"


export FZF_ALT_C_OPTS="
  --preview='ls -la --color=always {} | head -200'
  --preview-window='right:wrap'
  --color header:italic
  --header ''"

conda activate tf

[[ ! -f $HOME/.config/zsh/.p10k.zsh ]] || source $HOME/.config/zsh/.p10k.zsh


bindkey "^[[H"   beginning-of-line
bindkey "^[[F"   end-of-line
bindkey "^[[1;5C" forward-word

