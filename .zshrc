export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="eastwood"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="%b %d %H:%M:%S" # show command execution time stamp shown in the history command output
HISTSIZE=1000000 # the number of items for the internal history list
SAVEHIST=1000000 # maximum number of items for the history file
PS2="" # prompt on multiline commands

plugins=(
    git
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# * User configuration

bindkey \^U backward-kill-line

setopt HIST_IGNORE_ALL_DUPS # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS    # do not save duplicated command
setopt HIST_REDUCE_BLANKS   # remove unnecessary blanks
setopt EXTENDED_HISTORY	    # record command start time
unsetopt autocd

# globbing see: l *(<Tab>
setopt dot_glob
setopt extended_glob

# https://superuser.com/a/1563859
unalias run-help
autoload run-help
HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
alias help=run-help

alias l="eza -laa -g --icons=auto --group-directories-first";
alias v="nvim"
alias tma="tmux attach"
alias hist="history -dD"
alias mv="mv -i"
alias cp="cp -i"

export LANG=en_US.UTF-8
export TERMINAL='alacritty'
export MANPAGER='nvim +Man!'
export EDITOR='nvim'
export VISUAL='nvim'
export BAT_STYLE="-grid"
export PISTOL_CHROMA_STYLE='vim'
export PISTOL_CHROMA_FORMATTER='terminal256'

PATH="$PATH:$HOME/.local/bin"
export GOPATH=$HOME/go
PATH="$PATH:$GOPATH/bin"
PATH="$PATH:$HOME/.npm-global/bin"
export PATH

source <(fzf --zsh)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
