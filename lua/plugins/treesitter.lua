return {
  {
    "nvim-treesitter/nvim-treesitter",

    dependencies = {
      { -- Keep track of the current context as a sticky topline
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
          enable = true,
          max_lines = 0,
        },
      },

      { -- Automatic bracket pairing
        "windwp/nvim-autopairs",

        event = "Syntax *",

        opts = {
          check_ts = true,
        },
      },

      { -- More context-aware refactoring
        "nvim-treesitter/nvim-treesitter-refactor",
      },

      { -- Manipulate and move around text objects
        "nvim-treesitter/nvim-treesitter-textobjects",
      },

      { -- Get syntax hilighting etc for Hyprland config files
        "luckasRanarison/tree-sitter-hypr",
      },
    },

    event = "Syntax *",

    build = ":TSUpdate",

    -- stylua: ignore
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      auto_install = true,

      ensure_installed = {
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

      textobjects = {
        select      = { enable = true },
        swap        = { enable = true },
        lsp_interop = { enable = true },
      },
    },
  },
}
