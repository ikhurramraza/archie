# Add carapace bin directory to PATH
$env.PATH = ($env.PATH | split row (char esep) | append $"($env.XDG_CONFIG_HOME)/carapace/bin" | uniq)

if (which carapace | is-empty) { return }

def --env get-env [name] { $env | get $name }
def --env set-env [name, value] { load-env { $name: $value } }
def --env unset-env [name] { hide-env $name }

let carapace_completer = {|spans|
  carapace $spans.0 nushell $spans | from json
}

mut current = (($env | default {} config).config | default {} completions)
$current.completions = ($current.completions | default {} external)
$current.completions.external = ($current.completions.external
    | default true enable
    | default $carapace_completer completer)

$env.config = $current
