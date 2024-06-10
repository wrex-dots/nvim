local foxfs = require "foxutils.fs"
local here = foxfs.current_file.dirname()

---@type LazyPluginSpec
local spec = {
  "L3MON4D3/LuaSnip",

  dependencies = {
    "rafamadriz/friendly-snippets",
    "molleweide/LuaSnip-snippets.nvim",
    "honza/vim-snippets",
    {
      "mireq/luasnip-snippets",
      config = function(_self, opts)
        require("luasnip_snippets.common.snip_utils").setup(opts or {})
      end,
    },
  },

  build = "make install_jsregexp",

  event = "InsertEnter",

  config = function()
    local luasnip = require "luasnip"
    local utils = require "luasnip_snippets.snip_utils"

    luasnip.setup {
      keep_roots = true,
      link_roots = true,
      link_children = true,
      enable_autosnippets = true,
      update_events = { "TextChanged", "TextChangedI" },
      delete_check_events = { "TextChanged" },

      load_ft_func = utils.load_ft_func,
      ft_func = utils.ft_func,
    }

    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_snipmate").lazy_load()
    require("luasnip.loaders.from_lua").lazy_load()
    require("luasnip.loaders.from_lua").lazy_load {
      paths = vim.fs.normalize(here .. "/custom"),
    }
  end,
}

return spec
