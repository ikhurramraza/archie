#   ╭─────────────────────────────────────────────────────────────────────────╮
#   │                                 DIRENV                                  │
#   │                                                                         │
#   │ Load environment variables when cd'ing into a directory with .env file. │
#   │                                                                         │
#   │ The plugin is only loaded if dotenvjson dependency is installed.        │
#   │ https://github.com/bjarneo/dotenvjson                                   │
#   ╰─────────────────────────────────────────────────────────────────────────╯

if (which dotenvjson | is-empty) { return }

$env.config.hooks.env_change.PWD = (
  $env.config.hooks.env_change.PWD | append { ||
    if not ('.env' | path exists) { return }

    dotenvjson .env | from json | default {} | load-env
  }
)
