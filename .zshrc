export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="fwalch" # fwalch, bureau, kardan, minimal, sammy

unsetopt autocd
setopt inc_append_history_time
setopt dot_glob
setopt extended_glob

source $ZSH/oh-my-zsh.sh

source ~/.dotfiles/.zshprivate
