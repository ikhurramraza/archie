# archie

Personal dotfiles, managed with [chezmoi](https://chezmoi.io). The source
state lives under `home/` (selected by `.chezmoiroot`), so the repo root
stays free for tooling files. chezmoi copies files into `$HOME` — nothing is
symlinked.

The repo lives at `~/Developer/archie`, and `home/.chezmoi.toml.tmpl` points
chezmoi's `sourceDir` at it — no symlink into `~/.local/share/chezmoi`
required.

## Bootstrap (new machine)

```sh
sudo dnf install chezmoi        # brew install chezmoi on macOS
git clone git@github.com:ikhurramraza/archie.git ~/Developer/archie
chezmoi init --source=~/Developer/archie
chezmoi diff                    # review what would change
chezmoi apply
```

## Config

`home/.chezmoi.toml.tmpl` is chezmoi's own config, rendered into
`~/.config/chezmoi/chezmoi.toml` by `chezmoi init`. It sets `sourceDir`, pipes
`chezmoi diff` through `delta`, and points three-way merges at `nvim -d`.

`chezmoi apply` does **not** regenerate it — after editing the template, re-run
`chezmoi init`. Machines still using the old `~/.local/share/chezmoi` symlink
need that one `chezmoi init` too; the symlink can be removed afterwards.

## Daily workflow

- Edit files in the repo (or `chezmoi edit <target>`), then `chezmoi apply`.
- Unlike the old stow setup, edits made *in `$HOME`* no longer reflect back
  into the repo. When a tool rewrites a managed file — notably
  `~/.config/nvim/lazy-lock.json` after `:Lazy update` — pull it back with:

  ```sh
  chezmoi re-add ~/.config/nvim/lazy-lock.json
  ```

- Drift check: `chezmoi status` (empty means converged) or `chezmoi verify`.
- Pull + apply in one step on other machines: `chezmoi update`.

## Externals

Declared in `home/.chezmoiexternal.toml`:

- **oh-my-zsh** — git-repo, auto-pulled at most weekly.
- **bol** — git-repo, never auto-pulled (it's my own plugin; update with
  `git -C ~/.config/zsh/oh-my-zsh-custom/plugins/bol pull`).
- **friendly-snippets** (`~/.config/nvim/sneaps`) — archive pinned to an
  exact commit; bump by editing the URL.

Force a refresh regardless of `refreshPeriod` with `chezmoi apply -R`.

## WSL extras

Two `run_onchange` scripts in `home/.chezmoiscripts/` copy configs to the
Windows side (skipped everywhere else):

- `home/mpvnet/` → `%APPDATA%/mpv.net`
- `home/windows-terminal/settings.json` → Windows Terminal's `LocalState`

They re-run automatically when the source files change.

## Host overrides

Machine-specific zsh config lives in `~/.config/zsh/overrides` (unmanaged,
sourced by `dot_zshrc` when present). Use it for secrets, host aliases, and
anything that shouldn't be committed. Keep it at `chmod 600` since it may
contain credentials.

## Pre-commit hooks

Defined in `lefthook.yml`. After cloning, run:

```sh
lefthook install
```

The hooks enforce:

- `shfmt -i=2 -d` on staged shell scripts under `home/dot_config/zsh/`,
  `home/dot_config/tmux/scripts/`, and `home/dot_local/scripts/`.
- `stylua --check` on staged `*.lua`, using
  `home/dot_config/stylua/stylua.toml`.

## Dependencies

- `chezmoi` — the dotfile manager.
- `lefthook` — git hook runner.
- `shfmt` and `stylua` — format checks in the pre-commit hook.
