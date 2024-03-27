
local use_scrollview = vim.fn.has("nvim-0.10") == 0

---@type LazyPluginSpec[]
local spec = {
  {
    "lewis6991/satellite.nvim",
    cond = not use_scrollview,
    event = "VeryLazy",
  },
  {
    "dstein64/nvim-scrollview",
    cond = use_scrollview,
    event = "VeryLazy",
    config = true,
  },
}

return spec
