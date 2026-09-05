#----------#
# bindings #
#----------#

bindkey -e
bindkey \^U backward-kill-line
bindkey '^[[Z' reverse-menu-complete
bindkey '\e[3~' delete-char # 'delete' key
bindkey '^\' redo # ^/ is undo
bindkey '^[^x' execute-named-cmd

# https://unix.stackexchange.com/a/250700
function actually-backward-delete-word {
    local WORDCHARS=${WORDCHARS/\//}
    zle backward-delete-word
}
zle -N actually-backward-delete-word
bindkey '^W' actually-backward-delete-word

#------------#
# completion #
#------------#

autoload -U compinit; compinit
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' menu select

#------#
# opts #
#------#

HISTSIZE=1000000 # the number of items for the internal history list
SAVEHIST=1000000 # maximum number of items for the history file
HISTFILE=~/.zsh_history

setopt HIST_IGNORE_ALL_DUPS # do not put duplicated command into history list
setopt HIST_REDUCE_BLANKS   # remove unnecessary blanks
setopt HIST_SAVE_NO_DUPS    # do not save duplicated command
setopt APPEND_HISTORY       # append the new history to the old when the shell exits
setopt HIST_VERIFY          # do not execute line immediately after substitution

setopt NO_NOTIFY     # do not immediately notify when a background job finishes
setopt NO_BEEP
setopt NO_AUTO_CD

setopt CSH_NULL_GLOB # error only if all patterns do not match and silently ignore non-matching
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
function convert_time {
    local t=$1
    local d=$((t/1000/60/60/24))
    local h=$((t/1000/60/60%24))
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
function preexec {
    timer=$(($(date +%s%0N)/1000000))
}
function precmd {
    if [ "$timer" ]; then
        local now=$(($(date +%s%0N)/1000000))
        local elapsed=$now-$timer
        local reset_color=$'\e[00m'
        RPS1="%F{cyan}$(convert_time "$elapsed")%{$reset_color%}"
        unset timer
    else
        RPS1=
    fi
    # # ad-hoc branch in PS1
    # if git rev-parse --is-inside-work-tree >&/dev/null; then
    #     # https://stackoverflow.com/a/16925062/33053458
    #     local branch=$(git name-rev --name-only HEAD)
    #     if [[ -n "$branch" ]] && [[ $PS1 == $PS1_ORIG ]]; then
    #         PS1="%{%F{green}%}[${branch}]%{%F{none}%}$PS1"
    #     fi
    # else
    #     PS1=$PS1_ORIG
    # fi
}

#---------#
# exports #
#---------#

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

. <(fzf --zsh)
# . /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
