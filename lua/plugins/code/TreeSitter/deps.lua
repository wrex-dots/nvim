local deps = {
  {
    -- More context-aware refactoring
    "nvim-treesitter/nvim-treesitter-refactor",

    -- Manipulate and move around text objects
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
}

table.insert(deps, {
  -- Keep track of the current context as a sticky topline
  "nvim-treesitter/nvim-treesitter-context",

  opts = {
    enable = true,
    max_lines = 0,
    separator = "^",
  },

  config = function(_, opts)
    require("treesitter-context").setup(opts)
    vim.cmd [[highlight! link TreeSitterContext Normal]]
  end,
})

table.insert(deps, {
  -- Automatic bracket pairing
  "windwp/nvim-autopairs",

  event = "Syntax *",

  opts = {
    check_ts = true,
  },
})

return deps
