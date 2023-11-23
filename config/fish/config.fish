[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

set -g RUBY_CONFIGURE_OPTS "--with-openssl-dir="(brew --prefix openssl@1.1)

status --is-interactive; and source (rbenv init -|psub)

status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source

source (brew --prefix)/share/google-cloud-sdk/path.fish.inc
