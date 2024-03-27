local fox = require "foxutils"

local fts = {
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
}

---@type LazySpec[]
local spec = {
  { -- Magic real-time type tooltips with // ^?
    "marilari88/twoslash-queries.nvim",

    ft = fts,
    event = "FileType ",

    keys = fox.keys.lazy({
      {
        "<C-S-i>",
        vim.cmd.TwoslashQueriesInspect,
        desc = "Inspect symbol under cursor",
      },
      {
        "<C-M-i>",
        vim.cmd.TwoslashQueriesRemove,
        desc = "Remove all inspectors in buffer",
      },
    }, {
      prefix = "TwoSlash queries: ",
      noremap = true,
      mode = "n",
    }),

    opts = {
      multi_line = true,
      highlight = "Type",
    },
  },
  { -- TSServer on sterroids
    "pmizio/typescript-tools.nvim",

    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    ft = fts,
  },
}

return spec
