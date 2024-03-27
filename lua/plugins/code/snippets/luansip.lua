local foxfs = require "foxutils.fs"
local here = foxfs.current_file.dirname()

---@type LazyPluginSpec
local spec = {
  "L3MON4D3/LuaSnip",

  dependencies = {
    "rafamadriz/friendly-snippets",
    "molleweide/LuaSnip-snippets.nvim",
    "honza/vim-snippets",
  },

  build = "make install_jsregexp",

  event = "InsertEnter",

  config = function()
    local luasnip = require "luasnip"

    luasnip.setup {
      keep_roots = true,
      link_roots = true,
      link_children = true,
      enable_autosnippets = true,
      update_events = { "TextChanged", "TextChangedI" },
      delete_check_events = { "TextChanged" },
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
