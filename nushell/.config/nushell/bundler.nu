# Smart wrappers for ruby binaries (rails, rake, rspec) that runs
# runs the command with these prefixes in order as availability:
# - bin/rails           (if bin/rails file exists)
# - bundle exec rails   (if Gemfile exists in the directory)
# - rails               (fallback to default)

# TODO: Make this DRY

def --wrapped rails [...args] {
  if ("bin/rails" | path exists) {
    bin/rails $args
  } else if ("Gemfile" | path exists) {
    bundle exec rails $args
  } else {
    ^rails $args
  }
}

def --wrapped rake [...args] {
  if ("bin/rake" | path exists) {
    bin/rake $args
  } else if ("Gemfile" | path exists) {
    bundle exec rake $args
  } else {
    ^rake $args
  }
}

def --wrapped rspec [...args] {
  if ("bin/rspec" | path exists) {
    bin/rspec $args
  } else if ("Gemfile" | path exists) {
    bundle exec rspec $args
  } else {
    ^rspec $args
  }
}

def --wrapped good_job [...args] {
  if ("bin/good_job" | path exists) {
    bin/good_job $args
  } else if ("Gemfile" | path exists) {
    bundle exec good_job $args
  } else {
    ^good_job $args
  }
}

def --wrapped stree [...args] {
  if ("bin/stree" | path exists) {
    bin/stree $args
  } else if ("Gemfile" | path exists) {
    bundle exec stree $args
  } else {
    ^stree $args
  }
}
