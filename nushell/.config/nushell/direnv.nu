if (which dotenvjson | is-empty) { return }

$env.config.hooks.env_change.PWD = (
  $env.config.hooks.env_change.PWD | append { ||
    if not ('.env' | path exists) { return }

    dotenvjson .env | from json | default {} | load-env
  }
)
