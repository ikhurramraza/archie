local function get_os()
  local os = "Linux"
  local handle = io.open("uname")
  if handle then
    os = handle:read("*a"):gsub("[\n\r]", "")
    handle:close()
  end

  return os
end

return {
  os = get_os(),
}
