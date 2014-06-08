#
# ~/.bashrc
#
 
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

export LANG=en_US.UTF-8
export EDITOR="vim"
export synclient VertEdgeScroll=1

# for setting hist`ory length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1500
HISTFILESIZE=3000
# don't put duplicate lines in the history. See bash(1) for more options
HISTCONTROL=ignoredups

# check the window size after command and, if necessary,
# update the values of LINES and COLUMNS
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    alias ls='ls  --color=auto'
    alias ll='ls -lh --color=auto'
    alias la='ls -la --color=auto'
    alias lla='ls -lha --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi 

alias mocp="mocp --theme trasparent-background"

export TERM=xterm-256color

#
# Configure colors.
#


#
# Functions for git repositories.
#

# On branch this return the branch name else '(no branch)'.
function get_git_branch()
{ 
    branch_name="$(git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///')"
    
    if [[ "$branch_name" != "" ]]; then
        echo "$branch_name"
    else
        echo "(no branch)"
    fi
}

function is_on_git()
{
    git rev-parse 2> /dev/null
}

function br()
{
     is_on_git &&  echo ""
}

function print_location()
{
    spwd="$(pwd)"
    IFS='/' folders=($spwd)

    fristfolder=${folders[@]:1:1}
    length=${#folders[@]}

    lastpos=$(($length - 1))
    
    lastfolder="${folders[$lastpos]}"


    echo "$lastfolder $lastpos $length" 

    path=""
    tput setab 233
    tput setaf 242

    for f in ${folders[@]}
    do 
        if [ "$f" = $lastfolder ]
        then
            echo -n "  "
          #  path+="$f"
        elif [ "$f" != "" ]
        then
            path+="$f  "
        fi       
    done
    echo -n "$path"
    tput setaf 255
    echo "$lastfolder"
}


function update_PS1()
{
    print_location
    echo "$(date)   $(br) $(get_git_branch) "
}

PS1="\$(update_PS1) > "

