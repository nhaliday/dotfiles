fish_add_path /opt/homebrew/sbin /opt/homebrew/bin

[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

# I no longer have this keg installed.
# set -g RUBY_CONFIGURE_OPTS "--with-openssl-dir="(brew --prefix openssl@1.1)

status --is-interactive; and source (rbenv init -|psub)

status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source
