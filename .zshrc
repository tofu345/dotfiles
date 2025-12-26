export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="fwalch" # fwalch, bureau, kardan, minimal, sammy

source $ZSH/oh-my-zsh.sh

unsetopt autocd
setopt inc_append_history_time
setopt dot_glob
setopt extended_glob

source ~/dotfiles/.zshprivate
