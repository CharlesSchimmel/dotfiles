# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _approximate 
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit && compinit
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000
setopt appendhistory autocd extendedglob nomatch notify share_history
bindkey -v

autoload -Uz promptinit && promptinit
PROMPT='%F{cyan}%%%f '
RPROMPT='%~'

autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '\eOc' forward-word # <C-{left,right}>
bindkey '\eOd' backward-word
bindkey 'OA' up-line-or-beginning-search # up and down - for completing past commands
bindkey '[A' up-line-or-beginning-search # up and down - for completing past commands
bindkey 'OB' down-line-or-beginning-search
bindkey '[7~' beginning-of-line # Home, End
bindkey '[8~' end-of-line
bindkey '^[[Z' reverse-menu-complete # '^[[Z' <S-TAB> for reversing tab completions
bindkey '' history-incremental-pattern-search-backward
set -o ignoreeof

setopt HIST_IGNORE_SPACE

export PATH=$PATH":$HOME/.local/bin"
export EDITOR='nvim'
source $HOME/.aliases
source "$HOME/.local/share/lscolors.sh"
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # Must remain at bottom - fish style syntax highlighting

# fnm
FNM_PATH="/home/smitty/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
