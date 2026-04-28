# alacritty/

Alacritty terminal emulator config. Stowed via `stow alacritty` from the repo root, which links `alacritty/.config/alacritty/` to `~/.config/alacritty/`.

## Layout

```
.config/alacritty/
  alacritty.toml      # active config (entry point)
  alacritty.yml       # legacy YAML config, no longer read by Alacritty (kept for reference)
  keybindings.toml    # all [[keyboard.bindings]] extracted out
  themes/             # one .toml per color scheme
```

Only `alacritty.toml` is loaded directly; the other files are pulled in through `general.import` or are leftovers.

## alacritty.toml

Entry point. Notable choices:

- Shell: `/bin/zsh`
- Font: `JetBrainsMono Nerd Font`, size 21, Medium weight (Bold for bold)
- `font.offset.y = 1` to nudge vertical centering
- `window.decorations = "none"` (frameless), 6px padding on both axes
- `cursor.style.shape = "Beam"`, no blink; vi-mode cursor is a Block
- `TERM = "xterm-256color"`
- `scrolling.history = 10000`
- `general.live_config_reload = true` — edits apply without restart

Imports (in `[general]`):

```toml
import = [
  "~/.config/alacritty/themes/github-dimmed.toml",
  "~/.config/alacritty/keybindings.toml",
]
```

Switch themes by changing the first import path. All theme files use the same shape (`[colors.primary]`, `[colors.normal]`, `[colors.bright]`, optionally `[colors.cursor]` / `[colors.selection]` / `[colors.search.*]`), so swapping one for another is safe.

There is also one inline binding kept directly in `alacritty.toml`:

```toml
[[keyboard.bindings]]
key = "Return"
mods = "Shift"
chars = "[13;2u"
```

This emits the CSI-u encoded sequence for Shift+Enter so Neovim and other CSI-u-aware programs can distinguish it from a plain Enter. Don't move this into `keybindings.toml` without verifying — it's intentionally separate.

## keybindings.toml

Holds every `[[keyboard.bindings]]` block. Two groups:

1. Vi-mode bindings (`mode = "Vi|~Search"`) — replicates Vim motions: `hjkl`, `b/w/e`, `B/W/E` (word vs. semantic), `H/M/L` (high/mid/low), `0` / `$` / `^`, `gg` / `G`, `Ctrl-u/d/b/f`, `/` and `?` for search, `n/N`, `y` to yank, `v/V/Ctrl-v/Alt-v` for selection modes, `Enter` to open links. `Ctrl-Shift-Space` toggles vi-mode; `i` or `Ctrl-c` exits.
2. macOS app-style bindings — `Cmd-C/V`, `Cmd-+/-/0` for font size, `Cmd-K` clears history, `Cmd-Q` and `Cmd-W` quit, `Cmd-N` spawns a new instance, `Cmd-F` / `Cmd-B` search forward/back, `Cmd-Ctrl-F` toggles fullscreen.

Add new bindings here, not in `alacritty.toml`.

## themes/

Drop-in color schemes, all in TOML with the `[colors.*]` shape Alacritty expects. Currently bundled:

- doom-one, dracula, github-dark, github-dimmed (active), github-dimmed
- gruvbox-dark, monokai-pro, nord, oceanic-next, palenight
- solarized-dark, solarized-light, tomorrow-night

To add a theme: drop `themes/<name>.toml` defining at minimum `[colors.primary]`, `[colors.normal]`, `[colors.bright]`, then point the import in `alacritty.toml` at it.

## Notes / gotchas

- `alacritty.yml` is the old YAML format Alacritty dropped support for. It is not loaded; treat it as historical reference only. Edits to it have no effect.
- `tmux-client-*.log` files in the package root are stray tmux client logs and not config — safe to delete, do not stow.
- Because `live_config_reload` is on, you can iterate on `alacritty.toml`, `keybindings.toml`, or the imported theme without relaunching the terminal.
- Font size 21 is tuned for the user's display — change `font.size` in `alacritty.toml` if working on a different machine.
