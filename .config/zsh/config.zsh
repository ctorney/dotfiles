
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
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY

export PATH=/opt/nvim-linux64/bin:~/.local/bin:~/.local/go/bin:/opt/.fzf/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -z "$TMUX" ] && command -v tmux >/dev/null 2>&1; then
  # Check if session 'TMUX' exists and is attached
  if ! tmux list-sessions 2>/dev/null | grep '^TMUX:' | grep -q '(attached)'; then
    exec tmux new-session -A -s TMUX
  fi
fi

# __conda_setup="$('$CONDA_HOME/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "$CONDA_HOME/etc/profile.d/conda.sh" ]; then
#         . "$CONDA_HOME/etc/profile.d/conda.sh"
#     else
#         export PATH="$CONDA_HOME/bin:$PATH"
#     fi
# fi
# unset __conda_setup

# if [ -n "$TMUX" ]; then
#     precmd() {
#         if [ -n "$CONDA_DEFAULT_ENV" ]; then
#             tmux set-environment CONDA_DEFAULT_ENV "$CONDA_DEFAULT_ENV"
#         fi
#       }
# fi
   
# conda activate tf

export EDITOR=nvim

# # # Check if we're not already in a shpool session and shpool is installed
# if [ -z "$SHPOOL_SESSION_NAME" ] && command -v shpool >/dev/null 2>&1; then
#    # Launch shpool and attach to the "main" session
#    exec shpool attach main
# fi

PLUGIN_PATH=$HOME/.config/zsh/plugins

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# alias vi="nvim"

if command -v eza >/dev/null 2>&1; then
    alias ll='eza --icons=always -l -snew'
    alias ls="eza --icons=always"
else
    alias ll='ls -l --color=always -rt'
fi


if command fdfind >/dev/null 2>&1; then
    alias fd='fdfind'
fi

alias c="clear"
# alias nvim='nvim --listen /tmp/nvim'
alias vi='nvim'
alias nvimage='function _nvimage() { echo "![terminalimage]($(realpath "$1"))\n"; }; _nvimage'

# eval "$(/usr/libexec/path_helper)"    

if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
fi



eval "$(zoxide init zsh --cmd cd)"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=245"
source $PLUGIN_PATH/powerlevel10k/powerlevel10k.zsh-theme
source $PLUGIN_PATH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $PLUGIN_PATH/zsh-ask/zsh-ask.zsh
source $PLUGIN_PATH/zsh-ai-commands/zsh-ai-commands.zsh
# source $PLUGIN_PATH/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $PLUGIN_PATH/zsh-autosuggestions/zsh-autosuggestions.zsh
autoload -U compinit; compinit
source $PLUGIN_PATH/fzf-tab/fzf-tab.plugin.zsh
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags   --color=bg+:#A7C080,fg+:#1e2326,gutter:-1,pointer:#A7C080,hl+:#1e2326


source <(fzf --zsh)


# export FZF_DEFAULT_OPTS="--preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} --style=header,grid || cat {}) 2> /dev/null | head -300' --preview-window=right:50%:wrap --bind '?:toggle-preview' --bind 'ctrl-y:become([[ -f {} && -r {} ]] && nvim {} || echo \"Not a readable text file\")' --header ''"

# Exclude those directories even if not listed in .gitignore, or if .gitignore is missing
FD_OPTIONS="--follow --exclude .git --exclude node_modules"

# Use 'git ls-files' when inside GIT repo, or fd otherwise
# Use fd if available, otherwise fallback to fdfind
if command -v fd >/dev/null 2>&1; then
    FD_COMMAND="fd"
else
    FD_COMMAND="fdfind"
fi

export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | $FD_COMMAND --type f --type l $FD_OPTIONS"

# Find commands for "Ctrl+T" and "Opt+C" shortcuts
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"
export FZF_CTRL_R_OPTS="
  --preview-window='right:wrap:hidden'
  --color header:italic
  --header ''"

export FZF_ALT_C_OPTS="
  --preview='ls -la --color=always {} | head -200'
  --preview-window='right:wrap'
  --color header:italic
  --header ''"


[[ ! -f $HOME/.config/zsh/.p10k.zsh ]] || source $HOME/.config/zsh/.p10k.zsh

bindkey "^[[H"   beginning-of-line
bindkey "^[[F"   end-of-line
bindkey "^[[1;5C" forward-word


