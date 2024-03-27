local function plug(mod) return require("plugins.ui.buffers." .. mod) end

return {
  plug "folding",
  plug "indentation-visualiser",
  plug "scope",
  plug "search-tooltips",
}
