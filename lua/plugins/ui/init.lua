local function plug(mod) return require("plugins.ui." .. mod) end

---@type LazySpec[]
local ui = {
  plug "apis",

  plug "theme",

  plug "tab-bar",
  plug "file-tree",

  plug "windows",
  plug "buffers",
}

return ui
