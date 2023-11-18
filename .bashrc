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

# Set files to be 775/664 by default
umask 002

setprompt
