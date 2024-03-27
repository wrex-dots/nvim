---@type LazyPluginSpec[]
local deps = {}

-- Get annotations in your Vim configurtation and plugin dev files
table.insert(deps, {
  "folke/neodev.nvim",

  ft = "lua",

  config = true,
})

-- Wrapper around `vim.lsp.buf.format` to avoid formatting with ALL formatters at once
table.insert(deps, {
  "fmbarina/pick-lsp-formatter.nvim",

  dependencies = {
    "nvim-telescope/telescope.nvim",
  },

  keys = {
    "<F10>",
    "<C-F10>",
  },

  main = "plf",

  opts = {
    find_project = true,
    --selene: allow(global_usage)
    when_unset = function() return _G["PLF_SHOULD_OPEN_PICKER"] end,
  },
})

return deps
