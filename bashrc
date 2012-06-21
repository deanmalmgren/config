# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#--------------------------------------------------------------------
# User specific global variables
#--------------------------------------------------------------------
JUNK_FILES="*~ *.pyc *.fig.bak *.bib.bak *.blg *.end *.dvi *.aux *.bbl *.log *.toc *.nav *.out *.snm *.o *.orig "
DUMMY_FILES="aa bb cc dd ee ff gg hh ii jj kk ll mm nn oo pp qq rr ss tt uu vv ww xx yy zz"
GREP_COLOR="1;32"

export PATH=$PATH:${HOME}/Codes/Tools
export PYTHONPATH=${HOME}/Codes:${HOME}/Biz/Codes
export EDITOR="/usr/bin/emacs -nw"

# tweeks for using django
export DJANGO_PROJECTS=${HOME}/Biz/Projects/Website/

#--------------------------------------------------------------------
# User specific aliases
#--------------------------------------------------------------------
alias ls='ls --color=always -h'
alias la='ls --color=always -ha'
alias lla='ls --color=always -hla'
alias l='ls --color=always -hl'
alias dvips='dvips -t letter'
alias xmgrace='xmgrace -geometry 844x673'
alias e='/usr/bin/emacs'
alias rm='rm -i'
alias grep='grep --color=auto'
alias ssh='/usr/bin/ssh -X'

alias latexdiff='${HOME}/Software/latexdiff/latexdiff-fast'
alias processing="${HOME}/Software/processing-1.2.1/processing"

#--------------------------------------------------------------------
# User functions
#--------------------------------------------------------------------
function purge { for f in ${JUNK_FILES} ${DUMMY_FILES}; do if [ -f $f ]; then rm -f ${f} ; fi; done; }
function fd { if [ $# -eq 1 ]; then cd "$1"; else cd; fi; ls; }
function codylpr { scp $1 cody:/home/staff/rdm && ssh cody "lpr $1 && rm -i $1";}
function whatsmyip { curl -s ifconfig.me/ip; }

#--------------------------------------------------------------------
# colors from http://systhread.net/texts/200703bashish.php
#--------------------------------------------------------------------
DULL=0
BRIGHT=1

FG_BLACK=30
FG_RED=31
FG_GREEN=32
FG_YELLOW=33
FG_BLUE=34
FG_VIOLET=35
FG_CYAN=36
FG_WHITE=37

FG_NULL=00

BG_BLACK=40
BG_RED=41
BG_GREEN=42
BG_YELLOW=43
BG_BLUE=44
BG_VIOLET=45
BG_CYAN=46
BG_WHITE=47

BG_NULL=00

# ANSI Escape Commands
ESC="\033"
NORMAL="\[$ESC[m\]"
RESET="\[$ESC[${DULL};${FG_WHITE};${BG_NULL}m\]"

# Shortcuts for Colored Text ( Bright and FG Only )
# DULL TEXT
BLACK="\[$ESC[${DULL};${FG_BLACK}m\]"
RED="\[$ESC[${DULL};${FG_RED}m\]"
GREEN="\[$ESC[${DULL};${FG_GREEN}m\]"
YELLOW="\[$ESC[${DULL};${FG_YELLOW}m\]"
BLUE="\[$ESC[${DULL};${FG_BLUE}m\]"
VIOLET="\[$ESC[${DULL};${FG_VIOLET}m\]"
CYAN="\[$ESC[${DULL};${FG_CYAN}m\]"
WHITE="\[$ESC[${DULL};${FG_WHITE}m\]"

# BRIGHT TEXT
BRIGHT_BLACK="\[$ESC[${BRIGHT};${FG_BLACK}m\]"
BRIGHT_RED="\[$ESC[${BRIGHT};${FG_RED}m\]"
BRIGHT_GREEN="\[$ESC[${BRIGHT};${FG_GREEN}m\]"
BRIGHT_YELLOW="\[$ESC[${BRIGHT};${FG_YELLOW}m\]"
BRIGHT_BLUE="\[$ESC[${BRIGHT};${FG_BLUE}m\]"
BRIGHT_VIOLET="\[$ESC[${BRIGHT};${FG_VIOLET}m\]"
BRIGHT_CYAN="\[$ESC[${BRIGHT};${FG_CYAN}m\]"
BRIGHT_WHITE="\[$ESC[${BRIGHT};${BG_WHITE}m\]"

# REV TEXT (as an example)
REV_CYAN="\[$ESC[${DULL};${BG_WHITE};${BG_CYAN}m\]"
REV_RED="\[$ESC[${DULL};${FG_YELLOW}; ${BG_RED}m\]"

#PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007";'
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}"; echo -ne "\007";'

#--------------------------------------------------------------------
# define interactive shell
#--------------------------------------------------------------------
#TIME=$(date +%Y.%m.%d\ %T)
#PS1="\[\033[0;37m\][\[\033[0;31m\]\$TIME \[\033[0;37m\]\W]$ \[\033[0m\]"
#PS1="${WHITE}[${RED}`date +%Y.%m.%d\ %T` ${WHITE}\W]$ ${NORMAL}"
PS1="${WHITE}[${RED}\h ${WHITE}\W]$ ${NORMAL}"

#--------------------------------------------------------------------
# record history usage (this is kind of a hack.  it would be much
# better to use the 'history' command, but the current version of
# history is not recent enough.)
#--------------------------------------------------------------------
# start recording history
#script -a -f ${HOME}/.typescript

# remember history (only works with bash 3.0)
HISTTIMEFORMAT="%Y.%m.%d %H:%M:%S "
HISTSIZE=10000

#--------------------------------------------------------------------
# source django bash completion script
#--------------------------------------------------------------------
source ~/.django_bash_completion.sh
