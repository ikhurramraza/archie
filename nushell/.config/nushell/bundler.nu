#   ╭─────────────────────────────────────────────────────────────────────────╮
#   │                         SMART BUNDLER PREFIXER                          │
#   │                                                                         │
#   │ A wrapper for ruby binaries that adds appropriate prefixes to the       │
#   │ commands.                                                               │
#   │                                                                         │
#   │ The order of the prefixes (for rails binary):                           │
#   │ - bin/rails           (if bin/rails file exists)                        │
#   │ - bundle exec rails   (if Gemfile exists in the directory)              │
#   │ - rails               (fallback to default)                             │
#   ╰─────────────────────────────────────────────────────────────────────────╯

# TODO: Make this DRY

def --wrapped rails [...args: string] {
  if ("bin/rails" | path exists) {
    bin/rails ...$args
  } else if ("Gemfile" | path exists) {
    bundle exec rails ...$args
  } else {
    ^rails ...$args
  }
}

def --wrapped rake [...args: string] {
  if ("bin/rake" | path exists) {
    bin/rake ...$args
  } else if ("Gemfile" | path exists) {
    bundle exec rake ...$args
  } else {
    ^rake ...$args
  }
}

def --wrapped rspec [...args: string] {
  if ("bin/rspec" | path exists) {
    bin/rspec ...$args
  } else if ("Gemfile" | path exists) {
    bundle exec rspec ...$args
  } else {
    ^rspec ...$args
  }
}

def --wrapped good_job [...args: string] {
  if ("bin/good_job" | path exists) {
    bin/good_job ...$args
  } else if ("Gemfile" | path exists) {
    bundle exec good_job ...$args
  } else {
    ^good_job ...$args
  }
}

def --wrapped stree [...args: string] {
  if ("bin/stree" | path exists) {
    bin/stree ...$args
  } else if ("Gemfile" | path exists) {
    bundle exec stree ...$args
  } else {
    ^stree ...$args
  }
}

def --wrapped rubocop [...args: string] {
  if ("bin/rubocop" | path exists) and (not (file bin/rubocop | str contains "shell script")) {
    bin/rubocop ...$args
  } else if ("Gemfile" | path exists) {
    bundle exec rubocop ...$args
  } else {
    ^rubocop ...$args
  }
}
