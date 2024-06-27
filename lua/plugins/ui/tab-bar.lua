-- LazyVim

---@type LazySpec[]
local spec = {
  "romgrk/barbar.nvim",

  dependencies = require "plugins.ui.tab-bar.deps",

  lazy = false,

  init = function()
    vim.g.barbar_auto_setup = false

    vim.opt.sessionoptions:append "globals"
    vim.api.nvim_create_user_command("Mksession", function(attr)
      vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
      vim.cmd.mksession { bang = attr.bang, args = attr.fargs }
    end, {
      bang = true,
      complete = "file",
      desc = "Save barbar with :mksession",
      nargs = "?",
    })
  end,

  keys = require "plugins.ui.tab-bar.keys",

  opts = {
    auto_hide = true,

    exclude_ft = {
      "NvimTree",
    },

    hide = {
      extensions = true,
    },

    semantic_letters = true,

    sidebar_filetypes = {
      NvimTree = true,
      undotree = { text = "undotree" },
    },
  },
}

return spec
