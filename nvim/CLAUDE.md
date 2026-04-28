# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A LazyVim-based Neovim configuration. The actual config lives at `nvim/.config/nvim/` inside the [dotfiles repo](../../../CLAUDE.md) and is symlinked to `~/.config/nvim/` via `stow nvim` (run from the repo root). Editing files here updates the live config — no copy step.

## Architecture

- `init.lua` only bootstraps `config.lazy`. All real wiring is under `lua/`.
- `lua/config/lazy.lua` clones lazy.nvim, then `require("lazy").setup{}` imports both `lazyvim.plugins` (the LazyVim base distro) and the local `plugins` directory. Custom plugins default to `lazy = false` (load at startup); LazyVim plugins remain lazy-loaded.
- `lua/config/{options,keymaps,autocmds}.lua` — the LazyVim convention for user overrides. Loaded automatically on `VeryLazy`.
- `lua/plugins/*.lua` — every file is auto-loaded by lazy.nvim and must return a plugin spec (or list of specs). Use these to add plugins, override LazyVim plugin opts, or disable plugins with `enabled = false`.
- `lazyvim.json` — managed by `:LazyExtras`, tracks which LazyVim extras are enabled. Edit via the picker, not by hand.
- `lazy-lock.json` — plugin version lockfile. Bump with `:Lazy update`.
- `.neoconf.json` — enables neodev so editing Lua plugin code gets Neovim API completions in lua_ls.

## Conventions

**Prefer LazyVim extras over hand-rolled plugin specs.** Before adding a plugin to `lua/plugins/`, check whether a `lazyvim.plugins.extras.*` entry already covers it (`:LazyExtras`) and enable that instead. Only write a custom spec when no extra exists or when the extra needs overrides.

**`lua/plugins/example.lua`** is the LazyVim starter sample (`if true then return {} end` stub). Do not add real plugins to it — make a new file named after the topic (`clojure.lua`, `scala.lua`, etc.) and return the spec from there.

**`lua/plugins/gitlab.lua`** intentionally returns `{}` — the gitlab.nvim spec is kept in the file but not exported. To re-enable, change the trailing `return {}` to `return { gitlab }`.

## Common tasks

```sh
# Format Lua (stylua.toml: 2 spaces, 120 col width)
stylua .

# In nvim, manage the install
:Lazy           # plugin manager UI (sync, update, clean, profile)
:LazyExtras     # toggle LazyVim extras (writes lazyvim.json)
:Mason          # manage LSPs / linters / formatters
:checkhealth    # diagnose plugin/runtime issues
```

There is no test suite for this config.

## Notable wiring

- **Tmux pane navigation** — `<C-h/j/k/l>` bindings in `lua/config/keymaps.lua` and `lua/plugins/tmux.lua` move seamlessly between nvim splits and tmux panes via `nvim-tmux-navigation`. Both files set the same keymaps; the keymaps.lua version runs earlier.
- **Markdown linting** — `lua/plugins/markdown.lua` patches `markdownlint-cli2`'s `args` to manually resolve the nearest `.markdownlint*` config upward from the buffer's directory, falling back to `~/.markdownlint-cli2.jsonc`. Reason: nvim-lint pipes the buffer over stdin, and in stdin mode markdownlint-cli2 does not walk parents looking for config. Don't "simplify" this back to the default args.
- **Scala** — `lua/plugins/scala.lua` enables nvim-metals' MCP server (`startMcpServer = true`).
- **Clojure** — `lua/plugins/clojure.lua` adds vim-jack-in (with vim-dispatch) and tpope's sexp mappings on top of the LazyVim Clojure extra.
