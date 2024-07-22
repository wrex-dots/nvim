---@type LazyPluginSpec
local splitborders = {
  "nvim-zh/colorful-winsep.nvim",
  enabled = false,
  event = "WinLeave",
  config = true,
}

return {
  splitborders,
}
