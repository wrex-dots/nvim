local fox = require "foxutils"

---@type LazyPluginSpec
local spec = {
  "aznhe21/actions-preview.nvim",

  dependencies = {
    "nvim-telescope/telescope.nvim",
  },

  keys = function()
    local actions = require("actions-preview").code_actions

    return fox.keys.lazy({
      {
        "<leader>a",
        actions,
        desc = "Show code for current line",
      },
      {
        "<leader><S-a>",
        function()
          actions {
            context = { only = { "source" } },
          }
        end,
        desc = "Show for current buffer",
      },
    }, {
      prefix = "Code Actions",
      noremap = true,
      silent = true,
      mode = { "n", "x" },
    })
  end,

  config = function()
    require("actions-preview").setup {
      diff = {
        algorithm = "patience",
        ignore_whitespace = true,
      },
      telescope = require("telescope.themes").get_dropdown {
        winblend = 10,
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        layout_config = {
          width = 0.8,
          height = 0.9,
          prompt_position = "top",
          preview_cutoff = 20,
          preview_height = function(_, _, maxln) return maxln - 15 end,
        },
      },
    }
  end,
}

return spec
