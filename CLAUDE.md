# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal macOS dotfiles. Configured for keyboard-driven workflows using a tiling window manager, Neovim as the primary editor, and Zsh as the primary shell.

## Structure and Symlinking

Each top-level directory (e.g. `nvim/`, `zsh/`, `alacritty/`) mirrors the home directory structure for use with **GNU Stow**. Running `stow <package>` from the repo root creates symlinks into `~`. For example, `stow nvim` links `nvim/.config/nvim/` → `~/.config/nvim/`.

The legacy `link.sh` script handles `.symlink`-suffixed files (creates `~/.<name>`) and links executables from `bin/` to `/usr/local/bin/`.

## Setup Commands

```sh
# Full install from scratch
./init.sh

# Symlink dotfiles (legacy .symlink files + bin/ executables)
./link.sh

# Symlink a specific app config via stow
stow nvim
stow zsh
stow alacritty

# Install all Homebrew packages
brew bundle --global   # reads ~/.Brewfile (stowed from homebrew/.Brewfile)

# Apply macOS system defaults
./apple_setup.sh
```

## Key Configurations

**Shell** — `zsh/.zshrc` and `zsh/functions`. Oh My Zsh with vi-mode, fzf, and 17 plugins. History: 1M entries in `~/.cache/zsh/history`. PATH includes Homebrew, jenv, pyenv, nvm (`n`), Coursier.

**Neovim** — `nvim/.config/nvim/`. Lazy.nvim plugin manager with LazyVim base distribution (`lazyvim.json` tracks enabled extras). Plugin overrides live in `lua/plugins/`. Primary languages: Clojure, Scala, Markdown. The old Vim config in `vim/` uses Vundle and is no longer the primary editor.

**Window management** — `yabai/` (BSP tiling, 6px window gaps, 12px outer padding) + `skhd/` (hotkeys). Vim-style `hjkl` navigation. Workspaces and app launchers bound to hyper-key chords. Changes here require `yabai --restart-service` / `skhd --restart-service`.

**Keyboard remapping** — `karabiner/.config/karabiner/karabiner.json`. Defines hyper key (Shift+Cmd+Alt+Ctrl) and complex modifications for the Redox split keyboard.

**Git** — `git/.config/git/config`. Uses nvim as diff tool, git-secrets enabled for AWS credential pattern detection. Multi-account setup for personal (GitHub) and work (GitLab/AppsFlyer).

**Alacritty** — `alacritty/.config/alacritty/`. JetBrainsMono Nerd Font. Themes stored in `alacritty/.config/alacritty/themes/` and imported via `import` in `alacritty.toml`.

**GitLab CLI** — `glab-cli/.config/glab-cli/config.yml` holds host/auth config for `gitlab.appsflyer.com`. Shell aliases for common glab commands (`gmcf`, `gmvw`, `grvw`) live in `zsh/.zshrc`, not here.
