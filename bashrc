# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

#--------------------------------------------------------------------
# User specific aliases
#--------------------------------------------------------------------
alias ls='ls --color=always -h'
alias la='ls --color=always -ha'
alias lla='ls --color=always -hla'
alias l='ls --color=always -hl'
alias dvips='dvips -t letter'
alias xmgrace='xmgrace -geometry 844x673'
alias ssh='/usr/bin/ssh -X'
alias rm='rm -i'
alias grep='grep --color=auto'

# set up editor 
export EDITOR="/usr/bin/emacs -nw"
alias emacs='/usr/bin/emacs -fh'
if [ ! $DISPLAY ] ; then
    alias emacs='/usr/bin/emacs -nw'
fi

alias latexdiff='${HOME}/Software/latexdiff/latexdiff-fast'
alias processing="${HOME}/Software/processing-1.2.1/processing"

#--------------------------------------------------------------------
# User specific global variables
#--------------------------------------------------------------------
JUNK_FILES="*~ *.pyc *.fig.bak *.bib.bak *.blg *.end *.dvi *.aux *.bbl *.log *.toc *.nav *.out *.snm *.o *.orig "
DUMMY_FILES="aa bb cc dd ee ff gg hh ii jj kk ll mm nn oo pp qq rr ss tt uu vv ww xx yy zz"
GREP_COLOR="1;32"

export PATH=$PATH:${HOME}/Codes/Tools
export PYTHONPATH=${HOME}/Codes:${HOME}/Biz/Codes

# tweeks for using django
export DJANGO_PROJECTS=${HOME}/Biz/Projects/Website/

#--------------------------------------------------------------------
# User functions
#--------------------------------------------------------------------
function purge { 
    for f in ${JUNK_FILES} ${DUMMY_FILES}; do 
        if [ -f $f ]; then 
            rm -f ${f} ; 
        fi; 
    done; 
}

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

#--------------------------------------------------------------------
# define interactive shell
#--------------------------------------------------------------------
source ~/.bash_colors
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}"; echo -ne "\007";'
PS1="${WHITE}[${RED}\h ${WHITE}\W]$ ${NORMAL}"

#--------------------------------------------------------------------
# record history usage (this is kind of a hack.  it would be much
# better to use the 'history' command, but the current version of
# history is not recent enough.)
# remember history (only works with bash 3.0)
#--------------------------------------------------------------------
HISTTIMEFORMAT="%Y.%m.%d %H:%M:%S "
HISTSIZE=10000

#--------------------------------------------------------------------
# source django bash completion script
#--------------------------------------------------------------------
source ~/.django_bash_completion.sh
