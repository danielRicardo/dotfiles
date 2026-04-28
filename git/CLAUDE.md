# CLAUDE.md (git/)

Folder-scoped notes for the git config package. The repo-level `CLAUDE.md` already covers the multi-account setup, the nvim diff tool, and git-secrets at a high level — this file documents the actual contents of the package.

## What this folder configures

Provides the user's global git configuration. Stowed into `~/.config/git/`, which git reads as `XDG_CONFIG_HOME/git/` (no `~/.gitconfig` is used).

```sh
stow git    # links git/.config/git/ -> ~/.config/git/
```

## Files

- `.config/git/config` — global git config (identity, aliases, diff tool, secrets patterns, URL rewrite, pull policy, conditional includes).
- `.config/git/config-work` — included when the current repo has an AppsFlyer GitLab remote. Overrides `user.email` to `daniel.ricardo@appsflyer.com`. Minimal `[user]` block only.
- `.config/git/ignore` — global gitignore. Currently excludes `**/.claude/settings.local.json` so per-project Claude Code local settings never get committed.

The top-level identity is the personal one (`daniel.k.ricardo@gmail.com`). Work identity is layered on via `includeIf` (see "Multi-account setup" below). The `[github]` and `[gitlab]` sections are informational metadata, not active overrides. No commit-signing config and no hooks defined here.

## Aliases

- `git unstage <path>` — `reset HEAD --`, unstages files.
- `git ignore <lang>` — fetches a `.gitignore` from `toptal.com/developers/gitignore/api/<lang>` via curl. Usage: `git ignore python,node >> .gitignore`.

## Notable patterns

- **Editor**: `core.editor = nvim`.
- **Diff tool**: `diff.tool = nvimdiff`, runs `nvim -d "$LOCAL" "$REMOTE"`. `difftool.prompt = true` (confirm before each file).
- **Pull policy**: `pull.ff = only` — refuses non-fast-forward pulls; rebase or merge explicitly.
- **URL rewrite**: `https://gitlab.appsflyer.com` is rewritten to `git@gitlab.appsflyer.com:`, forcing SSH for AppsFlyer GitLab clones regardless of how the URL was given.
- **git-secrets**: the `[secrets]` block defines AWS-related patterns (access keys, account IDs, secret keys) and two AWS doc-example values in `allowed`. These are read by the `git-secrets` tool (installed via Homebrew); pre-commit/commit-msg hooks must be installed per-repo with `git secrets --install` — this config alone does not block commits.

## Multi-account setup

Two `includeIf` blocks at the bottom of `config` layer `config-work` on top whenever the current repo has a remote pointing at `gitlab.appsflyer.com`:

```
[includeIf "hasconfig:remote.*.url:git@gitlab.appsflyer.com:*/**"]
  path = ~/.config/git/config-work
[includeIf "hasconfig:remote.*.url:https://gitlab.appsflyer.com/**"]
  path = ~/.config/git/config-work
```

Two blocks (not one with alternation) because git's `wildmatch` doesn't expand `**` across the `:` separator in SSH URLs — the patterns are split by protocol on purpose. Don't collapse them.

URL-based matching is used instead of `gitdir:` because `~/workspace/` mixes work and personal repos with no directory boundary to split on. The match is purely on remote URLs, so cloning location doesn't matter.

To verify: in a work repo, `git config user.email` should return `daniel.ricardo@appsflyer.com`; in a personal repo it stays on `daniel.k.ricardo@gmail.com`.

## When modifying

- Adding another identity (e.g. a second work account): create a new `config-<name>` file alongside `config-work` and add a matching `includeIf` block. Match on remote URL (`hasconfig:remote.*.url:...`) rather than `gitdir:` to stay consistent with the existing setup.
- Adding alias: keep shell-function aliases (like `ignore`) in the `!fn() { ... ;}; fn` form so arguments pass through.
- Global ignore additions go in `.config/git/ignore`, one pattern per line.
