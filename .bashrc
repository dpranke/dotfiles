#
# OS-SPECIFIC and SITE-SPECIFIC CUSTOMIZATION
#

os=$(uname -s)
if [ "$os" = "Darwin" ]
then
  hostname=$(hostname -s)
  . ~/.bashrc.mac
elif [ "$os" = "Linux" ]
then
  hostname=$(hostname -s)
  . ~/.bashrc.linux
else
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
