# tmux/

Tmux terminal multiplexer config. Two parallel copies of the same config exist (see "Symlinking" below) — keep them in sync when editing.

## Files

- `tmux.conf.symlink` — legacy copy, linked by `link.sh` to `~/.tmux.conf`.
- `.config/tmux/tmux.conf` — XDG copy, linked by `stow tmux` to `~/.config/tmux/tmux.conf`.
- `tpm_init.sh` — bootstrap script. Creates `~/.tmux/plugins/`, clones TPM if missing, sources the conf. After running, press `prefix + I` inside tmux to install plugins.
- `.config/tmux/plugins/` — runtime install location for TPM and the plugins it manages. **Not committed**: `.gitignore` excludes this whole dir, and each plugin here is its own independent git clone. A fresh machine starts with empty plugin dirs and must run `prefix + I` (TPM) to fetch them.

## Differences between the two confs

The XDG variant (`.config/tmux/tmux.conf`) diverges from `tmux.conf.symlink` in three places — be aware when editing:

- `bind-key r` reloads `~/.config/tmux/tmux.conf` (not `~/.tmux.conf`).
- Adds `set -g default-shell /bin/zsh`.
- Splits use `bind-key h` (vertical) and `bind-key v` (horizontal) instead of `-` and `\`.

## Conventions

- **Prefix** is `C-s` (not the default `C-b`); `C-s C-s` sends a literal `C-s` through.
- **Vi mode** everywhere: `mode-keys vi`, `@shell_mode 'vi'`, copy-mode uses `v` to start selection and `y` / `Enter` to copy via `reattach-to-user-namespace pbcopy` (macOS clipboard).
- **Vim-aware pane navigation**: `C-h/j/k/l` (no prefix) forwards to Vim if `pane_current_command` matches vim/nvim, else moves panes. `C-\` jumps to last pane.
- **Pane resize**: `S-Arrow` for fine (1–2 cells), `C-Arrow` for coarse (5–10 cells), both unprefixed.
- **Windows** are 1-indexed (`base-index 1`) with `renumber-windows on`. `bind c` opens new windows in the current pane's path.
- **Theme** is a hand-rolled GitHub Dimmed status line (colors `#1e2228`, `#6cb6ff`, `#768390`, `#adbac7`). Note: lines 56–61 partially override the earlier status styling — the right side ends up showing Spotify track, battery, CPU, and date via plugin format strings.
- **Pane sync** toggle on `prefix y`.

## Notable custom bindings

- `prefix C-j` — fzf-based session switcher (splits a window, pipes `list-sessions` into fzf, switches client).
- `prefix J` — prompted `join-pane -h` from another window.
- `prefix s` — `display-panes` then prompt for a pane number to swap with current.
- `prefix b` — `break-pane -d` (detach pane into its own window in the background).
- `prefix j` — `choose-tree -s` session picker.
- `prefix K` — kill current session and switch to next without exiting tmux.
- `prefix C-b` — sends `tat; exit` (assumes a `tat` helper is on PATH).
- `prefix p` / `prefix P` — `git push` / `git push -f` of the current branch into the active pane.

## Plugins (TPM)

Declared in the conf; installed at runtime by TPM into `.config/tmux/plugins/` (not committed — see "Files" above):

- `tmux-plugins/tpm` — plugin manager.
- `robhurring/tmux-spotify` — `#{music_status}`, `#{artist}`, `#{track}` for status bar.
- `tmux-plugins/tmux-battery` — `#{battery_icon}`, `#{battery_percentage}`.
- `tmux-plugins/tmux-cpu` — `#{cpu_fg_color}`, `#{cpu_percentage}`.
- `tmux-plugins/tmux-copycat` — regex search in copy mode.
- `tmux-plugins/tmux-sidebar` — tree sidebar.
- `wfxr/tmux-fzf-url` — `prefix u` to open URLs from the visible pane via fzf.
- `tmux-plugins/tmux-resurrect` — save/restore sessions across reboots (`prefix + C-s` save, `prefix + C-r` restore).
- `tmux-plugins/tmux-continuum` — auto-saves every 15 min (builds on resurrect). `@continuum-restore` is intentionally left off, so restore stays manual.

The TPM bootstrap block at the bottom of the conf auto-clones TPM to `~/.tmux/plugins/tpm` if missing. Keep `run -b '~/.tmux/plugins/tpm/tpm'` as the **last line** of the file when editing.

## Symlinking

This folder is wired up two ways — both are active:

1. **Stow** (preferred): `stow tmux` from the repo root links `tmux/.config/tmux/` → `~/.config/tmux/`.
2. **link.sh** (legacy): scans for `*.symlink` files and links `tmux.conf.symlink` → `~/.tmux.conf`.

Tmux reads `~/.tmux.conf` first, then `~/.config/tmux/tmux.conf` if the former is absent. With both linked, `~/.tmux.conf` (legacy) wins. If you only intend to use the XDG path, remove `~/.tmux.conf` and rely on stow.

After editing either conf: `prefix r` reloads, or `tmux source-file <path>` from a shell.
