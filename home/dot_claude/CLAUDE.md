# Personal global guidance

## Number your suggestions

Whenever you give me suggestions or recommendations, **number them** so I can
reference them in my reply.

- Use plain `1, 2, 3, …` for a flat list of comparable items.
- Use **priority-coded IDs** when the suggestions have differing priorities:
  `H1, H2` (High), `M1, M2` (Medium), `L1, L2` (Low). Other meaningful prefixes
  are fine when they fit (e.g. `P1` for a priority order, `B1` for bugs).
- Keep the IDs **stable within a conversation** so I can refer back to them
  (e.g. "do H3 and L2"); don't renumber the same item across messages.

## Avoid code comments

Write self-documenting code that does not need comments — prefer clear names and
structure over explanation. Only add a comment when it is genuinely needed: to
capture a non-obvious *why* (a rationale, trade-off, or workaround that the code
itself cannot convey), never to restate *what* the code does.

## Repo checkout layout

All my repos live under `~/Developer`.

Not every repo is checked out the same way, but the ones that are use the
**repo/branch/repo** worktree pattern: `<app>/<branch>/<app>`, backed by a bare
clone at `<app>/.bare`.

```
~/Developer/<app>/            # app root (container)
├── .bare/                    # bare clone; git dir, remote "origin" lives here
└── <branch>/                 # one dir per branch (e.g. main/, feature-x/)
    └── <app>/                # the checkout; its .git → <app>/.bare/worktrees/<app>
```

- **Creating a worktree** (run from the app root):
  ```
  git --git-dir=.bare worktree add ./<branch>/<app> <branch>            # existing branch
  git --git-dir=.bare worktree add -b <branch> ./<branch>/<app> origin/main  # new branch
  ```
- There is no `.git` file at the app root, so run plain git from inside an
  existing worktree, or use `--git-dir=.bare` from the app root.
- **Before creating a worktree**, check the repo actually follows this pattern
  (an `<app>/.bare` dir exists). If it does not, tell me it is not checked out in
  the repo/branch/repo pattern so I can convert it or ask you to re-clone it that
  way — do not silently `worktree add` against a non-bare checkout.
