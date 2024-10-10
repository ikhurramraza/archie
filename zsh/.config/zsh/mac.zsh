#!/usr/bin/zsh

# Add Homebrew directory to PATH
PATH="/opt/homebrew/bin:$PATH"

# Add pip user install location to PATH
PATH="$PATH:/Users/$USER/.local/bin"

# Add Apple helper paths (removed from /etc/zprofile)
PATH="$PATH:/usr/local/bin"
PATH="$PATH:/Library/Apple/usr/bin"
