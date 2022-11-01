#!/usr/bin/zsh

# Add Homebrew directory to PATH
PATH="/opt/homebrew/bin:$PATH"

# Add pip user install location to PATH
PATH="$PATH:/Users/raza/.local/bin"

# Add custom bin directory to PATH
PATH="$PATH:/Users/raza/.bin"
PATH="$PATH:/Users/raza/.bin/nuc"
PATH="$PATH:/Users/raza/.bin/doctolib"

# Add Apple helper paths (removed from /etc/zprofile)
PATH="$PATH:/usr/local/bin"
PATH="$PATH:/Library/Apple/usr/bin"

# Set default AWS profile name
export AWS_PROFILE=Raza
