if [ -f /etc/profile ]; then
    . /etc/profile
fi

if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

##
# Your previous /Users/dpranke/.bash_profile file was backed up as /Users/dpranke/.bash_profile.macports-saved_2013-12-11_at_15:19:10
##

# MacPorts Installer addition on 2013-12-11_at_15:19:10: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH
