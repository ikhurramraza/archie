# Configure Pipenv
$env.PIPENV_VERBOSITY = -1
$env.PIPENV_VENV_IN_PROJECT = enabled

# Configure IRB
$env.IRBRC = $"($env.XDG_CONFIG_HOME)/irb/irbrc"

# Configure gemrc
$env.GEMRC = $"($env.XDG_CONFIG_HOME)/gems/gemrc"

# Configure SQLite
$env.SQLITE_HISTORY = $"($env.XDG_DATA_HOME)/sqlite/history"

source ~/.config/nushell/atuin.nu
source ~/.config/nushell/carapace.nu
source ~/.config/nushell/rtx.nu
source ~/.config/nushell/starship.nu
source ~/.config/nushell/zoxide.nu
