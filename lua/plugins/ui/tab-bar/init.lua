local function plug(mod) return require("plugins.ui.tab-bar." .. mod) end

---@type LazyPluginSpec
local spec = {
  "romgrk/barbar.nvim",

  dependencies = plug "deps",

  lazy = false,

  keys = plug "keys",

  init = function()
    vim.g.barbar_auto_setup = false

    vim.opt.sessionoptions:append("globals")
    vim.api.nvim_create_user_command("Mksession", function(attr)
      vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
      vim.cmd.mksession { bang = attr.bang, args = attr.fargs }
    end, { bang = true, complete = "file", desc = "Save barbar with :mksession", nargs = "?" })
  end,

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
