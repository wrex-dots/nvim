-- LazyVim

---@type LazyPluginSpec[]
local linenums = {
  "kennykaye/vim-relativity",

  init = function()
    local ignored_fts = {
      "NvimTree",
      "toggleterm",
      "dap-repl",
    }

    vim.o.number = true
    vim.o.relativenumber = true
    vim.g.relativity_enabled_on_start = 1
    vim.g.relativity_focus_toggle = 1
    vim.g.relativity_filetype_ignore = ignored_fts
  end,
}

---@type LazyPluginSpec[]
local gitsigns = {
  "lewis6991/gitsigns.nvim",

  opts = {
    numhl = true, -- Colorise line numbers according to their correspondig sign column item
    current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
  },

  config = function(_, opts)
    require("gitsigns").setup(opts)

    -- Enable current line blame by default
    -- Will show an inlay hint next to the line telling you who made the change and when
    -- after a short period of cursor inactivity
    vim.cmd.Gitsigns "toggle_current_line_blame"
  end,
}

return {
  gitsigns,
  linenums,
}
