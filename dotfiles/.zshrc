# Set the shell options
# autocd: change directory without entering "cd" in front of it
# nonomatch: pass a globbing expression as-is when it generates no matches
# histignorespace: ignore lines or aliases starting with a space for history purposes
# histignorealldups: Ignore duplicates in history
# share_history: Share commands inserted between terminals
# inc_append_history: Append commands to HISTFILE before the current shell exits
setopt autocd nonomatch histignorealldups histignorespace nohup share_history inc_append_history promptsubst

#====================== Functions =======================
function username_color {
	if [[ $UID -eq 0 ]]; then
		echo "$fg[red]"
	else
		echo "$fg[cyan]"
	fi
}

function git_prompt_info(){
	PREFIX=" %{$fg[white]%}on%{$reset_color%} %{$fg[cyan]%}"
	local ref
	ref=$(command git symbolic-ref --short HEAD 2> /dev/null) \
	|| ref=$(command git rev-parse --short HEAD 2> /dev/null) \
	|| return 0

	echo "${PREFIX}${ref}$(parse_git_dirty)%{$reset_color%}"
}

function parse_git_dirty(){
	STATUS=$(command git status --porcelain 2> /dev/null | tail -1)
	if [[ -n $STATUS ]]; then
		echo " %{$fg[red]%}⨯ "
	else
		echo " %{$fg[green]%}● "
	fi
	
}

evinced() {
	evince $@ &> /dev/null &; disown
}

dexec(){
	docker exec -it $1 /bin/bash
}
_dexec() {
  ((CURRENT++))
  words=(docker exec "${words[@]:1}")
  _normal
}
# ==============================================================
fpath=($fpath /home/lgian/.zsh/functions /usr/share/zsh/vendor-completions)
local current_dir='${PWD/#$HOME/~}'
local git_info='$(git_prompt_info)'
autoload -U colors && colors
[[ -x /usr/bin/dircolors ]] && eval `dircolors -b`
autoload -Uz compinit select-word-style
select-word-style bash # ctrl+w on words
compinit -i
compdef evinced=evince
compdef _dexec dexec


# ================ Bindings ====================================
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

export HISTSIZE=10000000
export SAVEHIST=10000000
export HIST_STAMPS="dd.mm.yyyy"
export SSH_AUTH_SOCK=/run/user/1000/ssh_auth_sock
# Fix color madness with xterm, screen
export TERM=xterm-256color

export PATH=$PATH:/usr/local/go/bin:/snap/bin:/home/lgian/playground/kitty/kitty/launcher
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

export HISTFILE=/home/lgian/.zsh_history
export EDITOR="vim"
export VISUAL="vim"

# Aliases
alias aptul="sudo apt list --upgradable"
alias l="ls -ahltr --color=always"
alias c="clear"
alias ssh-add='ssh-add -t 24h'
alias ls-enabled="systemctl list-units --type=service --state=active,running | awk '/.*\.service/ {print $1}'"
alias dpg="dpkg"
alias tf="terraform"

# Vagrant
alias vssh="vagrant ssh"
alias vu="vagrant up"
alias vh="vagrant halt"
alias k="kubectl"
alias kon="kubeon"
alias koff="kubeoff"

alias urldecode='python -c "import sys, urllib as ul; \
    print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; \
    print ul.quote_plus(sys.argv[1])"'

PROMPT="%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%{$(username_color)%}%n\
%{$fg[white]%}\
"@%{$fg[green]%}"$HOST\
%{$fg[white]%}[\
%{$terminfo[bold]$fg[yellow]%}${current_dir}%{$reset_color%}\
${git_info}]\
%{$fg[white]%} \
%{$terminfo[bold]$fg[red]%}→ %{$reset_color%}"

zstyle :compinstall filename '/home/lgian/.zshrc'

zstyle ':completion:*' completer \
 _oldlist _expand _complete rehash true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/compcache
zstyle ':completion:*:kill:*' command 'ps -e -o pid,%cpu,cmd'

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
source ~/kube-ps1.sh
PROMPT='$(kube_ps1)'$PROMPT
kubeoff
eval "$(zoxide init zsh)"

