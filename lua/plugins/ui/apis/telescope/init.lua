-- LazyVim
local fox = require "foxutils"

local no_ripgrep_message = [[
I recommend you install RipGrep on your machine (or make it available in your PATH).
Installing it will immediately greatly improve Telescope's perofmance.
  => https://github.com/BurntSushi/ripgrep
]]

local no_fd_message = [[
I recommend you install fd on your machine (or make it available in your PATH).
Installing it will immediately greatly improve Telescope's perofmance.
  => https://github.com/sharkdp/fd
]]

---@type LazyPluginSpec
local spec = {
  "nvim-telescope/telescope.nvim",

  dependencies = require "plugins.ui.apis.telescope.deps",
  keys = require "plugins.ui.apis.telescope.keys",

  init = function()
    if not fox.systemhas "rg" then
      vim.notify(no_ripgrep_message, vim.log.levels.INFO)
    end
    if not fox.systemhas "fd" then
      vim.notify(no_fd_message, vim.log.levels.INFO)
    end
  end,

  opts = {
    extensions = require "plugins.ui.apis.telescope.exts",
  },

  config = function(_, opts)
    local tele = require "telescope"
    tele.setup(opts)

    ---@see telescope-fzf-native in `plugins.ui.apis.telescope.deps`
    tele.load_extension "fzf"

    ---@see Scope.nvim in `plugins.ui.buffers.scope`
    tele.load_extension "scope"
  end,
}

return spec
