umask 022
export PATH=$HOME/bin:/usr/kerberos/bin:/usr/bin:/usr/local/bin:/bin
export PATH=$PATH:/usr/X11R6/bin:/sbin:/usr/sbin:/usr/local/sbin

export NO_BREAKPAD=1

alias ll='ls -Fl'
alias lh='ls -Fhl'
alias du='du -h'
alias ls='ls -F'
alias df='df -h'
alias la='ls -Fa'

if which vim > /dev/null
then
  alias e='vim'
  alias v='vim -R'
else
  alias e='vi'
  alias v='view'
fi

alias l=less
alias h='history'

export EDITOR=vim

# ap - add path component if it's not already there and it exists
#   usage: ap [var] value
function ap() {
  if [ $# -eq 2 ]
  then
    var="$1"
    shift
  else
    var=PATH
  fi
  if ( echo "${!var}" | grep "$1:" > /dev/null )
  then
    return
  elif [ -d "$1" ]
  then
    export ${var}="${!var}:$1"
  fi
}

function gb() {
    if [ "$1" == "-a" ]
    then
        git branch
    else
        git branch | \
          awk '$0 !~ /\.old|-old|-landed|-wf/ || $0 ~ /^\*/ { print }'
    fi
}

# csrc - cd to $csrc/$*
function csrc() {
  if [ ! -z "$csrc" ]
  then
    cd ${csrc}/$*
  else
    echo "not in a view"
  fi
}

function coverase() {
  coverage erase ; find . -name '*.py,cover' | xargs rm
}

function covreport() {
  skipfiles=$wks/test-webkitpy
  skipfiles="$skipfiles,rebaseline_chromium_webkit_tests"
  skipfiles="$skipfiles,$wks/webkitpy/__init__"
  skipfiles="$skipfiles,$wks/webkitpy/common"
  skipfiles="$skipfiles,$wks/webkitpy/python24"
  skipfiles="$skipfiles,$wks/webkitpy/style"
  skipfiles="$skipfiles,$wks/webkitpy/test"
  skipfiles="$skipfiles,$wks/webkitpy/thirdparty"
  skipfiles="$skipfiles,$wks/webkitpy/tool"
  # skipfiles="$skipfiles,$wks/webkitpy/port"
  skipfiles="$skipfiles,port/apache_http_server"
  skipfiles="$skipfiles,port/gtk"
  skipfiles="$skipfiles,port/qt"
  skipfiles="$skipfiles,port/http_server"
  skipfiles="$skipfiles,port/http_server_base"
  skipfiles="$skipfiles,port/server_process"
  skipfiles="$skipfiles,port/websocket_server"
  coverage report --omit="$skipfiles"
}

function covrun() {
  clear
  coverase
  if [ -z "$*" ]
  then
    coverage run --rcfile=.coveragerc test_suite.py
  else
    coverage run --rcfile=.coveragerc $*
  fi
  coverage annotate
  covreport
}

function chrup () { gclient sync && ninja -C $csrc/out/Release DumpRenderTree; }

# em - edit w/ emacs (in terminal window)
function em () { emacs -nw $* ; }

# ep - echo PATH (or other variable)
function ep() {
  if [ $# -eq 1 ]
  then
    var=$1
    shift
  else
    var=PATH
  fi
  echo ${!var}
}

function gitbranch() {
  # _git_ps1 "%s", but buggier and much faster
  b=$(git symbolic-ref HEAD 2>/dev/null)
  echo ${b##refs/heads/}
}

function gom() {
  if [ -z "$gom" ]
  then
    echo "not in a view"
  else
    cd $gom/$* ;
  fi
}
  
function gpy() {
  git grep $* -- "*.py"
}

function ltc() {
  if [ -z "$ltc" ]
  then
    echo "not in a view"
  else
    cd $ltc/$* ;
  fi
}

function ltml() {
  if [ -z "$ltml" ]
  then
    echo "not in a view"
  else
    cd $ltml/$* ;
  fi
}

# cd to WebKit/LayoutTests/$*
function ltw() {
  if [ -z "$ltw" ]
  then
    echo "not in a view"
  else
    cd $ltw/$* ;
  fi
}


# cd to webkit/tools/layout_tests/$*
function lts() {
  if [ -z "$lts" ]
  then
    echo "not in a view"
  else
    cd $lts/$*
  fi
}

function pd { webkit-patch pretty-diff $*; }

function pdu { webkit-patch pretty-diff -g UPSTREAM.... $*; }

function pset() {
    set | pset_aux $*
}

function pwv() {
    if [ -n "$view" ]
    then
        echo "$view"
    else
        echo "[not in a view]"
    fi
}

# redot - re-read dot files
function redot() {
  local old_view
  old_view=$view
  . ~/.bashrc
  if [ -n "$old_view" ]
  then
    sv $old_view
    cd -
  fi
}

function repeat() {
  count=$1
  shift

  while [ $count -ne 0 ]
  do
    $@
    if [ $? -gt 128 ]
    then
      return
    fi
    count=$((count - 1))
  done
}


# revno - print out latest Chromium version number
function revno() {
    if [ "$1" = "--lkgr" ]
    then
        curl -s http://chromium-status.appspot.com/lkgr
        echo
    elif [ "$1" = "--latest" -o "$1" = "--head" ]
    then
        svn info http://src.chromium.org/svn/trunk/src | awk '$1 == "Revision:" {print $2}'
    else
        svn info . | awk '$1 == "Revision:" { print $2 }'
    fi
}


# rp - remove path component
#   usage: rp [-a] [var] comp_regex
function rp() {
  if [ "$1" = "-a" ]
  then
    opt_g="g"
    shift
  else
    opt_g=""
  fi
  if [ $# -eq 2 ]
  then
    var=$1
    shift
  else
    var=PATH
  fi
  comp_regex=$1
  export ${var}="$(echo ${!var} | sed "s-[^:]*${comp_regex}[^:]*--${opt_g}" | \
                      sed "s/::*/:/g" | sed "s/^://" | sed "s/:$//")"
  unset comp_regex
  unset var
  unset opt_g
}


# run layout tests w/o any command line flags
function rwt() {
  time (echodo python $wks/new-run-webkit-tests $* )
}

# run layout tests w/ chromium-specific flags
function rwtc() {
  rwtd --chromium $*
}

# run layout tests w/ common command line flags
function rwtd() {
  rwt --clobber-old-results --no-new-test-results $*
}

function rwtn() {
  rwtd --no-show-results $*
}

function rwtl() {
    rwtc --lint-test-files $*
}

function setprompt() {
  if [ "$TERM" = "xterm" -o "$TERM" = "xterm-color" -o \
       "$TERM" = "xterm-256color" -o "$TERM" = "msys" -o "$TERM" = "cygwin" ]
  then
    if [ ! -z "$view" ]
    then
      if [ "$GIT_PRESENT" = "1" -a "$OSNAME" != "cygwin" ]
      then
        PS1='\[\e]0;\u@\h ($view|$(gitbranch)):\w\a\]\W $ '
      else
        PS1='\[\e]0;\u@\h ($view):\w\a\]\W $ '
      fi
    else
      PS1='\[\e]0;\u@\h:\w\a\]\W $ '
    fi
  else
    if [ ! -z "$view" ]
    then
      PS1="($view) \W $ "
    else
      PS1="\W $ "
    fi
  fi
}


# setup shortcuts
function shortcuts() {
  if [ -z "$csrc" ]
  then
    unset ltc
    unset lts
    unset ltw
    unset wks
    unset wkt
    unset gom
  else
    export gom=$wk/Tools/BuildSlaveSupport/build.webkit.org-config/public_html/TestFailures
    export lts=$csrc/webkit/tools/layout_tests
    export ltw=$wk/LayoutTests
    export ltc=$ltw/platform/chromium
    export ltml=$ltw/platform/chromium-mac-mountainlion
    export wks=$wk/Tools/Scripts
    export wkp=$wks/webkitpy
    export wkt=$wkp/layout_tests
  fi
}


function src() { cd $src/$* ; }


function sv() {
  arg=$1

  # set the $src and $wk dirs accordingly.
  if [ -d "$src/$arg" ]
  then
    new_dir=$arg
  else
    echo "no such view '$new_view' under $src"
    unset new_view
    unset new_dir
    return
  fi

  new_name=$arg
  if [ -d "$src/$new_dir/src" ]
  then
    new_src=$src/$new_dir/src
  else
    new_src=$src/$new_dir
  fi

  export view=$new_name
  wkview=0
  if [ -d "$new_src/third_party/WebKit" ]
  then
    export wk=$new_src/third_party/WebKit
    export csrc=$new_src
  elif [ -d "$new_src/Source/WebCore" ]
  then
    export wk=$new_src
    export csrc=$new_src/Source/WebKit/chromium
    wkview=1
  else
    unset wk
  fi

  if echo "$view" | grep 'depot' > /dev/null
  then
    export depot_view=1
  else
    unset depot_view
  fi

  if echo "$-" | grep 'i' > /dev/null
  then
    echo "current view: $view (csrc = $csrc)"
  fi
  shortcuts
  setprompt

  if [ -z "$1" -a ! -z "$csrc" ]
  then
    return
  fi

  shift
  if [ -n "$wk" ]
  then
    rp Tools
    rp WebKitTools
    rp PYTHONPATH Tools
    rp PYTHONPATH WebKitTools
    ap ${wks}
    ap PYTHONPATH ${wks}
  fi

  unset arg
  unset new_name
  unset new_dir
  unset new_view
  unset new_src
  unset new_wk
  if [ $wkview -eq 1 ]
  then
    wk
  else
    csrc
  fi
  unset wkview
}


# Bash completion for sv()
# return any directories matching $src/c\.*
function _sv_comp() {
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  opts=$(cd $src ; \ls -1 | grep '^c\.' | sed 's/c\.//g' | tr "\n" " ")

  COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
  return 0
}

complete -F _sv_comp sv


# svnd - diff file against latest checked-in version
function svnd() { svn diff --diff-cmd diff -x --normal $*; }


# svnr - revert files to latest checked-in version
function svnr() {
  if [ "$(svn st $*)" != "" ]
  then
    svn st $* | awk '{gsub(/\\/, "/"); print $NF}' | xargs svn revert
  fi
}

function tw() {
    test-webkitpy -q $*
}

# echo current window size
function window_size() {
    echo "${COLUMNS}x${LINES}"
}


# cd to $wk/$*
function wk() {
  if [ -z "$wk" ]
  then
    echo "not in a view"
  else
    cd $wk/$*
  fi
}


# cd to "$wkp/$*"
function wkp() {
  if [ -z "$wkp" ]
  then
    echo "not in a view"
  else
    cd $wkp/$*
  fi
}


# cd to "$wkt/$*"
function wkt() {
  if [ -z "$wkt" ]
  then
    echo "not in a view"
  else
    cd $wkt/$*
  fi
}


# cd to "$wks/$*"
function wks() {
  if [ -z "$wks" ]
  then
    echo "not in a view"
  else
    cd $wks/$*
  fi
}

function wkup { update-webkit --chromium && build-webkit --chromium; }

function wp { webkit-patch $@; }

function wpg { webkit-patch garden-o-matic $*; }

function wppb { webkit-patch print-baselines $*; }

function wppe { webkit-patch print-expectations $*; }


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

setprompt
