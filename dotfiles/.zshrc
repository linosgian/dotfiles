# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="honukai"


# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

HIST_STAMPS="dd.mm.yyyy"

# Add wisely, as too many plugins slow down shell startup.
plugins=(git k zsh-autosuggestions zsh-syntax-highlighting )

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Fix color madness with xterm, screen
export TERM=xterm-256color
# [ -n "$TMUX" ] && export TERM=screen-256color

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:/snap/bin:$HOME/.cargo/bin
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export DOCKER_API_VERSION=1.34

# Aliases
alias vu="vagrant up"
alias vh="vagrant halt"
alias vssh="vagrant ssh"
alias l="ls -ahl"
alias c="clear"
alias vssh="vagrant ssh"

alias urldecode='python -c "import sys, urllib as ul; \
    print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; \
    print ul.quote_plus(sys.argv[1])"'
# opens up the pdf with the latest 'last modified' timestamp and removes it from the shell job list
alias evincel='evince ~/Downloads/$(cd Downloads; ls -t *.pdf | head -n1) 2&>1 &; disown'
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
source ~/.zshrc_local
# Added this to avoid duplicates on fzf
setopt HIST_IGNORE_ALL_DUPS

export HISTFILE=/home/lgian/.zsh_history
alias notes='cd ~/Nextcloud/Notes/ && vim index.md'
