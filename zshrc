# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _approximate 
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit && compinit
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory autocd extendedglob nomatch notify share_history
bindkey -v

autoload -Uz promptinit && promptinit
PROMPT='%F{blue}%%%f '
RPROMPT='%~'

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '\eOc' forward-word # <C-{left,right}>
bindkey '\eOd' backward-word
bindkey 'OA' up-line-or-beginning-search # up and down - for completing past commands
bindkey 'OB' down-line-or-beginning-search
bindkey '[7~' beginning-of-line # Home, End
bindkey '[8~' end-of-line
bindkey '^[[Z' reverse-menu-complete # '^[[Z' <S-TAB> for reversing tab completions

export PATH=$PATH":$HOME/.local/bin"
export EDITOR='nvim'
source "$HOME/.aliases"
