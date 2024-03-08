---@type LazySpec[]
local M = {}

local fox = require("foxutils")

table.insert(M, { -- Improve folding experience overall
  "kevinhwang91/nvim-ufo",

  dependencies = {
    "kevinhwang91/promise-async",
    "nvim-treesitter/nvim-treesitter",
  },

  event = "Syntax *",

  init = function()
    vim.o.foldcolumn = "0"
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,

  config = function()
    require("ufo").setup {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    }
  end,
})

table.insert(M, { -- Fold smarter and faster
  "chrisgrieser/nvim-origami",

  enabled = false,

  event = "BufReadPost", -- later or on keypress would prevent saving folds

  config = function()
    local origami = require("origami")

    origami.setup {}
    fox.keys.batch {
      noremap = {
        n = {
          { "Move left and/or open fold", "<Left>", origami.h },
          { "Move right and/or open fold", "<Right>", origami.l },
        },
      },
    }
  end,
})

return M
