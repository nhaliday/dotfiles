#!/usr/bin/env bash

set -eux
DOTFILES_DIR=$(dirname "$(readlink -f "$0")")

pushd "$DOTFILES_DIR"

stow --target=$HOME zsh
mkdir -p $HOME/.config
stow --target=$HOME/.config fish

## Xcode
# DO: Install Xcode in app store
# Command-line tools
if ! output=$(xcode-select --install || true); then
    # In case where they're already installed, the exit code is 1, but this script doesn't consider that to be an error case, so we work around it.
    if ! echo $output | rg 'already installed'; then
       # Fail with the same error
       xcode-select --install
    fi
fi

## Homebrew
[[ -f /usr/local/bin/brew ]] || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
# First time I installed the Freedom app cask I had to add an environment variable: https://apple.stackexchange.com/questions/393481/homebrew-cask-download-failure-ssl-certificate-problem-certificate-has-expired
brew bundle install --no-lock

/usr/local/opt/fzf/install

yes N | rbenv install 2.7.1
rbenv global 2.7.1

popd
