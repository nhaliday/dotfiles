fish_add_path /opt/homebrew/sbin /opt/homebrew/bin

[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

starship init fish | source

status --is-interactive; and source (rbenv init -|psub)

status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source

# opam configuration
source /Users/nick/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

set --global --export EDITOR nvim

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/nick/.cache/lm-studio/bin

set -gx GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

set -gx PATH $PATH $HOME/.local/bin
