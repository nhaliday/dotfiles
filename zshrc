#!/usr/bin/env zsh

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

ZSH_THEME="blinks"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(npm heroku brew git python pip zsh-syntax-highlighting osx rbenv gem)

setopt extendedglob

source $ZSH/oh-my-zsh.sh

# my go packages
export GOPATH=$HOME/go
# shouldn't need this but gocode needs it
export GOROOT=`brew --prefix go`

# Customize to your needs...
export PATH=$HOME/bin:$HOME/.cabal/bin:$HOME/Applications/factor:$GOPATH/bin:/Applications/Postgres.app/Contents/MacOS/bin:/usr/texbin:/usr/local/share/python:/usr/local/share/python3:/usr/local/share/npm/bin:/usr/X11R6/bin:/usr/local/sbin:/usr/local/bin:$PATH

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
    if [[ ! $res =~ '.*(hub|git|hg).*' ]]; then source $fname; fi
done

export EDITOR='subl -w'
# export PAGER='vimpager'

export HIVE_HOME=`brew --prefix hive`/libexec

export JAVA_OPTS="-Dfile.encoding=UTF-8 $JAVA_OPTS"
export FINDBUGS_HOME=/usr/local/Cellar/findbugs/2.0.1/libexec

alias c++11='c++ -std=c++11 -stdlib=libc++'
alias lighttable='LTCLI=true /Applications/LightTable.app/Contents/MacOS/node-webkit'
