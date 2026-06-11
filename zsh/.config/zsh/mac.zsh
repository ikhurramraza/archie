#!/usr/bin/zsh

# Add Homebrew directory to PATH
PATH="/opt/homebrew/bin:$PATH"

# Add Apple helper paths (removed from /etc/zprofile)
PATH="$PATH:/usr/local/bin"
PATH="$PATH:/Library/Apple/usr/bin"

# Enable concurrent brew downloads
export HOMEBREW_DOWNLOAD_CONCURRENCY=auto
