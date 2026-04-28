# My Dotfiles
Nothing fancy here, these are just my dotfiles.
They are still a work in progress, so I wouldn't recommend copying them just yet.

## My toolset
  * Keyboard: [Keebart Corne Choc Pro BT](https://www.keebart.com/products/corne) running [my zmk-config](https://github.com/danielRicardo/zmk-config) + [Karabiner-Elements](https://karabiner-elements.pqrs.org/) for macOS-level remapping (hyper key, complex modifications)
  * Package manager (macOS): [Homebrew](https://brew.sh/)
  * Symlink manager: [GNU Stow](https://www.gnu.org/software/stow/)
  * Shell: [zsh](https://zsh.org) + [Oh My Zsh](https://ohmyz.sh) + [Starship](https://starship.rs/) prompt
  * Terminal: [Alacritty](https://alacritty.org/)
  * Editor: [Neovim](https://neovim.io/) with [LazyVim](https://www.lazyvim.org/)
  * Multiplexer: [tmux](https://github.com/tmux/tmux) with [TPM](https://github.com/tmux-plugins/tpm)-managed plugins
  * Window manager: [yabai](https://github.com/koekeishiya/yabai) (BSP tiling) + [skhd](https://github.com/koekeishiya/skhd) (hotkeys)

## Layout
Each top-level directory mirrors the home directory structure for use with GNU Stow. Running `stow <package>` from the repo root creates symlinks into `~`. For example, `stow nvim` links `nvim/.config/nvim/` → `~/.config/nvim/`.

Most package folders include a `CLAUDE.md` describing what's configured there and how to modify it — useful for [Claude Code](https://claude.com/claude-code) and humans alike.

## Usage
```sh
# Full install from scratch
./init.sh

# Symlink a specific package
stow nvim
stow zsh
stow alacritty

# Or use the legacy linker for .symlink-suffixed files and bin/ executables
./link.sh

# Install Homebrew packages
brew bundle --global   # reads ~/.Brewfile

# Apply macOS system defaults
./apple_setup.sh
```

## Inspiration
  * [nicknisi/dotfiles](https://github.com/nicknisi/dotfiles)
  * [ckipp01/dots](https://github.com/ckipp01/dots)
  * [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles)
