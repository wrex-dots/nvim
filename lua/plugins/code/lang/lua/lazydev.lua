---@type LazyPluginSpec
local lazydev = {
  "folke/lazydev.nvim",

  ft = "lua", -- only load on lua files
  cond = vim.fn.has "nvim-0.10" == 1,

  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "luvit-meta/library", words = { "vim%.uv" } },
    },
  },
}

---@type LazyPluginSpec
local luvit = {
  "Bilal2453/luvit-meta",
  lazy = true,
}

---@type LazySpec[]
return {
  lazydev,
  luvit,
}
