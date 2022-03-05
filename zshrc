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

export GIT_PROMPT_EXECUTABLE="haskell"
source $HOME/.zsh/zsh-git-prompt/zshrc.sh
autoload -Uz promptinit && promptinit
PROMPT='%F{cyan}%%%f '
RPROMPT='%~$(git_super_status)'

autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '\eOc' forward-word # <C-{left,right}>
bindkey '\eOd' backward-word
bindkey '[A' up-line-or-beginning-search # up and down - for completing past commands
bindkey '[B' down-line-or-beginning-search
bindkey '[7~' beginning-of-line # Home, End
bindkey '[8~' end-of-line
bindkey '^[[Z' reverse-menu-complete # '^[[Z' <S-TAB> for reversing tab completions
set -o ignoreeof

# ???
# function precmd () {
#   window_title="\033]0;${PWD##*/}\007"
#   echo -ne "$window_title"
# }

export PATH=$PATH":$HOME/.local/bin:$HOME/.npm-global/bin"
export EDITOR='nvim'
export GPODDER_HOME="/mnt/nas/Podcasts/"
source $HOME/.aliases
source $HOME/.ghcup/env
source /usr/share/zsh/plugins/clipboard.zsh 
source "$HOME/.local/share/lscolors.sh"
# if [ -e /home/elpfen/.nix-profile/etc/profile.d/nix.sh ]; then . /home/elpfen/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # Must remain at bottom - fish style syntax highlighting
source /usr/share/nvm/init-nvm.sh
