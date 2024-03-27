---@diagnostic disable: assign-type-mismatch
local fox = require "foxutils"
local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)

---@type LazyPluginSpec
local spec = {
  "numToStr/Comment.nvim",

  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      init = function() vim.g.skip_ts_context_commentstring_module = true end,
    },
  },

  keys = function()
    local toggle = require("Comment.api").toggle
    return fox.keys.lazy({
      {
        "<C-/>",
        toggle.linewise.current,
        mode = { "i", "n" },
        desc = "Current line",
      },
      {
        "<C-S-/>",
        toggle.blockwise.current,
        mode = { "i", "n" },
        desc = "Current line (as block)",
      },
      {
        "<C-/>",
        function()
          vim.api.nvim_feedkeys(esc, "nx", false)
          toggle.linewise(vim.fn.visualmode())
        end,
        mode = { "x" },
        desc = "Current selection",
      },
      {
        "<C-S-/>",
        function()
          vim.api.nvim_feedkeys(esc, "nx", false)
          toggle.blockwise(vim.fn.visualmode())
        end,
        mode = { "x" },
        desc = "Current selection (as block)",
      },
    }, {
      noremap = true,
      prefix = "Comment: ",
    })
  end,

  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("Comment").setup {
      -- Diable default mappings
      toggler = {
        line = nil,
        block = nil,
      },
      opleader = {
        line = nil,
        block = nil,
      },
      extra = {
        above = nil,
        below = nil,
        eol = nil,
      },

      padding = true,
      sticky = true,

      -- Enable contextual comment string integration
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    }

    local ft = require "Comment.ft"
    vim.tbl_map(function(cs) ft[cs[1]] = cs[2] end, {
      { "hyprlang", "#%s" },
    })
  end,
}

return spec
