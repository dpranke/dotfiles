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

export NINJA_JOBS=''

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

function bld() {
    time ninja -C $csrc/out/Release $NINJA_JOBS all_webkit $@
}

function bldd() {
    time ninja -C $csrc/out/Debug $NINJA_JOBS all_webkit $@
}

function gomaenv() {
    if [ "$1" = "-d" ]
    then
        rp /src/goma
        unset CC
        unset CXX
        rp $csrc/third_party/llvm-build
        export NINJA_JOBS=""
    else
        if [ ! -d /src/goma ]
        then
          echo "goma not installed"
          return 1
        fi
        if [ "$OSNAME" == "mac" ]
        then
          export PATH=$csrc/third_party/llvm-build/Release+Asserts/bin:$PATH
          export CC=clang
          export CXX=clang++
        fi
        export PATH=/src/goma:$PATH
        export NINJA_JOBS="-j 250"
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

function latest_roll() {
  git log -1 $(git blame DEPS | awk '$7 == "\"webkit_revision\":" { print $1 }') | tail -1 | sed -e 's/.*@\(.*\) .*/\1/'
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
  export ${var}="$(echo ${!var} | sed "s#[^:]*${comp_regex}[^:]*##${opt_g}" | \
                      sed "s/::*/:/g" | sed "s/^://" | sed "s/:$//")"
  unset comp_regex
  unset var
  unset opt_g
}


# run layout tests w/o any command line flags
function rwt() {
  time (echodo $bls/run-webkit-tests $@ )
}

# run layout tests w/ common command line flags
function rwtd() {
  rwt --clobber-old-results --no-new-test-results $@
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
    unset bls
    unset blt
    unset blp
    unset gom
  else
    export gom=$bl/Tools/BuildSlaveSupport/build.webkit.org-config/public_html/TestFailures
    export lts=$csrc/webkit/tools/layout_tests
    export ltw=$bl/LayoutTests
    export bls=$bl/Tools/Scripts
    export blp=$bls/webkitpy
    export blt=$blp/layout_tests
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
  blview=0
  if [ -d "$new_src/third_party/WebKit" ]
  then
    export bl=$new_src/third_party/WebKit
    export csrc=$new_src
  else
    if [ -d "$new_src/LayoutTests" ]
    then
      export bl=$new_src
    fi
    csrc=$new_src
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
  if [ -n "$bl" ]
  then
    rp Tools
    rp PYTHONPATH Tools
    ap ${bls}
    ap PYTHONPATH ${bls}
  fi

  unset arg
  unset new_name
  unset new_dir
  unset new_view
  unset new_src
  csrc
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


# cd to $bl/$*
function bl() {
  if [ -z "$bl" ]
  then
    echo "not in a view"
  else
    cd $bl/$*
  fi
}


# cd to "$blp/$*"
function blp() {
  if [ -z "$blp" ]
  then
    echo "not in a view"
  else
    cd $blp/$*
  fi
}


# cd to "$blt/$*"
function blt() {
  if [ -z "$blt" ]
  then
    echo "not in a view"
  else
    cd $blt/$*
  fi
}


# cd to "$bls/$*"
function bls() {
  if [ -z "$bls" ]
  then
    echo "not in a view"
  else
    cd $bls/$*
  fi
}

function wk { bl $@; }
function wks { bls $@; }
function wkt { blt $@; }
function wkp { blp $@; }

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
