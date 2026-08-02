# Migrating this machine from stow to chezmoi

**Audience: Claude.** The owner of this repo will ask you to read this file
and perform the migration on the machine you are running on. Follow it top
to bottom. It is fully self-contained — you need no other context.

**What this is:** this repo used to be deployed with GNU Stow + `make`
(symlinks from `$HOME` into the repo). The `chezmoi` branch contains the
same dotfiles restructured for [chezmoi](https://chezmoi.io), which copies
files into `$HOME` instead. This runbook unstows the machine, relocates the
runtime state that stow's directory-folding left *inside* the repo working
tree, and switches to chezmoi. Once every machine has migrated, `chezmoi`
gets merged into `main` and this file is deleted.

**Read this whole file before starting** — step 5 switches branches, which
removes this file from the working tree.

Three checkpoints below require you to **stop and get explicit user
confirmation**. Do not skip them. Report every verification result honestly;
on any failure, stop and go to the Rollback section.

## Preconditions (verify all before touching anything)

```sh
cd ~/Developer/archie
git status                    # must be clean, on main
git pull
git fetch origin chezmoi      # the migration branch must exist on origin
ls ~/.local/share/chezmoi     # must NOT exist (no file, no symlink)
git rev-parse HEAD            # record this as the ROLLBACK REV in your notes
```

Ask the user to close nvim and, where practical, other Claude Code sessions
(live `~/.claude` state is being relocated). Do the whole migration in one
sitting: between step 2 and step 6, newly opened shells run without dotfiles.

## Step 0 — Safety net

Tarball every gitignored runtime file living inside the repo tree:

```sh
cd ~/Developer/archie
git status --ignored --porcelain | sed -n 's/^!! //p' \
  | tar czf ~/archie-state-backup-$(date +%F).tgz -C ~/Developer/archie -T -
tar tzf ~/archie-state-backup-$(date +%F).tgz | wc -l   # sanity: non-zero
```

## Step 1 — Unstow

```sh
make clean
```

This removes only the symlinks in `$HOME`; all data remains in the repo tree.

## Step 2 — Relocate runtime state into real $HOME directories

Stow folded whole directories, so machine state physically lives in the repo.
The mapping is mechanical: a gitignored repo path `<package>/<rest>` belongs
at `~/<rest>`. List what this machine actually has:

```sh
git status --ignored --porcelain | sed -n 's/^!! //p'
```

**Copy (do not move) each entry to its `$HOME` location**, EXCEPT the
deliberate-skip list below. Known sharp edges, with exact commands:

```sh
# ~/.claude is a hybrid: chezmoi-era live files may already exist in $HOME.
# Existing $HOME files must win over repo-side copies.
mkdir -p ~/.claude
rsync -a --ignore-existing --exclude=.gitignore claude/.claude/ ~/.claude/

# GPG keyring: real private keys. rsync -a preserves the 600 modes; fix the dir.
mkdir -p ~/.local/share
rsync -a --exclude=.gitignore gnupg/.local/share/gnupg/ ~/.local/share/gnupg/
chmod 700 ~/.local/share/gnupg

# nvim plugin/runtime state (~280M on some machines)
rsync -a --exclude=.gitignore nvim/.local/share/nvim/ ~/.local/share/nvim/

# tmux plugins (tpm)
mkdir -p ~/.config/tmux
rsync -a tmux/.config/tmux/plugins/ ~/.config/tmux/plugins/

# machine-local zsh secrets (may not exist)
mkdir -p ~/.config/zsh
[ -f zsh/.config/zsh/overrides ] && install -m 600 zsh/.config/zsh/overrides ~/.config/zsh/overrides

# smaller state, if present on this machine:
[ -f mise/.config/mise/config.toml ] && mkdir -p ~/.config/mise && cp mise/.config/mise/config.toml ~/.config/mise/
[ -d zsh/.local/state/less ] && mkdir -p ~/.local/state && rsync -a --exclude=.gitignore zsh/.local/state/less/ ~/.local/state/less/
[ -d docker/.config/docker ] && rsync -a --exclude=.gitignore docker/.config/docker/ ~/.config/docker/
```

Anything else the listing shows (e.g. `lazygit/.config/lazygit/state.yml`,
pgcli/litecli history) — copy it to `~/<rest>` the same way.

**Deliberate-skip list** (do NOT copy):

- `zsh/.config/zsh/.oh-my-zsh/`, `nvim/.config/nvim/sneaps/`,
  `zsh/.config/zsh/oh-my-zsh-custom/plugins/bol/` — old submodule checkouts
  whose `.git` files point into this repo's `.git/modules`; chezmoi clones
  them fresh as externals.
- `*.zwc`, `.zcompdump*` — zsh recompiles these.
- `btop/.config/btop/btop.log` — just a log.

## Step 3 — CHECKPOINT A: verify relocation

```sh
GNUPGHOME=~/.local/share/gnupg gpg -K          # keys listed
ls ~/.claude/ ~/.config/tmux/plugins/ ~/.local/share/nvim/
git status --ignored --porcelain | sed -n 's/^!! //p'
```

Sweep the listing: every entry must now have a `$HOME` copy or be on the
skip list. **Show the user your mapping of what was copied where and what
was skipped, and get confirmation before continuing.** If anything is
unaccounted for, stop and ask.

## Step 4 — Install chezmoi

```sh
sudo dnf install chezmoi        # brew install chezmoi on macOS
```

## Step 5 — Switch branch and wire up chezmoi

```sh
git switch chezmoi
ln -s ~/Developer/archie ~/.local/share/chezmoi
chezmoi doctor                  # warnings ok; errors are a stop
```

## Step 6 — CHECKPOINT B: review and apply

```sh
chezmoi diff
```

Expect only file creations (plus, on WSL, the two `run_onchange` scripts
that copy mpv.net and Windows Terminal settings to the Windows side —
they're expected to run). Nothing should be overwriting a file the user
edited. **Summarize the diff for the user and get confirmation**, then:

```sh
chezmoi apply
```

## Step 7 — Verify the live system

Run and report each result:

```sh
zsh -ic 'echo shell ok'                        # prompt/plugins load, no errors
nvim --headless '+Lazy! home' +q 2>&1 | tail -2   # or: nvim '+checkhealth lazy'
tmux new -d -s smoke && tmux kill-session -t smoke
gpg -K
ls -l ~/.config/tmux/scripts/ ~/.local/scripts/t   # must be executable (755)
chezmoi verify && chezmoi status               # status empty = converged
```

On WSL additionally confirm the Windows-side copies landed (paths are
printed by `chezmoi apply`'s script output). Any failure: stop, report,
consult Rollback.

## Step 8 — CHECKPOINT C: purge leftover state from the repo tree

Only after step 7 fully passes:

```sh
git clean -ndx        # DRY RUN
```

**Show the user the listing and get confirmation** — everything shown should
be old-package leftovers whose copies now live in `$HOME` (plus the backup
from step 0 covers mistakes). Then:

```sh
git clean -fdx
find . -type d -empty -not -path './.git/*' -delete
lefthook install      # refresh hooks for the new lefthook.yml
```

Done. Tell the user the machine is migrated and that after all machines are
done, `chezmoi` should be merged into `main` (and this file deleted).

## Rollback

- **Never run `chezmoi purge`** — with the symlinked source dir it offers to
  delete this repo.
- **Before step 8**: everything is reversible. `rm ~/.local/share/chezmoi`
  (the symlink) and `rm -rf ~/.config/chezmoi ~/.cache/chezmoi`; delete the
  files/dirs chezmoi created in `$HOME` (they'd conflict with stow —
  `~/.config/<name>` dirs, `~/.zshenv`, `~/.claude/CLAUDE.md`,
  `~/.local/scripts/t`, plus relocated copies like `~/.local/share/gnupg`);
  then `git switch main && make`.
- **After step 8**: repo-tree state is gone; restore it first:
  `tar xzf ~/archie-state-backup-<date>.tgz -C ~/Developer/archie`, then as
  above `git switch main && make`.
