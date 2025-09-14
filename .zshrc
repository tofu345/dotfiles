export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="fwalch" # fwalch, bureau, kardan, minimal, sammy

unsetopt autocd
setopt inc_append_history_time

source $ZSH/oh-my-zsh.sh

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(starship init zsh)"
source <(fzf --zsh)

source ~/.dotfiles/.zshprivate
