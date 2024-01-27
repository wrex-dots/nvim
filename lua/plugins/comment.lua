local fox = require("foxutils")
local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)

---@type LazySpec[]
return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring",

    init = function()
      vim.g.skip_ts_context_commentstring_module = true
    end,
  },
  {
    "numToStr/Comment.nvim",

    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },

    keys = fox.keys.lazy({
      {
        "<C-/>",
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        mode = { "i", "n" },
        desc = "Current line",
      },
      {
        "<C-S-/>",
        function()
          require("Comment.api").toggle.blockwise.current()
        end,
        mode = { "i", "n" },
        desc = "Current line (as block)",
      },
      {
        "<C-/>",
        function()
          vim.api.nvim_feedkeys(esc, "nx", false)
          require("Comment.api").toggle.linewise(vim.fn.visualmode())
        end,
        mode = { "x" },
        desc = "Current selection",
      },
      {
        "<C-S-/>",
        function()
          vim.api.nvim_feedkeys(esc, "nx", false)
          require("Comment.api").toggle.blockwise(vim.fn.visualmode())
        end,
        mode = { "x" },
        desc = "Current selection (as block)",
      },
    }, {
      noremap = true,
      prefix = "Comment: ",
    }),

    config = function()
      require("Comment").setup {
        -->> Diable default mappings
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
        --<<

        padding = true,
        sticky = true,

        -- Enable contextual comment string integration
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },
}
