export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

export XDG_CONFIG_HOME=$HOME/.config

export ZSH_AI_COMMANDS_OPENAI_API_KEY=$OPENAI_API_KEY
export ZSH_ASK_API_KEY=$OPENAI_API_KEY

export MPLBACKEND_TRANSPARENT=1
export MPLBACKEND_CHAFA_OPTS="-f kitty --passthrough tmux"

export HISTSIZE=100000
export SAVEHIST=100000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY

conda activate tf
export EDITOR=nvim

# if [ -z "$TMUX" ]; then
#   exec tmux new-session -A -s TMUX
# fi

PLUGIN_PATH=$HOME/.config/zsh/plugins

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# alias vi="nvim"
alias ll="eza -l --icons=always"
alias ls="eza --icons=always"
alias c="clear"
# alias imgcat="wezterm imgcat"
alias vi='nvim'

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
# source $PLUGIN_PATH/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $PLUGIN_PATH/zsh-autosuggestions/zsh-autosuggestions.zsh
autoload -U compinit; compinit
source $PLUGIN_PATH/fzf-tab/fzf-tab.plugin.zsh
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags   --color=bg+:#A7C080,fg+:#1e2326,gutter:-1,pointer:#A7C080,hl+:#1e2326

# bindkey '^I' expand-or-complete
# bindkey '^I' fzf-tab-complete
# bindkey              '^I' menu-select
# bindkey "$terminfo[kcbt]" menu-select
# bindkey -M menuselect              '^I'         menu-complete
# bindkey -M menuselect "$terminfo[kcbt]" reverse-menu-complete
# zstyle ':autocomplete:*' add-space 
# zstyle ':completion:*:*' matcher-list 'm:{[:lower:]-}={[:upper:]_}' '+r:|[.]=**'
# bindkey -M menuselect '^M' .accept-line
# bindkey '^I^I' autosuggest-accept
# # all Tab widgets
# zstyle ':autocomplete:*complete*:*' insert-ambiguous no
# # all history widgets
# zstyle ':autocomplete:*history*:*' insert-unambiguous yes
# # ^S
# zstyle ':autocomplete:menu-search:*' insert-unambiguous yes
# bindkey '^R' .history-incremental-search-backward
# bindkey '^S' .history-incremental-search-forward
# () {
#    local -a prefix=( '\e'{\[,O} )
#    local -a up=( ${^prefix}A ) down=( ${^prefix}B )
#    local key=
#    for key in $up[@]; do
#       bindkey "$key" up-line-or-history
#    done
#    for key in $down[@]; do
#       bindkey "$key" down-line-or-history
#    done
# }

source <(fzf --zsh)


export FZF_DEFAULT_OPTS="--preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} --style=header,grid || cat {}) 2> /dev/null | head -300' --preview-window=right:50%:wrap --bind '?:toggle-preview' --bind 'ctrl-y:become([[ -f {} && -r {} ]] && nvim {} || echo \"Not a readable text file\")'
--header ''"

# Exclude those directories even if not listed in .gitignore, or if .gitignore is missing
FD_OPTIONS="--follow --exclude .git --exclude node_modules"

# Use 'git ls-files' when inside GIT repo, or fd otherwise
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS"

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

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
