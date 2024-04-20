#
# OS-SPECIFIC and SITE-SPECIFIC CUSTOMIZATION
#

os=$(uname -s)
if [ "$os" = "Darwin" -a -f ~/.bashrc.mac ]
then
   export OSNAME=mac
   hostname=$(hostname -s)
  . ~/.bashrc.mac
elif [ "$os" = "Linux" -a -f ~/.bashrc.linux ]
then
    export OSNAME=linux
   hostname=$(hostname -s)
  . ~/.bashrc.linux
elif [ -f ~/.bashrc.win ]
then
  export OSNAME=cygwin
  hostname=$(hostname) 
  . ~/.bashrc.win
fi

if [ -f ~/.bashrc.local.$hostname ]
then
  . ~/.bashrc.local.$hostname
fi

# Set files to be 775/664 by default
umask 002

setprompt
