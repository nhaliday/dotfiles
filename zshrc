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
plugins=(npm heroku brew git python pip zsh-syntax-highlighting gem ruby rbenv osx)

setopt extendedglob

source $ZSH/oh-my-zsh.sh

# add completion for hub for GitHub
source /usr/local/share/zsh/site-functions/_hub

# my go packages
export GOPATH=$HOME/go
# shouldn't need this but gocode needs it
# export GOROOT=`brew --prefix go`
# go cmdline completion
source `brew --prefix go`/misc/zsh/go

# Customize to your needs...
export PATH=$HOME/bin:$GOPATH/bin:$HOME/.cabal/bin:/usr/texbin:/usr/local/share/python:/usr/local/share/python3:/usr/X11R6/bin:/usr/local/sbin:/usr/local/bin:$PATH

# paths from /etc/paths.d/ (supposedly slows down iTerm2/Terminal.app
# startup)
# /etc/paths.d/ was moved to /etc/path.d.backup
# export PATH=/usr/texbin:/usr/X11/bin:/usr/local/MacGPG2/bin:$PATH

eval "$(rbenv init -)"
eval "$(hub alias -s)"

source /usr/local/share/python/virtualenvwrapper.sh

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/src

export EDITOR='subl -w'

export JAVA_OPTS="-Dfile.encoding=UTF-8"
export FINDBUGS_HOME=/usr/local/Cellar/findbugs/2.0.1/libexec
