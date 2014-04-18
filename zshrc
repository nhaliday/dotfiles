#!/usr/bin/env zsh

setopt extendedglob

source $ZSH/oh-my-zsh.sh

# my go packages
export GOPATH=$HOME/go

# Customize to your needs...
export PATH=$HOME/bin:$HOME/.cabal/bin:$HOME/Applications/factor:$GOPATH/bin:/Applications/Postgres.app/Contents/MacOS/bin:/usr/texbin:/usr/X11R6/bin:/usr/local/sbin:/usr/local/bin:$PATH

# paths from /etc/paths.d/ (supposedly slows down iTerm2/Terminal.app
# startup)
# /etc/paths.d/ was moved to /etc/path.d.backup
# export PATH=/usr/texbin:/usr/X11/bin:/usr/local/MacGPG2/bin:$PATH

# eval "$(rbenv init -)"
export RBENV_ROOT=`brew --prefix`/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# SSL certificate fix for ruby
# need to brew install curl-ca-bundle first
export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

# alias hub
if which hub > /dev/null; then eval "$(hub alias -s)"; fi

# zsh completions
for fname in /usr/local/share/zsh/site-functions/*; do
    res=`basename $fname`
    if [[ ! $res =~ '.*(hub|git|hg).*' ]]
    then 
        source $fname
    fi
done

export EDITOR='subl -w'
# export PAGER='vimpager'

export HIVE_HOME=`brew --prefix hive`/libexec

export NLTK_DATA=$HOME/nltk_data

export JAVA_OPTS="-Dfile.encoding=UTF-8 $JAVA_OPTS"
export FINDBUGS_HOME=/usr/local/Cellar/findbugs/2.0.1/libexec

alias c++11='c++ -std=c++11 -stdlib=libc++'
alias lighttable='LTCLI=true /Applications/LightTable.app/Contents/MacOS/node-webkit'
