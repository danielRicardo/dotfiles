# CLAUDE.md — yabai

Folder-scoped notes for the yabai window manager config. See the repo root `CLAUDE.md` for the high-level summary.

## Overview

[yabai](https://github.com/koekeishiya/yabai) is a tiling window manager for macOS that uses the Accessibility API plus an optional scripting addition (SA) for advanced features. This config runs against macOS with **SIP enabled** — features that require SIP to be disabled (window borders, window opacity) are commented out and left as reference.

Hotkeys are not defined here; they live in `skhd/.config/skhd/skhdrc`. This folder only holds layout, rules, and helper scripts.

## Files

- `.config/yabai/yabairc` — main config, executed on yabai startup. Marked executable.
- `.config/yabai/scripts/getWindowId.sh` — looks up a window id by app name (regex match via `$1`, or interactive `fzf` picker if no arg). Requires `jq` and `fzf`.
- `.config/yabai/scripts/moveWindowAndFollowFocus.sh` — moves the focused window to the prev/next display and re-focuses it there. Usage: `moveWindowAndFollowFocus.sh -l` or `-r`. Wraps around (`prev || last`, `next || first`).

## yabairc breakdown

**Layout / global**
- `layout bsp` — binary space partitioning
- `window_placement second_child` — new windows open as the second child of the split
- `split_ratio 0.50`, `auto_balance off`
- `window_shadow on`
- `insert_feedback_color 0xffd75f5f` — red insertion indicator

**Padding / gaps**
- `top/bottom/left/right_padding 12`
- `window_gap 06`

(The root `CLAUDE.md` says "12px gaps" — that refers to outer padding; inner window gap is actually `06`.)

**Mouse**
- `mouse_follows_focus off`, `focus_follows_mouse off`
- `mouse_modifier fn` — hold `fn` to drag
- `mouse_action1 move`, `mouse_action2 resize`, `mouse_drop_action swap`

**App rules** (all in `yabairc`, unmanaged / floating)
- Sticky + above + unmanaged: System Preferences, Finder, Disk Utility, System Information, Activity Monitor, Authy, Picture-in-Picture (matched by title)
- Unmanaged only: Path Finder, Calculator, Todoist
- Unmanaged + above: Archive Utility
- Spotify rule is commented out

**Commented-out / reference sections**
- Scripting addition load (`sudo yabai --load-sa` + `dock_did_restart` signal) — left commented; enable if you need SA features and have configured passwordless sudo.
- Window borders / opacity — both require SIP disabled. The author uses **Limelight** separately for borders; the kill+start lines for it are also commented.

## Service / restart

After editing `yabairc` or rules:

```sh
yabai --restart-service
```

If you change scripts referenced from `skhd`, restart skhd too (`skhd --restart-service`). The scripts in `scripts/` are invoked directly and need no restart, but they must remain executable (`chmod +x`).

## Stow

Symlink from the repo root:

```sh
stow yabai   # links yabai/.config/yabai -> ~/.config/yabai
```

## When modifying

- New floating apps: add a `yabai -m rule --add app="^Name$" manage=off` line in the rules block. Use `yabai -m query --windows` (or `scripts/getWindowId.sh`) to confirm the exact `app` name.
- If you enable any SIP-disabled feature (borders, opacity, SA-only signals), uncomment the relevant block and document the SIP/SA dependency — don't silently turn them on.
- Keep keybindings out of this folder; they belong in `skhd/`.
