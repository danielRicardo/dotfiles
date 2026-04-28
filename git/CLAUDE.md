# CLAUDE.md (git/)

Folder-scoped notes for the git config package. The repo-level `CLAUDE.md` already covers the multi-account setup, the nvim diff tool, and git-secrets at a high level — this file documents the actual contents of the package.

## What this folder configures

Provides the user's global git configuration. Stowed into `~/.config/git/`, which git reads as `XDG_CONFIG_HOME/git/` (no `~/.gitconfig` is used).

```sh
stow git    # links git/.config/git/ -> ~/.config/git/
```

## Files

- `.config/git/config` — global git config (identity, aliases, diff tool, secrets patterns, URL rewrite, pull policy).
- `.config/git/ignore` — global gitignore. Currently excludes `**/.claude/settings.local.json` so per-project Claude Code local settings never get committed.

There are no conditional includes (`includeIf`), no commit-signing config, and no hooks defined here. Identity is a single global identity (`daniel.k.ricardo@gmail.com`); the `[github]` and `[gitlab]` sections are informational metadata, not active overrides — if per-repo work identity is needed, configure it locally in the work repo or add an `includeIf` block.

## Aliases

- `git unstage <path>` — `reset HEAD --`, unstages files.
- `git ignore <lang>` — fetches a `.gitignore` from `toptal.com/developers/gitignore/api/<lang>` via curl. Usage: `git ignore python,node >> .gitignore`.

## Notable patterns

- **Editor**: `core.editor = nvim`.
- **Diff tool**: `diff.tool = nvimdiff`, runs `nvim -d "$LOCAL" "$REMOTE"`. `difftool.prompt = true` (confirm before each file).
- **Pull policy**: `pull.ff = only` — refuses non-fast-forward pulls; rebase or merge explicitly.
- **URL rewrite**: `https://gitlab.appsflyer.com` is rewritten to `git@gitlab.appsflyer.com:`, forcing SSH for AppsFlyer GitLab clones regardless of how the URL was given.
- **git-secrets**: the `[secrets]` block defines AWS-related patterns (access keys, account IDs, secret keys) and two AWS doc-example values in `allowed`. These are read by the `git-secrets` tool (installed via Homebrew); pre-commit/commit-msg hooks must be installed per-repo with `git secrets --install` — this config alone does not block commits.

## When modifying

- Adding a work identity: prefer `[includeIf "gitdir:~/workspace/appsflyer/"]` with a separate file rather than editing the top-level `[user]`, to keep personal commits attributed correctly.
- Adding alias: keep shell-function aliases (like `ignore`) in the `!fn() { ... ;}; fn` form so arguments pass through.
- Global ignore additions go in `.config/git/ignore`, one pattern per line.
