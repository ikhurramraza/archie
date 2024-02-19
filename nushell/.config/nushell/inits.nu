# Default programs
$env.BROWSER = firefox
$env.EDITOR = nvim
$env.TERMINAL = wezterm

# Set language to English
$env.LANG = "en_US.UTF-8"

# XDG Dirs
$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
$env.XDG_CACHE_HOME = $"($env.HOME)/.cache"
$env.XDG_DATA_HOME = $"($env.HOME)/.local/share"
$env.XDG_STATE_HOME = $"($env.HOME)/.local/state"

# Set environment variables for XDG compliant paths
$env.BUNDLE_USER_CACHE = $"($env.XDG_CACHE_HOME)/bundle"
$env.BUNDLE_USER_CONFIG = $"($env.XDG_CONFIG_HOME)/bundle/config"
$env.BUNDLE_USER_PLUGIN = $"($env.XDG_DATA_HOME)/bundle"
$env.CARGO_HOME = $"($env.XDG_DATA_HOME)/cargo"
$env.DOCKER_CONFIG = $"($env.XDG_CONFIG_HOME)/docker"
$env.GNUPGHOME = $"($env.XDG_DATA_HOME)/gnupg"
$env.GOPATH = $"($env.XDG_DATA_HOME)/go"
$env.LESSHISTFILE = $"($env.XDG_STATE_HOME)/less/history"
$env.RUSTUP_HOME = $"($env.XDG_DATA_HOME)/rustup"
$env.ZDOTDIR = $"($env.XDG_CONFIG_HOME)/zsh"
$env._Z_DATA = $"($env.XDG_DATA_HOME)/z"

# Configure Pipenv
$env.PIPENV_VERBOSITY = -1
$env.PIPENV_VENV_IN_PROJECT = enabled

# Configure IRB
$env.IRBRC = $"($env.XDG_CONFIG_HOME)/irb/irbrc"

# Configure gemrc
$env.GEMRC = $"($env.XDG_CONFIG_HOME)/gems/gemrc"

# Configure SQLite
$env.SQLITE_HISTORY = $"($env.XDG_DATA_HOME)/sqlite/history"

# Configure pass
$env.PASSWORD_STORE_DIR = $"($env.XDG_DATA_HOME)/pass"

# Configure notie
$env.NOTIE_DIRECTORY = "/mnt/nas/Notes"

# Utility function to add new path to PATH env variable if it doesn't already exist
def --env append-to-path [path] {
  let paths = $env.PATH | split row (char esep)
  if ($paths | where { |row| $row == $path } | length) > 0 { return }

  $env.PATH = ($paths | append $path | str join (char esep))
}

# Add local scripts to PATH
append-to-path $"($env.HOME)/.local/scripts"

# Add cargo bin directory to PATH
append-to-path $"($env.CARGO_HOME)/bin"

# Add go bin directory to PATH
append-to-path $"($env.GOPATH)/bin"

source bundler.nu
source carapace.nu
source mise.nu
source starship.nu
source zoxide.nu
source atuin.nu
