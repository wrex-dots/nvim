local fox = require "foxutils"
local function plug(mod) return require("plugins.code.TreeSitter." .. mod) end

local spec = {
  "nvim-treesitter/nvim-treesitter",

  event = "Syntax *",

  build = ":TSUpdate",

  dependencies = plug "deps",

  -- stylua: ignore
  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    auto_install          = true,

    ensure_installed      = {
      "c",
      "cpp",
      "hypr",
      "javascript",
      "lua",
      "markdown",
      "markdown_inline",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
    },

    indent                = { enable = true },
    highlight             = { enable = true },
    incremental_selection = { enable = true },

    textobjects           = {
      select      = { enable = true },
      swap        = { enable = true },
      lsp_interop = { enable = true },
    },
  },

  keys = function()
    local function peek(textobj)
      return function() vim.cmd.TSTextobjectPeekDefinitionCode(textobj) end
    end

    return fox.keys.lazy({
      {
        "<C-p>if",
        peek "@function.inner",
        mode = { "n", "i" },
        desc = "Peek inner function",
      },
      {
        "<C-p>af",
        peek "@function.outer",
        mode = { "n", "i" },
        desc = "Peek outer function",
      },
      {
        "<C-p>ic",
        peek "@class.inner",
        mode = { "n", "i" },
        desc = "Peek inner class",
      },
      {
        "<C-p>ac",
        peek "@class.outer",
        mode = { "n", "i" },
        desc = "Peek outer class",
      },
    }, {
      desc = "TreeSitter: ",
      noremap = true,
    })
  end,
}

return {
  spec,
  plug "extras",
}
