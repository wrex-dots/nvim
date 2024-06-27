-- LazyVim

--- Get annotations in your Vim configurtation and plugin dev files
local neovim_lsp_symbols = {
  "folke/neodev.nvim",

  ft = "lua",
  cond = vim.fn.has "nvim-0.10" == 0,

  config = true,
}

--- Wrapper around `vim.lsp.buf.format` to avoid formatting with ALL formatters at once
local formatter_picker = {
  "fmbarina/pick-lsp-formatter.nvim",

  dependencies = {
    "nvim-telescope/telescope.nvim",
  },

  -- keys = {
  --   "<F10>",
  --   "<C-F10>",
  -- },

  main = "plf",

  opts = {
    find_project = true,
    --selene: allow(global_usage)
    when_unset = function() return _G["PLF_SHOULD_OPEN_PICKER"] end,
  },
}

---@type LazyPlugin[]
return {
  neovim_lsp_symbols,
  formatter_picker,
}
