#----------#
# bindings #
#----------#

bindkey -e
bindkey \^U backward-kill-line
bindkey '^[[Z' reverse-menu-complete
bindkey '\e[3~' delete-char # 'Delete' key
bindkey '^\' redo # ^/ is undo
bindkey '^[^x' execute-named-cmd

# https://unix.stackexchange.com/a/250700
function my-backward-kill-word {
    WORDCHARS="" zle backward-kill-word
}
zle -N my-backward-kill-word
bindkey '^W' my-backward-kill-word

#------------#
# completion #
#------------#

# made easy by this guy
# https://thevaluable.dev/zsh-completion-guide-examples/

zmodload zsh/complist

# move around completion menu with ^h, ^j, ^k, ^l
# hjkl does not work with 'history-incremental-search-forward'
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -M menuselect '^l' vi-forward-char
# search completions
bindkey -M menuselect '/' history-incremental-search-forward

autoload -U compinit; compinit

zstyle ':completion:*' completer _extensions _complete _approximate # the order matters
zstyle ':completion:*' use-cache 1
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompcache"
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' menu select

# try completion and if nothing matches, try case-insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# complete partial words
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

#---------#
# options #
#---------#

HISTSIZE=1000000 # the number of items for the internal history list
SAVEHIST=1000000 # maximum number of items for the history file
HISTFILE=~/.zsh_history

setopt HIST_IGNORE_ALL_DUPS # do not put duplicated command into history list
setopt HIST_REDUCE_BLANKS   # remove unnecessary blanks
setopt HIST_SAVE_NO_DUPS    # do not save duplicated command
setopt APPEND_HISTORY       # append the new history to the old when the shell exits
setopt HIST_VERIFY          # do not execute line immediately after substitution

setopt NO_NOTIFY  # do not immediately notify when a background job finishes
setopt NO_BEEP
setopt NO_AUTO_CD

setopt MENU_COMPLETE # Automatically highlight first element of completion menu
setopt CSH_NULL_GLOB # error only if all patterns do not match and silently ignore non-matching

# globbing
setopt DOT_GLOB
setopt EXTENDED_GLOB

#---------#
# aliases #
#---------#

# https://superuser.com/a/1563859
unalias run-help
autoload run-help
HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
alias help=run-help

alias l="eza -laa -g --icons=auto --group-directories-first";
alias v="nvim"
alias tma="tmux attach"
alias lg="lazygit";
alias mv="mv -i"
alias cp="cp -i"
alias diff="diff --color=auto"
alias hist="history -dD"

#--------#
# prompt #
#--------#

# inspired by https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/eastwood.zsh-theme
PS1="%{%F{cyan}%}[%3~]$%{%F{none}%} "
PS2="%1_> " # prompt on multiline commands

# https://derrick.blog/2022/12/21/command-timing-in-zsh/
function format_time {
    local out=""
    local t=$1
    local d=$((t/1000/3600/24))
    local h=$((t/1000/3600%24))
    local m=$((t/1000/60%60))
    local s=$((t/1000%60))
    # local ms=$((t%1000))
    [[ $d -gt 0 ]] && echo -n " ${d}d"
    [[ $h -gt 0 ]] && echo -n " ${h}h"
    [[ $m -gt 0 ]] && echo -n " ${m}m"
    [[ $s -gt 0 ]] && echo -n " ${s}s"
    # [[ $ms -gt 0 ]] && echo -n " ${ms}ms"
    echo
}
function _timer_preexec {
    timer=$(($(date +%s%0N)/1000000))
}
function _timer_precmd {
    if [ "$timer" ]; then
        local now=$(($(date +%s%0N)/1000000))
        local elapsed=$now-$timer
        local reset_color=$'\e[00m'
        RPS1="%F{cyan}$(format_time "$elapsed")%{$reset_color%}"
        unset timer
    else
        RPS1=
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec _timer_preexec
add-zsh-hook precmd  _timer_precmd

#---------#
# plugins #
#---------#

source <(fzf --zsh)
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh

#-------------#
# environment #
#-------------#

# should be in .zshenv :p

export LANG=en_US.UTF-8
export TERMINAL='alacritty'
export MANPAGER='nvim +Man!'
export EDITOR='nvim'
export VISUAL='nvim'

export BAT_STYLE="-grid"
export PISTOL_CHROMA_STYLE='vim'
export PISTOL_CHROMA_FORMATTER='terminal256'

export GOPATH=$HOME/go

typeset -U path # do not add anything to $path if it's there already
path=(
    $path
    $HOME/.local/bin
    $GOPATH/bin
    $HOME/.npm-global/bin
)

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
