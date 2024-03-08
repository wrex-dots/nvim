---@type LazySpec[]
local M = {}

---@type LazySpec[]
local deps = {}

local fox = require("foxutils")

table.insert(deps, { -- Git file status in the `signcolumn`
  "lewis6991/gitsigns.nvim",
})

table.insert(deps, { -- Fancy filetype icons and more
  "nvim-tree/nvim-web-devicons",
})

table.insert(deps, { -- Restrict visibility of buffers to their own tabs
  "tiagovla/scope.nvim",

  init = function()
    vim.opt.sessionoptions = { -- required
      "buffers",
      "tabpages",
      "globals",
    }
  end,

  config = true,
})

return {
  "romgrk/barbar.nvim",

  dependencies = deps,

  lazy = false,

  init = function()
    vim.g.barbar_auto_setup = false

    vim.opt.sessionoptions:append("globals")
    vim.api.nvim_create_user_command("Mksession", function(attr)
      vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
      vim.cmd.mksession { bang = attr.bang, args = attr.fargs }
    end, { bang = true, complete = "file", desc = "Save barbar with :mksession", nargs = "?" })
  end,

  keys = fox.keys.lazy({
    {
      "<S-PageUp>",
      vim.cmd.BufferPrevious,
      desc = "Move to previous buffer",
    },
    {
      "<S-PageDown>",
      vim.cmd.BufferNext,
      desc = "Move to previous buffer",
    },
    {
      "<S->>",
      vim.cmd.BufferMoveNext,
      desc = "Move buffer tab right",
    },
    {
      "<S-<>",
      vim.cmd.BufferMovePrevious,
      desc = "Move buffer tab left",
    },
    {
      "<C-1>",
      function()
        vim.cmd.BufferGoto(1)
      end,
      desc = "Jump to buffer in position 1",
    },
    {
      "<C-2>",
      function()
        vim.cmd.BufferGoto(2)
      end,
      desc = "Jump to buffer in position 2",
    },
    {
      "<C-3>",
      function()
        vim.cmd.BufferGoto(3)
      end,
      desc = "Jump to buffer in position 3",
    },
    {
      "<C-4>",
      function()
        vim.cmd.BufferGoto(4)
      end,
      desc = "Jump to buffer in position 4",
    },
    {
      "<C-5>",
      function()
        vim.cmd.BufferGoto(5)
      end,
      desc = "Jump to buffer in position 5",
    },
    {
      "<C-6>",
      function()
        vim.cmd.BufferGoto(6)
      end,
      desc = "Jump to buffer in position 6",
    },
    {
      "<C-7>",
      function()
        vim.cmd.BufferGoto(7)
      end,
      desc = "Jump to buffer in position 7",
    },
    {
      "<C-8>",
      function()
        vim.cmd.BufferGoto(8)
      end,
      desc = "Jump to buffer in position 8",
    },
    {
      "<C-9>",
      function()
        vim.cmd.BufferGoto(9)
      end,
      desc = "Jump to buffer in position 9",
    },
    {
      "<C-0>",
      vim.cmd.BufferLast,
      desc = "Jump to buffer in last position",
    },
    {
      "<C-b>c",
      vim.cmd.BufferClose,
      desc = "Close current buffer",
    },
    {
      "<C-b><S-o>",
      vim.cmd.BufferCloseAllButCurrent,
      desc = "Close all buffer except the currently focused one",
    },
    {
      "<C-b>x",
      function()
        vim.cmd.up()
        vim.cmd.BufferClose()
      end,
      desc = "Save changes and close buffer",
    },
    {
      "<C-b>d",
      function()
        vim.cmd("BufferClose!")
      end,
      desc = "Delete current buffer (ignore changes)",
    },
    {
      "<C-b>p",
      vim.cmd.BufferPick,
      desc = "Trigger buffer picker",
    },
    {
      "<C-b>m",
      desc = "Move buffer to tab",
    },
    {
      "<C-b>on",
      vim.cmd.BufferOrderByBufferNumber,
      desc = "Order buffers by number",
    },
    {
      "<C-b>od",
      vim.cmd.BufferOrderByDirectory,
      desc = "Order buffers by directory",
    },
    {
      "<C-b>ol",
      vim.cmd.BufferOrderByLanguage,
      desc = "Order buffers by language",
    },
    {
      "<C-b>ow",
      vim.cmd.BufferOrderByWindowNumber,
      desc = "Order buffers by language",
    },
  }, {
    mode = { "i", "n", "x" },
    noremap = true,
    silent = true,
    prefix = "Barbar: ",
  }),

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
