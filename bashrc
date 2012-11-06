# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# OSX-specific aliases
if [[ "$(uname)" == "Darwin" ]]; then
    alias ls='ls -Gh'
    alias la='ls -Gha'
    alias lla='ls -Ghla'
    alias l='ls -Ghl'

    # make sure top orders by cpu usage first in OSX
    alias top='top -o cpu'

    # set the emacs bin
    emacsbin='/Applications/MacPorts/Emacs.app/Contents/MacOS/Emacs'

# Linux-specific aliases
elif [[ "$(uname)" == "Linux" ]]; then
    alias ls='ls --color=always -h'
    alias la='ls --color=always -ha'
    alias lla='ls --color=always -hla'
    alias l='ls --color=always -hl'

    # set the emacs bin
    emacsbin='/usr/bin/emacs'

# issue warning
else
    echo "unspecified " `uname`
fi

# other aliases
alias dvips='dvips -t letter'
alias xmgrace='xmgrace -geometry 844x673'
alias ssh='/usr/bin/ssh -X'
alias rm='rm -i'

# configure color output for grep
GREP_COLOR="1;32"
alias grep='grep --color=auto'

# set up editor 
export EDITOR=$emacsbin" -nw"
alias emacs=$emacsbin' -fh'
if [ ! $DISPLAY ] ; then
    alias emacs=$emacsbin' -nw'
fi

# purge function to clear out crap from directories
function purge { 
    JUNK_FILES="*~ *.pyc *.fig.bak *.bib.bak *.blg *.end *.dvi *.aux *.bbl *.log *.toc *.nav *.out *.snm *.o *.orig "
    DUMMY_FILES="aa bb cc dd ee ff gg hh ii jj kk ll mm nn oo pp qq rr ss tt uu vv ww xx yy zz"
    for f in ${JUNK_FILES} ${DUMMY_FILES}; do 
        if [ -f $f ]; then 
            rm -f ${f} ; 
        fi; 
    done; 
}

# quick and dirty function to get ip address
function whatsmyip { 
    curl -s ifconfig.me/ip; 
}

# override the builtin cd function
# http://askubuntu.com/questions/16106/how-can-i-create-an-alias-for-cd-and-ls/16116#16116
function cd() {
    d="$*";
    if [ $# -eq 0 ]; then
	d=${HOME};
    fi;
    builtin cd "${d}" && ls
}

# define interactive shell
source ~/.bash_colors
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}"; echo -ne "\007";'
PS1="${WHITE}[${RED}\h ${WHITE}\W]$ ${NORMAL}"

# remember history of all commands. 
HISTTIMEFORMAT="%Y.%m.%d %H:%M:%S "
HISTSIZE=10000

# source django bash completion script
source ~/.django_bash_completion.sh
