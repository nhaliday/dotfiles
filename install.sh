#!/usr/bin/env bash

set -eux
DOTFILES_DIR=$(dirname "$(readlink -f "$0")")

pushd "$DOTFILES_DIR"

mkdir -p $HOME/.config $HOME/.vim/plugged $HOME/.vim/autoload $HOME/.vim/backupfiles $HOME/.vim/swapfiles $HOME/.vim/undofiles

# DO: Install Xcode in app store
# Command-line tools
if ! output=$(xcode-select --install || true); then
    # In case where they're already installed, the exit code is 1, but this script doesn't consider that to be an error case, so we work around it.
    if ! echo "$output" | rg 'already installed'; then
       # Fail with the same error
       xcode-select --install
    fi
fi

[[ -f /usr/local/bin/brew ]] || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
# First time I installed the Freedom app cask I had to add an environment variable: https://apple.stackexchange.com/questions/393481/homebrew-cask-download-failure-ssl-certificate-problem-certificate-has-expired
brew bundle install --no-lock

stow --target=$HOME zsh
stow --target=$HOME/.config config
stow --targe=$HOME hammerspoon vim

yes | /usr/local/opt/fzf/install

if ! output=$(yes N | rbenv install 2.7.1 || true); then
	if ! echo "$output" | rg 'already exists'; then
		rbenv install 2.7.1
	fi
fi
rbenv global 2.7.1

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugUpgrade +PlugInstall +PlugUpdate +qall

# DO: Install Cisco AnyConnect proxy
# DO: Copy over ~/Library/Application\ Support/BetterTouchTool

popd
