# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="gentoo"
plugins=(git django vi-mode python pip archlinux github)
source $ZSH/oh-my-zsh.sh

#=================== Enviromental Variables ==================#

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/core_perl:/home/afein/build/JMF-2.1.1e/bin:/home/afein/build/jdk1.7.0_10/bin:/home/afein/eclipse/eclipse:/home/afein/.gem/ruby/1.9.1/bin
export BROWSER="spacefm"
export TERM="rxvt"

#==================== Awesome Functions =========================#

# Pretty-print the hostname
function hello() {
    echo -en '\e[0;35m' # Orange-like
	figlet $(hostname) 
    echo -en '\e[0m' 
}

# Set initial window transparency 
function init_window() {
    transset-df 0.9 --id $(xdotool getwindowfocus)
}

# Extract archives
function extract () {
if [[ -f "$1" ]]; then
    case "$1" in
        *.tbz2 | *.tar.bz2) tar -xvjf  "$1"     ;;
        *.txz | *.tar.xz)   tar -xvJf  "$1"     ;;
        *.tgz | *.tar.gz)   tar -xvzf  "$1"     ;;
        *.tar | *.cbt)      tar -xvf   "$1"     ;;
        *.zip | *.cbz)      unzip      "$1"     ;;
        *.rar | *.cbr)      unrar x    "$1"     ;;
        *.arj)              unarj x    "$1"     ;;
        *.ace)              unace x    "$1"     ;;
        *.bz2)              bunzip2    "$1"     ;;
        *.xz)               unxz       "$1"     ;;
        *.gz)               gunzip     "$1"     ;;
        *.7z)               7z x       "$1"     ;;
        *.Z)                uncompress "$1"     ;;
        *.gpg)       gpg2 -d "$1" | tar -xvzf - ;;
        *) echo "Error: failed to extract $1" ;;
    esac
else
  echo "Error: $1 is not a valid file for extraction"
fi
} 

# Open images or documents
function open () {
if [[ -f "$1" ]]; then
    case "$1" in
        *.png)              feh     "$1" &   ;;
        *.jpeg)             feh     "$1" &   ;;
        *.JPG)              feh     "$1" &   ;;
        *.jpg)              feh     "$1" &   ;;
        *.pdf)              zathura     "$1" &> /dev/null &   ;;
        *.odt | *.doc | *.docx)  libreoffice "$1" &> /dev/null &   ;;
        *.avi)              mplayer     "$1"    ;;
        *)                  vim "$1"            ;;
    esac
else
  echo "Error: $1 is not a valid file to open"
fi
}

# Play media files 
function play () {
if [[ -f "$1" ]]; then
    case "$1" in
        *.mp3 | *.ogg)      mplayer "$1"   ;;
        *.avi | *.mp4 | *.mkv)      mplayer "$1"   ;;
        *.pls | *.m3u)      mplayer -playlist "$1"   ;;
        *) echo "Error: failed to open $1" ;;
    esac
else
  echo "Error: $1 could not play file"
fi
}

# Google something
function google {
    q=""
    i=0
    for var in "$@"
    do
        if [ "$i" -eq "0" ]; then
            q+=$var
        else
            q+="+"$var
        fi
        i+=1
    done
    chromium "http://www.google.com/search?q=$q"
}


# Run skype as a restricted user
function doskype() {
    xhost +local: && sudo -u skype /usr/bin/skype
}

#==================== Init Actions ===========================#

if [ "$(hostname)" = "archtop" ]; then
    init_window > /dev/null 2>&1
    eval $(keychain -q --eval --agents ssh -Q ~/.ssh/id_rsa)
fi

# Show hostname if not in scratchpad
if [[ -z $SCRATCH ]]; then
    hello
fi

#==================== Custom aliases =========================#

alias ls='ls --color=auto'
alias letsmine='cgminer --url http://btcguild.com:8332/ --user nalfemp_1 --pass a'
alias svim="sudo vim -u /home/afein/.vimrc "
alias grst="git reset --hard HEAD"
alias mix="alsamixer"
alias s="source ~/.zshrc"

#   Git 
alias ga="git add"
alias gpl="git pull"
alias gps="git push"
alias gmt="git commit -m "
alias gamt="git commit -am "
