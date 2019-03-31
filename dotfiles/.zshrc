# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="honukai"
# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

HIST_STAMPS="dd.mm.yyyy"

# Add wisely, as too many plugins slow down shell startup.
plugins=(ssh-agent zsh-autosuggestions zsh-syntax-highlighting)

zstyle :omz:plugins:ssh-agent identities id_rsa
zstyle :omz:plugins:ssh-agent lifetime 24h
source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
export EDITOR='vim'

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Fix color madness with xterm, screen
export TERM=xterm-256color
# [ -n "$TMUX" ] && export TERM=screen-256color

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:/snap/bin:$HOME/.cargo/bin
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export DOCKER_API_VERSION=1.34

# Aliases
alias nfzf="xdg-open \$(fzf)"
alias vu="vagrant up"
alias vh="vagrant halt"
alias vssh="vagrant ssh"
alias l="ls -ahl --color=always"
alias c="clear"
alias vssh="vagrant ssh"

alias urldecode='python -c "import sys, urllib as ul; \
    print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; \
    print ul.quote_plus(sys.argv[1])"'
# opens up the pdf with the latest 'last modified' timestamp and removes it from the shell job list
alias ta='tmux attach -t'
alias ts='tmux new-session -s'

evinced() {
	evince $@ &> /dev/null &; disown
}
compdef evinced=evince

nd() {
	nautilus $@ 2&>1 &; disown
}
compdef nd=nautilus

# Added this to avoid duplicates on fzf
setopt HIST_IGNORE_ALL_DUPS

export HISTFILE=/home/lgian/.zsh_history
export EDITOR="vim"
export TERMINAL="gnome-terminal -e"
export VISUAL="vim"
export NNN_USE_EDITOR=1

############# Colored Manpages ###########
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal
##########################################

source ~/.zshrc_local
# Startx on login
if [[ ! $DISPLAY && $XDG_VTNR -eq 1  ]]; then
	exec startx
fi
