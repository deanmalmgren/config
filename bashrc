# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# define absolute path to home directory so this can be used on OSX
# and linux and referenced by other users (e.g., a vagrant user)
# http://stackoverflow.com/q/59895/564709
home=$(dirname ${BASH_SOURCE[0]})

# OSX-specific aliases
if [[ "$(uname)" == "Darwin" ]]; then
    alias ls='ls -Gh'
    alias la='ls -Gha'
    alias lla='ls -Ghla'
    alias l='ls -Ghlrt'

    # make sure top orders by cpu usage first in OSX
    alias top='top -o cpu'

    # set the emacs bin
    emacsbin='/Users/rdm/Applications/Emacs.app/Contents/MacOS/Emacs'

    # set PYTHONPATH so that meld will work
    # https://github.com/mxcl/homebrew/issues/20644
    export PYTHONPATH=$(brew --prefix)/lib/python2.6/site-packages:$PYTHONPATH

    # Linux-specific aliases
elif [[ "$(uname)" == "Linux" ]]; then
    alias ls='ls --color=always -h'
    alias la='ls --color=always -ha'
    alias lla='ls --color=always -hla'
    alias l='ls --color=always -hlrt'

    # set the emacs bin
    emacsbin='/usr/bin/emacs'

    # issue warning
else
    echo "unspecified " `uname`
fi

# other aliases
alias dvips='dvips -t letter'
alias xmgrace='xmgrace -geometry 844x673'
alias rm='rm -i'

# # set up ssh to recognize a bunch of project-specific ssh config
# # files. this is useful for maintaining an ever-growing number of
# # servers we need to ssh to on a project-by-project basis
# # http://superuser.com/a/414310/126633
# function ssh () {
#     tmp_fifo=$(mktemp --suffix=_ssh_fifo)
#     cat ${home}/.ssh/config ${home}/Projects/*/.ssh/config > "$tmp_fifo"
#     # /usr/bin/ssh -F "$tmp_fifo" -X "$@"
#     /usr/bin/ssh -F "$tmp_fifo" "$@"
#     /bin/rm -f "$tmp_fifo"
# }

# autocompletion for ssh/scp/sftp http://bit.ly/U9DYck. use a function
# to autocomplete so it works if a new host is added to ~/.ssh/config
# during a shell session
_sshautocomplete() {
    f=${home}/.ssh/config
    cur="${COMP_WORDS[COMP_CWORD]}"
    if [ -f ${f} ]; then
        hosts=$(echo `grep "^Host " ${f} | awk '{print $2}' | sort -u`)
        COMPREPLY=($(compgen -W "${hosts}" -- ${cur}))
        return 0;
    fi
    return 1;
}
complete -F _sshautocomplete ssh scp sftp

# configure color output for grep
GREP_COLOR="1;32"
alias grep='grep --color=auto'

# configure cal to print out calendar for current year by default
function cal () {
    if [ $# -eq 0 ]; then
        /usr/bin/cal `date "+%Y"`;
    else
        /usr/bin/cal $*;
    fi;
}

# set up editor
export EDITOR=$emacsbin" -nw"
if [[ "$(uname)" == "Darwin" ]]; then
    alias emacs=$emacsbin' -geometry 80x57'
else
    alias emacs=$emacsbin' -fh'
fi
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
source ${home}/.bash_colors
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}"; echo -ne "\007";'
PS1="${WHITE}[${RED}\h ${WHITE}\W]$ ${NORMAL}"

# remember history of all commands. 
HISTTIMEFORMAT="%Y.%m.%d %H:%M:%S "
HISTSIZE=10000

# autocompletions
source ${home}/.django_bash_completion.sh
if [[ "$(uname)" == "Darwin" ]]; then

    # mercurial completion
    source `brew --prefix`/etc/bash_completion.d/hg-completion.bash

    # vagrant autocomplete
    if [ -f `brew --prefix`/etc/bash_completion.d/vagrant ]; then
        source `brew --prefix`/etc/bash_completion.d/vagrant
    else
        echo -e "${YELLOW}vagrant completion not enabled. to enable:${NORMAL}"
        echo -e "  ${YELLOW}brew tap homebrew/completions${NORMAL}"
        echo -e "  ${YELLOW}brew install vagrant-completion${NORMAL}"
    fi
fi
