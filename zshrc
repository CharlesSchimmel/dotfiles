source "$HOME/.zshrc-common"

PROMPT='%F{cyan}%n@%m%%%f '

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

