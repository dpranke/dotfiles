#
# OS-SPECIFIC and SITE-SPECIFIC CUSTOMIZATION
#
os=$(/usr/bin/uname -s)
if [ "$os" = "Darwin" ]
then
  hostname=$(/bin/hostname -s)
  . ~/.bashrc.mac
elif [ "$os" = "Linux" ]
then
  hostname=$(/usr/bin/hostname -s)
  . ~/.bashrc.linux
else
  hostname=$(/usr/bin/hostname)
  . ~/.bashrc.win
fi

if [ -f ~/.bashrc.local.$hostname ]
then
  . ~/.bashrc.local.$hostname
fi

# Set files to be 775/664 by default
umask 002

setprompt
