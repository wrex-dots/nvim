---@type LazySpec[]
local M = {}

table.insert(M, { -- Main colour theme
  "EdenEast/nightfox.nvim",

  lazy = false,
  priority = 100,

  config = function()
    vim.o.termguicolors = true
    require("nightfox").setup {
      options = {
        transparent = true,
        dim_inactive = false,
        styles = {
          keywords = "bold",
          functions = "bold",
        },
      },
    }
    vim.cmd.colorscheme("duskfox")
  end,
})

table.insert(M, { -- Automagically resize active split
  "anuvyklack/windows.nvim",

  dependencies = {
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim",
  },

  config = true,
})

table.insert(M, { -- Smooth scrolling
  "declancm/cinnamon.nvim",

  event = "VeryLazy",

  config = function()
    require("cinnamon").setup {
      extra_keymaps = true,
      extended_keymaps = true,
    }

    vim.keymap.set({ "i", "n", "x" }, "<PgUp>", [[ <Cmd>lua Scroll('<C-u>', 1, 1)<CR> ]])
    vim.keymap.set({ "i", "n", "x" }, "<PgDown>", [[ <Cmd>lua Scroll('<C-d>', 1, 1)<CR> ]])
  end,
})

table.insert(M, { -- More informative search UI
  "kevinhwang91/nvim-hlslens",

  dependencies = { "kevinhwang91/nvim-ufo" },

  event = "VeryLazy",

  keys = { "/", "?" },
})

local use_scrollview = vim.fn.has("nvim-0.10") == 0
table.insert(M, { -- Fancy scroll bars
  {
    "lewis6991/satellite.nvim",
    cond = not use_scrollview,
    event = "VeryLazy",
  },
  {
    "dstein64/nvim-scrollview",
    cond = use_scrollview,
    event = "VeryLazy",
    config = true,
  },
})

table.insert(M, { -- Pretty notification popups
  "rcarriga/nvim-notify",

  lazy = false,
})

table.insert(M, { -- Indentation scope visualiser
  "echasnovski/mini.indentscope",
  version = "*",
  opts = {
    draw = {
      priority = 50,
    },
  },
})

return M
