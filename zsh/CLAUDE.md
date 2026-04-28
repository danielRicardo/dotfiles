# CLAUDE.md — zsh/

Zsh configuration. Stowed via `stow zsh` from the repo root, which links:

- `zsh/.zshrc` -> `~/.zshrc`
- `zsh/functions` -> `~/functions` (sourced by `.zshrc` via `$DOTFILES/zsh/functions`)
- `zsh/.oh-my-zsh/custom/themes/intheloop.zsh-theme` -> `~/.oh-my-zsh/custom/themes/intheloop.zsh-theme` (vestigial — see Prompt section)

There is no `.zshenv` or `.zprofile` — everything lives in `.zshrc`.

## Files

| File | Purpose |
|------|---------|
| `.zshrc` | Single entry point: PATH, env vars, Oh My Zsh bootstrap, plugins, aliases, history, keybindings, tool init. |
| `functions` | Standalone shell functions, sourced near the end of `.zshrc`. |
| `.oh-my-zsh/custom/themes/intheloop.zsh-theme` | Old custom OMZ theme. No longer loaded — kept in tree for reference. See Prompt section. |

## Organization of `.zshrc`

Top-to-bottom structure (no separate aliases/env files — everything is inline):

1. **PATH manipulation** (lines ~1-26): prepends `$HOME/bin`, appends `/usr/local/bin`, fzf, Android platform-tools, `~/.local/bin`, RVM, Coursier, jenv, npm global prefix (`$HOME/.npm-packages`). Calls `eval "$(/opt/homebrew/bin/brew shellenv)"`. Deduped with `typeset -U PATH`.
2. **Env vars**: `XDG_CONFIG_HOME=~/.config`, `DOTFILES=~/workspace/dotfiles`, `ZSH=~/.oh-my-zsh`.
3. **Oh My Zsh config**: `ZSH_THEME=""` (OMZ prompt disabled — Starship handles the prompt; see Prompt section), plugin list, then `source $ZSH/oh-my-zsh.sh`.
4. **Aliases** (lines ~111-142): inline, not in a separate file.
5. **History settings** (lines ~152-156): see root CLAUDE.md.
6. **Keybindings & completion**: `^E` to edit command in `$EDITOR`, hjkl in completion menus, `compinit`.
7. **Tool init at the bottom**: `pyenv`, `jenv`, `starship`, `fzf`, `ssh-agent`, AppsFlyer-internal `af_scripts`.
8. **Functions sourced** via `source $DOTFILES/zsh/functions`.

## Plugin manager and plugins

Oh My Zsh. Plugin list (lines 69-87 of `.zshrc`):

```
common-aliases docker extract fzf git gitignore jira mvn kubectl
sbt timer tmux vi-mode vscode zsh-autosuggestions z zsh-syntax-highlighting
```

Most are bundled with OMZ; `zsh-autosuggestions` and `zsh-syntax-highlighting` need to be installed into `$ZSH_CUSTOM/plugins/` separately.

## Prompt / theme

**Starship is the only active prompt.** `ZSH_THEME=""` disables Oh My Zsh's prompt machinery, and `eval "$(starship init zsh)"` runs at the bottom of `.zshrc`. To change the prompt, edit Starship config (`~/.config/starship.toml` if present) — do not re-enable the OMZ theme. The `intheloop.zsh-theme` file is left in tree but not loaded.

## Notable aliases

- `v` / `vim` -> `nvim` (with fallback to `vim`)
- `dot` -> `stow -d $DOTFILES -t $HOME` (run any stow command rooted at this repo)
- `ohmyzsh` -> `nvim ~/.oh-my-zsh`
- `ls` -> `exa --group-directories-first --git` if exa is installed, otherwise `ls --color=auto --group-directories-first`
- `ll` -> `ls -lah`
- glab MR helpers: `gmcf` (create MR, fill from commits), `gmvw` (view MR in browser), `grvw` (view repo in browser). These are zsh shell aliases — `glab-cli/.config/glab-cli/config.yml` does not define glab-internal aliases of the same names.

## Functions (`zsh/functions`)

Small file, four functions:

- `work` — fzf-pick a directory in `~/workspace` and `tat` (tmux attach) into it.
- `gs` — fzf-pick a git branch and `git switch` to it.
- `java8` / `java17` — set `JAVA_HOME` via `/usr/libexec/java_home -v <ver>` and prepend to PATH. `java8` is called at the bottom so the shell starts with Java 8 active. (Note: `jenv` is also initialized in `.zshrc`, so these coexist; the `java*` functions take precedence at startup.)

## External tools sourced / initialized

- `pyenv init --path` (conditional on `pyenv` being on PATH)
- `jenv init -`
- `starship init zsh`
- `fzf` via `~/.fzf.zsh` (sourced once, at the bottom alongside the other tool-init lines)
- `ssh-agent` — started if not already running, key `~/.ssh/id_ed25519` added; agent env cached in `~/.ssh/agent.env`
- AppsFlyer `af_scripts` and `~/.af_funcs/*` — only sourced when `~/bin/af_scripts` exists; includes `autorun_vault.sh`

No `zoxide`, `direnv`, or `asdf` here. Directory jumping uses the OMZ `z` plugin.

## Vi-mode

`vi-mode` plugin enabled with `VI_MODE_SET_CURSOR=true`. Completion menu uses `hjkl` for navigation (zstyle bindings near line 173).

## Modifying configs

- After editing `.zshrc` or `functions`: `exec zsh` (or `source ~/.zshrc`) to reload.
- After re-stowing or first-time setup: `stow zsh` from the repo root.
- Adding aliases/env vars: keep them inline in `.zshrc` to match the existing style; there is no separate aliases file.
- Adding functions: append to `zsh/functions` rather than `.zshrc`.
