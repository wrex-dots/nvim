---@type LazyPluginSpec
local spec = {
  "anuvyklack/windows.nvim",

  event = "WinLeave",

  dependencies = {
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim",
  },

  config = true,
}

return spec
