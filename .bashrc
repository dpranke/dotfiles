#
# OS-SPECIFIC and SITE-SPECIFIC CUSTOMIZATION
#

os=$(uname -s)
if [ "$os" = "Darwin" -a -f ~/.bashrc.mac ]
then
   export OSNAME=mac
  . ~/.bashrc.mac
elif [ "$os" = "Linux" -a -f ~/.bashrc.linux ]
then
    export OSNAME=linux
  . ~/.bashrc.linux
elif [ -f ~/.bashrc.win ]
then
    export OSNAME=cygwin
  . ~/.bashrc.win
fi

if [ -f ~/.bashrc_local ]
then
  . ~/.bashrc_local
fi

if [ -f ~/.git-completion.sh ]
then
 . ~/.git-completion.sh
 GIT_PRESENT=1
 # GIT_PS1_SHOWDIRTYSTATE=1
fi

if [ -f ~/.bashrc_cloud ]
then
  . ~/.bashrc_cloud
fi

setprompt
