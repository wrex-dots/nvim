---@type LazyPluginSpec
local lazydev = {
  "folke/lazydev.nvim",

  ft = "lua", -- only load on lua files
  cond = vim.fn.has "nvim-0.10" == 1,

  opts = {
    library = {
      { path = "luvit-meta/library", words = { "vim%.uv", "vim%.loop" } },
      { path = "LazyVim", words = { "LazyVim" } },
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
