-- LazyVim

local fox = require "foxutils"

---@type LazyPluginSpec
return {
  "danymat/neogen",

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "L3MON4D3/LuaSnip",
  },

  keys = function()
    local neo = require "neogen"
    local gen = function(t)
      return function() neo.generate { type = t } end
    end

    return fox.keys.lazy({
      {
        "<C-i>t",
        gen "type",
        desc = "Create type annotation for current context",
      },
      {
        "<C-i>f",
        gen "func",
        desc = "Create function annotation for current context",
      },
      {
        "<C-i>b", -- b as in buffer
        gen "file",
        desc = "Create file annotation for current context",
      },
      {
        "<C-i>c",
        gen "class",
        desc = "Create class annotation for current context",
      },
    }, {
      mode = { "n", "i" },
      prefix = "Neogen: ",
      noremap = true,
    })
  end,

  config = function()
    local jsLikeConfig = {
      template = {
        annotation_convention = "tsdoc",
      },
    }

    require("neogen").setup {
      enabled = true,
      snippet_engine = "luasnip",
      languages = {
        typescript = jsLikeConfig,
        javascript = jsLikeConfig,
        typescriptreact = jsLikeConfig,
        javascriptreact = jsLikeConfig,
      },
    }
  end,
}
