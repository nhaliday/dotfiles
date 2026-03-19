export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH

source <(starship init zsh)

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
eval "$(rbenv init -)"

eval "$(pyenv init -)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/nick/.cache/lm-studio/bin"
