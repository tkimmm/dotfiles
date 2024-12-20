if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
 source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git fzf-tab fzf vi-mode zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
source /opt/homebrew/Cellar/fzf/0.55.0/shell/key-bindings.zsh

fpath+=${ZDOTDIR:-~}/.zsh_functions

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Kubernetes
source <(kubectl completion zsh)

# Misc bindings
alias mindarc='/Users/teekm/Sync/mindarc-cli/target/release/mindarc'
alias ma='/Users/teekm/Sync/go/mindarc-aws/mindarcaws-darwin'
alias ks=k9s
alias k=kubectl
alias q=exit
alias v='nvim'
alias c='clear'
alias gg='lazygit'
alias n='cd /Users/teekm/Sync/vim/ && nvim'
alias gitp="git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d"
alias m="cd /Users/teekm/Sync/Dev/Python/modelemp && python3 app.py"
alias mm='curl -L "https://slack.tkim.io/slack/toggle?id=AlsIchInAsicsWar727"'
alias tf="terraform"
alias syncoff="brew services stop syncthing"
alias syncon="brew services start syncthing"
alias or='git remote -v | grep origin | grep -o "github.com[:/][^ ]*" | sed "s/.*github.com[\/\:]//" | xargs -I {} open https://github.com/{} > /dev/null 2>&1 &'
alias sfm='echo "Enter user@server: " && read server && echo "Enter remote mount point: " && read remote_path && sshfs -o reconnect -o ServerAliveInterval=15 -o ServerAliveCountMax=3 "$server":"$remote_path" ~/mountpoint'
alias sfu='umount -f ~/mountpoint'

# ignore Control-D behaviour
set -o ignoreeof

# Paths
export AZURE_CONFIG_DIR=$HOME/.azure
export AZURE_DEV_COLLECT_TELEMETRY="no"

clear-git-branches() {
  git fetch -p && \
  for branch in $(git branch -vv | awk '/: gone]/{print $1}');
    do git branch -D "${branch}";
  done
}

### Activate vi / vim mode:
bindkey -v

# Remove delay when entering normal mode (vi)
KEYTIMEOUT=5

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ $KEYMAP == main ]] || [[ $KEYMAP == viins ]] || [[ $KEYMAP = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

zle -N zle-keymap-select
# Start with beam shape cursor on zsh startup and after every command.
zle-line-init() { zle-keymap-select 'beam'}

# Auto completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
  autoload -Uz compinit
  compinit
fi

# fzf search
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
  export FZF_DEFAULT_OPTS='-m --height 70% --reverse' 
fi

f() {
  local dir
  DIR=$(find ~/Sync -maxdepth 8 -type d \( -name .git -o -name node_modules -o -name release -o -name QubozDownloader \) -prune -o -type d -print 2> /dev/null | fzf-tmux) \
    && cd "$DIR"
}

fu() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
  cd "$DIR"
}

dd() {
	sudo systemctl disable docker.service docker.socket
}

du() {
	sudo systemctl enable docker.service docker.socket
}

gas() {
  echo "AWS Secret Name:"
  read secret
  aws secretsmanager get-secret-value --secret-id ${secret} | jq -r '.SecretString' | jq .
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh) 

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH=$PATH:/usr/local/go/bin
export PATH="/usr/local/opt/llvm/bin:$PATH"

# pnpm
export PNPM_HOME="/home/teekm/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

eval $(thefuck --alias)
eval $(thefuck --alias FUCK)

eval "$(zoxide init zsh)"
alias cd=z
