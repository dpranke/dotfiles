if [ -f /etc/profile ]; then
    . /etc/profile
fi

if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
