# p10k zsh
# Path to your oh-my-zsh installation.
# ZSH_THEME="powerlevel10k/powerlevel10k"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export EDITOR="nvim"
export VISUAL="nvim"

# zsh plugins
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
plugins=(git fzf-tab fzf vi-mode zsh-autosuggestions)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
# fzf ctrl-r search & auto complete
source $(brew --prefix)/Cellar/fzf/$(fzf --version | cut -d ' ' -f 1)/shell/key-bindings.zsh
source $(brew --prefix)/Cellar/fzf/$(fzf --version | cut -d ' ' -f 1)/shell/completion.zsh

# brew
version=$(echo /opt/homebrew/Cellar/fzf/* | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
source /opt/homebrew/Cellar/fzf/${version}/shell/key-bindings.zsh

fpath+=${ZDOTDIR:-~}/.zsh_functions

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh) 

# Kubernetes
source <(kubectl completion zsh)

# Misc bindings
# wget -qO- https://raw.githubusercontent.com/tkimmm/dotfiles/refs/heads/main/servers/install.sh | sh
alias mindarc='/Users/teekm/Sync/mindarc-cli/target/release/mindarc'
alias ma='/Users/teekm/Sync/go/mindarc-aws/mindarcaws-darwin'
alias ks=k9s
alias g1='/Users/teekm/.config/aerospace/gap.sh'
alias k=kubectl
alias q=exit
alias v='nvim'
alias c='clear'
alias gi='lazygit'
alias n='cd /Users/teekm/Dev/2025/vim && nvim'
alias gitp="git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d"
alias m="cd /Users/teekm/DevSync/Dev/Python/modelemp && python3 app.py"
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

# fzf search helper
f() {
  local dir
  DIR=$(find ~/Dev -maxdepth 8 -type d \( -name .git -o -name node_modules -o -name release -o -name QubozDownloader \) -prune -o -type d -print 2> /dev/null | fzf-tmux) \
    && cd "$DIR"
}

gas() {
  echo "AWS Secret Name:"
  read secret
  aws secretsmanager get-secret-value --secret-id ${secret} | jq -r '.SecretString' | jq .
}

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

# go
export GOBIN=$GOPATH/bin
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# wtf
eval $(thefuck --alias)
eval $(thefuck --alias FUCK)

# starship
export STARSHIP_CONFIG=~/dotfiles/clients/macbook-applesilicon/starship.toml
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"
alias cd=z

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
