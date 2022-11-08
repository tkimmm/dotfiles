autoload -Uz compinit
compinit

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="/Users/tkim/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git kubectl fzf-tab zsh-autosuggestions vi-mode)

source $ZSH/oh-my-zsh.sh 

# Doesn't exist on x86 mac
# eval $(/opt/homebrew/bin/brew shellenv)
#
# Ignore Control-D Behaviour
set -o ignoreeof

# NVM
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh  # This loads NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
# FLUTTER
# export PATH="$PATH:/Users/tkim/Dev/Flutter/bin"
# export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
# export PATH="${HOME}/Library/Android/sdk/tools:${HOME}/Library/Android/sdk/platform-tools:${PATH}"
# PATH=$HOME/flutter/bin:$PATH

# PYENV
alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# RUST
export PATH="$HOME/.cargo/bin:$PATH"
alias get_idf='. $HOME/esp/esp-idf/export.sh'
export PATH="/Users/tkim/.espressif/tools/xtensa-esp32-elf-clang/esp-12.0.1-20210914-aarch64-apple-darwin/bin/:$PATH"
export LIBCLANG_PATH="/Users/tkim/.espressif/tools/xtensa-esp32-elf-clang/esp-12.0.1-20210914-aarch64-apple-darwin/lib/"
export PIP_USER=no

# Kubernetes
alias kx='kubectx'
alias k=kubectl
alias c='clear'
alias kwp='kubectl get pods -A --watch'
alias kwd='kubectl get deployments -A --watch'
alias kwe='kubectl get events -A --watch'
alias kwj='kubectl get jobs -A --watch'
alias q=exit
alias v=nvim

# Misc bindings
alias b="/Users/tkim/dev/Rust/calc/target/release/calc"
alias gitp="git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d"
alias m="cd /Users/tkim/Sync/Dev/Python/modelemp/&& python app.py"
alias tf="terraform"

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
  DIR=`find * -maxdepth 10 -type d -print 2> /dev/null | fzf-tmux` \
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
