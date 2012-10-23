if [ -f /etc/profile ]; then
    . /etc/profile
fi

if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

export PATH=/opt/local/bin:/opt/local/sbin:$PATH

