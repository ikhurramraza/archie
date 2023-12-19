if ((which rtx | length) == 0) { return }

export-env {
  $env.RTX_SHELL = "nu"
  $env.RTX_GEM_DEFAULT_PACKAGES_FILE = $"($env.XDG_CONFIG_HOME)/rtx/ruby/default_gems"
  $env.RTX_NPM_DEFAULT_PACKAGES_FILE = $"($env.XDG_CONFIG_HOME)/rtx/nodejs/default_npm_packages"
  $env.RTX_PYTHON_DEFAULT_PACKAGES_FILE = $"($env.XDG_CONFIG_HOME)/rtx/python/default_python_packages"

  $env.config = ($env.config | upsert hooks {
      pre_prompt: ($env.config.hooks.pre_prompt ++
      [{
      condition: {|| "RTX_SHELL" in $env }
      code: {|| rtx_hook }
      }])
      env_change: {
          PWD: ($env.config.hooks.env_change.PWD ++
          [{
          condition: {|| "RTX_SHELL" in $env }
          code: {|| rtx_hook }
          }])
      }
  })
}

def "parse vars" [] {
  $in | lines | parse "{op},{name},{value}"
}

def --wrapped rtx [command?: string, --help, ...rest: string] {
  let commands = ["shell", "deactivate"]

  if ($command == null) {
    ^"/usr/bin/rtx"
  } else if ($command == "activate") {
    $env.RTX_SHELL = "nu"
  } else if ($command in $commands) {
    ^"/usr/bin/rtx" $command $rest
    | parse vars
    | update-env
  } else {
    ^"/usr/bin/rtx" $command $rest
  }
}

def --env "update-env" [] {
  for $var in $in {
    if $var.op == "set" {
      load-env {($var.name): $var.value}
    } else if $var.op == "hide" {
      hide-env $var.name
    }
  }
}

def --env rtx_hook [] {
  ^"/usr/bin/rtx" hook-env -s nu
    | parse vars
    | update-env
}
