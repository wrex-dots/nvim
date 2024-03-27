local function plug(mod)
  return require("plugins.code.TreeSitter.extras." .. mod)
end

return {
  plug "tree-hopper",
}
