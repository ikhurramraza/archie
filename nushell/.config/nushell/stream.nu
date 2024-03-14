def stream [] {
  let content = $in
  let file = mktemp --tmpdir
  $content | save --raw --force $file
  $file
}
