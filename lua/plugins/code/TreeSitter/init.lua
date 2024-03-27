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
}

return {
  spec,
  plug "extras",
}
