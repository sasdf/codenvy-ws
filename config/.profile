# profile for sh/bash
# Tue Aug 26 13:58:59 CST 2014
#
# maintained by phi

export REALHOME=$(realpath $HOME)
if [ "$PWD" = "$HOME" ]; then
    cd "$REALHOME"
fi
export HOME=$REALHOME

if [ -f .hushlogin ] || [ "$TMUX" != "" ]
then
    hurry="h"
else
    hurry=""
fi

export LC_ALL=zh_TW.UTF-8

# don't include current path
export PATH=$HOME/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/bin:/usr/local/sbin:/usr/X11R6/bin:$PATH

# common env
export USER=$LOGNAME
export IGNOREEOF=23
export ENV="$HOME/.shrc"
export BLOCKSIZE=1k
export EDITOR=vim
export VISUAL=vim
export PAGER=less
export LESSCHARDEF=8bcccbcc18b.   # Used for command less
export LESS="-srPm-LESS-"

# common settings with programs
ulimit -S -c 0	# core dumpsize
umask 022

if [ "$SHELL" != "/bin/sh" ]; then
   BASH_ENV=$ENV
   . "$ENV"
fi

#those require external programs
if [ "$hurry" != "h" ]
then
    if [ -x /bin/mail ] ; then 
    /bin/mail -E
    case $? in
        0)
        echo "You have new mail."
        ;;
        2)
        echo "You have mail."
        ;;
    esac
    fi

    if [ "$(screen -ls | wc -l)" -gt 2 ]; then
    echo ""
    echo "There're screens detached! please use 'screen -r'."
    echo ""
    fi
    tmux ls 2>/dev/null

    date
    #cd $HOME
    mesg y 2>/dev/null
fi

export TERM=screen-256color
