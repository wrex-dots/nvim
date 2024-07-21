-- LazyVim

---@type LazyPluginSpec
local spec = {
  "max397574/startup.nvim",

  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },

  opts = {
    theme = "dashboard",
  },
}

return spec