alias x=extract

extract() {
  setopt localoptions noautopushd

  if (( $# == 0 )); then
    cat >&2 <<'EOF'
Usage: extract [-option] [file ...]

Options:
    -r, --remove    Remove archive after unpacking.
EOF
  fi

  local remove_archive=1
  if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
    remove_archive=0
    shift
  fi

  local pwd="$PWD"
  while (( $# > 0 )); do
    if [[ ! -f "$1" ]]; then
      echo "extract: '$1' is not a valid file" >&2
      shift
      continue
    fi

    local success=0
    local extract_dir="${1:t:r}"
    local file="$1" full_path="${1:A}"
    case "${file:l}" in
      (*.tar.gz|*.tgz)
        (( $+commands[pigz] )) && { tar -I pigz -xvf "$file" } || tar zxvf "$file" ;;
      (*.tar.bz2|*.tbz|*.tbz2)
        (( $+commands[pbzip2] )) && { tar -I pbzip2 -xvf "$file" } || tar xvjf "$file" ;;
      (*.tar.xz|*.txz)
        (( $+commands[pixz] )) && { tar -I pixz -xvf "$file" } || {
        tar --xz --help &> /dev/null \
        && tar --xz -xvf "$file" \
        || xzcat "$file" | tar xvf - } ;;
      (*.tar.zma|*.tlz)
        tar --lzma --help &> /dev/null \
        && tar --lzma -xvf "$file" \
        || lzcat "$file" | tar xvf - ;;
      (*.tar.zst|*.tzst)
        tar --zstd --help &> /dev/null \
        && tar --zstd -xvf "$file" \
        || zstdcat "$file" | tar xvf - ;;
      (*.tar) tar xvf "$file" ;;
      (*.tar.lz) (( $+commands[lzip] )) && tar xvf "$file" ;;
      (*.tar.lz4) lz4 -c -d "$file" | tar xvf - ;;
      (*.tar.lrz) (( $+commands[lrzuntar] )) && lrzuntar "$file" ;;
      (*.gz) (( $+commands[pigz] )) && pigz -dk "$file" || gunzip -k "$file" ;;
      (*.bz2) bunzip2 "$file" ;;
      (*.xz) unxz "$file" ;;
      (*.lrz) (( $+commands[lrunzip] )) && lrunzip "$file" ;;
      (*.lz4) lz4 -d "$file" ;;
      (*.lzma) unlzma "$file" ;;
      (*.z) uncompress "$file" ;;
      (*.zip|*.war|*.jar|*.ear|*.sublime-package|*.ipa|*.ipsw|*.xpi|*.apk|*.aar|*.whl) unzip "$file" -d "$extract_dir" ;;
      (*.rar) unrar x -ad "$file" ;;
      (*.rpm)
        command mkdir -p "$extract_dir" && builtin cd -q "$extract_dir" \
        && rpm2cpio "$full_path" | cpio --quiet -id ;;
      (*.7z) 7za x "$file" ;;
      (*.deb)
        command mkdir -p "$extract_dir/control" "$extract_dir/data"
        builtin cd -q "$extract_dir"; ar vx "$full_path" > /dev/null
        builtin cd -q control; extract ../control.tar.*
        builtin cd -q ../data; extract ../data.tar.*
        builtin cd -q ..; command rm *.tar.* debian-binary ;;
      (*.zst) unzstd "$file" ;;
      (*.cab) cabextract -d "$extract_dir" "$file" ;;
      (*.cpio) cpio -idmvF "$file" ;;
      (*)
        echo "extract: '$file' cannot be extracted" >&2
        success=1 ;;
    esac

    (( success = success > 0 ? success : $? ))
    (( success == 0 && remove_archive == 0 )) && rm "$full_path"
    shift

    # Go back to original working directory in case we ran cd previously
    builtin cd -q "$pwd"
  done
}


# Startx on login
if [[ ! $DISPLAY && $XDG_VTNR -eq 1  ]]; then
	exec startx
fi

# add Pulumi to the PATH
export PATH=$PATH:/home/lgian/.pulumi/bin
