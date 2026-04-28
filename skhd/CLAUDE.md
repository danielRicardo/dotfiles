# skhd

[skhd](https://github.com/koekeishiya/skhd) is a simple hotkey daemon for macOS, paired with yabai to drive the keyboard-only tiling workflow. The yabai bindings live in this config; see `../yabai/` for window manager rules and signals.

## Layout

- `.config/skhd/skhdrc` — the only config file. skhd reads `~/.config/skhd/skhdrc` on launch.

Symlinked into `~/` via GNU Stow:

```sh
stow skhd   # from repo root
```

## Modifier conventions

Two modifier aliases dominate the file:

- `hyper` — `shift + cmd + alt + ctrl` (typically remapped onto a single physical key via Karabiner; see `../karabiner/`).
- `meh`   — `shift + alt + ctrl` (hyper minus cmd).
- `cmd + ctrl` — used only for plain hjkl focus navigation.

Rough split: `meh` drives window/space manipulation, `hyper` drives app launchers, space switching, and service control.

## Binding categories

All action bindings shell out to `yabai -m ...`.

- **Focus navigation** — `cmd + ctrl + h/j/k/l` focuses the window in that direction.
- **Window swap / warp** — `meh + h/j/k/l` swaps; `meh + y/u/i/o` warps.
- **Resize / layout** — `meh + [` / `meh + ]` resize horizontally (key codes `0x21` / `0x1E`); `meh + e` balances the space; `meh + s` toggles split orientation; `meh + r` rotates the tree 90 degrees; `hyper + 4` / `hyper + 6` mirror the tree on the y/x axis; `meh + f` toggles zoom-fullscreen.
- **Window lifecycle** — `meh + backspace` closes the focused window; `meh + m` minimizes it.
- **Display targeting** — `meh + 1/2/3` sends the window to that display and follows focus; `meh + shift + 9/0` invokes `moveWindowAndFollowFocus.sh` from `~/.config/yabai/scripts/` to move left/right between displays.
- **Spaces (workspaces)** — `hyper + 5/6/7/8` focuses spaces 1–4; `meh + 5/6/7/8` sends the window to that space and follows focus. Note: `hyper + 6` is reused for "mirror x-axis" — last definition in the file wins, so it currently mirrors rather than focusing space 2.
- **App launchers** — `hyper +` letter keys open GUI apps via `open -a`. Covers terminal, browsers, chat (Slack, WhatsApp), notes (Logseq, Notion), media (Spotify), dev tools (Cursor, DBeaver), and auth (Authy). Edit the `# App launchers` block when adding a new app.
- **Service control** — `hyper + r` runs `yabai --restart-service` (handy after editing `../yabai/yabairc`).

There are no chord/mode bindings (no `:: mode` blocks); every binding is a single chord.

## Caveats

- Several blocks are commented out (alternate moving/resizing/display-focus bindings). Prefer reusing those slots over inventing new modifier combinations.
- The `moveWindowAndFollowFocus.sh` path is hardcoded to `/Users/danielricardo/.config/yabai/scripts/` (no dot in the username). If the active username differs, those two bindings will silently fail — fix the path rather than working around it.
- Duplicate binding for `hyper + 6` (see Spaces above) — collapse or reassign before adding more space bindings.

## After editing

skhd does not hot-reload. Apply changes with:

```sh
skhd --restart-service
```
