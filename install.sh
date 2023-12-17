#!/usr/bin/env bash

# NOTE!: This is out of date. I am planning on using Ansible instead of Bash.

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

[[ -f /opt/homebrew/bin/brew ]] || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Be lenient on brew failures.
brew bundle install --no-lock || true

[[ -x $HOME/.cargo/bin/rustup ]] || rustup-init -y
rustup component add rust-analyzer

opam init --shell=fish --auto-setup
opam install dune ocaml-lsp-server odoc ocamlformat utop

sudo ln -sfn "$(brew --prefix)/opt/openjdk/libexec/openjdk.jdk" /Library/Java/JavaVirtualMachines/openjdk.jdk

stow --target=$HOME zsh
stow --target=$HOME/.config config
stow --targe=$HOME hammerspoon vim

yes | "$(brew --prefix)/opt/fzf/install"

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugUpgrade +PlugInstall +PlugUpdate +qall

nvim +PaqSync +qall

# DO: Install Cisco AnyConnect proxy

popd
