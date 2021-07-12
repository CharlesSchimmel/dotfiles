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
set -o ignoreeof # Do not exit shell when <C-d> pressed

# source $HOME/.zsh/zsh-git-prompt/zshrc.sh # for git prompt
autoload -Uz promptinit && promptinit
PROMPT='%F{blue}%%%f '
# RPROMPT='%~$(git_super_status)'
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

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/schimmch/.local/bin:/home/schimmch/.npm-global/bin/:/home/schimmch/.local/bin:/home/schimmch/.npm-global/bin/:/home/schimmch/.nvm/versions/node/v12.22.3/bin/"
export EDITOR='nvim'
source "$HOME/.aliases"
source "$HOME/.projects.sh"

eval $(dircolors -b $HOME/.ls_colors/LS_COLORS)
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -z "$TMUX" ]; then
    tmux -2 attach || exec tmux -2 new-session
fi
cd $HOME
