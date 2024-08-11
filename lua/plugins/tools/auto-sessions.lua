---@type LazyPluginSpec
local spec = {
  "rmagatti/auto-session",

  dependencies = {
    "nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
  },

  init = function()
    vim.opt.sessionoptions = {
      "blank",
      "buffers",
      "curdir",
      "folds",
      "help",
      "tabpages",
      "winsize",
      "winpos",
      "terminal",
      "localoptions",
    }
  end,

  opts = {
    auto_save_enabled = true,
    auto_restore_enabled = true,
    auto_session_allow_dirs = {
      "~/Repos",
      "~/.config",
    },
  },
}

return spec
