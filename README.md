# archie

Personal dotfiles, managed with [chezmoi](https://chezmoi.io). Source state
lives under `home/`; files are copied into `$HOME`, not symlinked.

## Bootstrap

```sh
sudo dnf install chezmoi        # brew install chezmoi on macOS
git clone git@github.com:ikhurramraza/archie.git ~/Developer/archie
chezmoi init --source=~/Developer/archie
chezmoi diff && chezmoi apply
lefthook install
```

## Machines

`chezmoi init` asks once for a machine profile — `personal`, `breathe`,
`doctolib`, `cov` or `dort` — and records it as `.profile`. Templates and
`home/.chezmoiignore` branch on it, so a machine only gets what its profile
lists: `~/.ssh/box` is deployed on `personal`, `cov` and `dort` only.

Secrets come from 1Password at apply time via `onepasswordRead`, so `op` must be
installed and signed in. On WSL that means the Windows `op.exe` reached through
interop; `home/.chezmoi.toml.tmpl` picks the right binary.

## Gotchas

- Edits in `$HOME` do not flow back. When a tool rewrites a managed file — e.g.
  `~/.config/nvim/lazy-lock.json` after `:Lazy update` — run `chezmoi re-add
  <path>`.
- `chezmoi apply` never regenerates chezmoi's own config. Re-run `chezmoi init`
  after editing `home/.chezmoi.toml.tmpl`.
- tmux plugins are chezmoi externals, so don't use tpm's `prefix+I` /
  `prefix+U` — they pull behind chezmoi's back.
- Machine-specific zsh config goes in `~/.config/zsh/overrides`: unmanaged,
  `chmod 600`, may hold secrets.
