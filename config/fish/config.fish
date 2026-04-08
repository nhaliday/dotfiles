fish_add_path /opt/homebrew/sbin /opt/homebrew/bin

[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

command -q starship; and starship init fish | source

# opam configuration
command -q opam; and source $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

set --global --export EDITOR nvim

# Added by LM Studio CLI (lms)
 set -gx PATH $PATH $HOME/.cache/lm-studio/bin

set -gx GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

set -gx PATH $PATH $HOME/.local/bin

# PyPy GC nursery size: suppresses "cannot find your CPU L2 cache size" warning
# on macOS/Apple Silicon (https://github.com/pypy/pypy/issues/4939).
# Value = 1/2 of performance-core cluster L2 (hw.perflevel0.l2cachesize = 16MB).
# Doesn't seem to offer a significant speedup (~8% in one benchmark).
test (uname) = Darwin; and set -gx PYPY_GC_NURSERY 8M
