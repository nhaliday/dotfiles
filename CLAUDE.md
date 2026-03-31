# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Personal macOS dotfiles repo. Two provisioning mechanisms exist:
- **Ansible (current):** `cd ansible && ./playbook.yml` (the shebang runs `ansible-playbook --ask-become-pass`)
- **install.sh (legacy, out of date):** Bash script kept for reference but no longer maintained

## Key Commands

```bash
# Run the full Ansible playbook (must be in ansible/ dir)
cd ansible && ./playbook.yml

# Install Homebrew packages
brew bundle install --no-lock

# Lint Ansible
ansible-lint ansible/
yamllint ansible/

# Lint Neovim config
luacheck config/nvim/
```

## Repo Layout

Configs are deployed two ways:
- **`config/`** — items here are symlinked into `~/.config/` by the Ansible `config.yml` task using GNU stow for automatic tree folding.
- **`zsh/`, `vim/`, `hammerspoon/`** — historically deployed via GNU Stow (`stow --target=$HOME <dir>`), which symlinks dotfiles (`.zshrc`, `.vimrc`, `.hammerspoon/`) into `$HOME`

### Ansible structure

```
ansible/
  playbook.yml              # entrypoint — runs locally on localhost
  roles/nick_mac/tasks/
    main.yml                 # imports basic_settings.yml and config.yml
    basic_settings.yml       # Fish shell setup (add to /etc/shells, chsh)
    config.yml               # Symlinks config/ items into ~/.config
```

### Config files

| Path | Purpose |
|------|---------|
| `config/nvim/init.lua` | Neovim config (single-file) |
| `config/fish/config.fish` | Fish shell config |
| `config/starship.toml` | Starship prompt config |
| `config/luacheck/` | Luacheck settings |
| `Brewfile` | Homebrew packages, casks, Mac App Store apps, VS Code extensions |

## Shell

The default shell is **Fish** (`/opt/homebrew/bin/fish`), set via Ansible. Zsh config exists but Fish is primary.
