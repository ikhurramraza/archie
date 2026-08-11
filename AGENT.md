# Working in this repo

## Commit messages

Conventional commits: `type(scope): subject`.

**The scope is the tool whose config changed** — `nvim`, `zsh`, `tmux`, `git`,
`joshuto`, `atuin`, `starship`, `btop`, `mise`, `claude`, `lazygit`, `yt-dlp`.
A scope names a config this repo deploys to `$HOME`, so work on the repo
itself takes no scope. Derive it from the path, not from the file's language
or format:

| Path | Scope |
| --- | --- |
| `home/dot_config/<tool>/**` | `<tool>` |
| `home/dot_zshenv`, `home/dot_config/zsh/**` | `zsh` |
| `home/dot_local/scripts/**` | `scripts` |
| `home/dot_local/share/fonts/**` | `fonts` |
| `home/dot_claude/**` | `claude` |
| `home/mpvnet/**` | `mpvnet` |
| `home/windows-terminal/**` | `windows-terminal` |
| `home/.chezmoi.toml.tmpl`, `.chezmoiroot`, `.chezmoiversion` | `chezmoi` |
| `home/.chezmoiexternal.toml`, `home/.chezmoiignore`, `home/.chezmoiscripts/**` | the payload's |
| `lefthook.yml`, `hooks/**`, README, AGENT.md, repo layout, tree-wide moves | no scope |

A helper script nested under a tool takes that tool's scope, not its own name:
`home/dot_config/tmux/scripts/notie` is `tmux`, not `notie`. A
`.chezmoiscripts/` entry, an external, and an ignore rule all take the scope
of the payload they carry, not `chezmoi`: the mpv OSC external is `mpv`. They
are unscoped when the payload is not a tool's config — the package bootstrap
installs a set, not a config. Only the files configuring chezmoi itself are
`chezmoi`.

`hooks/commit-msg` enforces these rules and derives the expected scope from
the same table, so keep it in step when a config is added or removed. A new
tool under `home/dot_config/` needs nothing — the glob already covers it.
Anything else does: a payload dir beside `mpvnet/`, a new path under
`home/dot_local/`, a repo-internal file at the root. Until its mapping is
added to `scope_for`, commits touching it skip the scope check silently.

**Never scope by language, format, or tooling artifact.** `lua`, `toml`,
`json`, `sh`, `style` are not tools and say nothing about what changed.

One tool per commit. When a change genuinely spans tools, comma-separate
(`fix(atuin,zsh)`, `feat(i3,picom,rofi)`) — but prefer splitting the commit.
Reformatting two unrelated tools' files is two commits, not one.

## Commit types

Pick the type by what the change *does*, not by what it unblocks — config that
trips a linter is not thereby broken.

| Type | Use for |
| --- | --- |
| `feat` | a new capability: keybind, plugin, alias, script |
| `fix` | a real defect — something misbehaved at runtime |
| `refactor` | behaviour-preserving restructure: control flow, extraction, renames |
| `style` | formatting only — indent, whitespace, trailing commas, ordering |
| `perf` | measurably faster, usually shell startup |
| `chore` | version pins, untracking, removing dead config, repo tooling |
| `docs` | README and this file |

The line that matters most in practice is `style` vs `refactor` vs `fix`.
Reindenting a file is `style`; rewriting a loop so it keeps working is
`refactor` even when the diff is small and the motive was a linter; neither is
a `fix` unless the old code actually misbehaved.

`ci` is legacy — it belongs to the pre-chezmoi Makefile era and was last used in
2023. Hook and lint changes are repo-internal, so they take a normal type and
no scope; the `lefthook` scope on three older commits is legacy the same way.

## Comments

See the no-comments rule in `home/dot_claude/CLAUDE.md` — it applies to the
configs in this repo too. Put the reasoning in the commit message instead.
