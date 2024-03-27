local fox = require "foxutils"
local function plug(mod) return require("plugins.ui.apis.telescope." .. mod) end

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

  dependencies = plug "deps",
  keys = plug "keys",

  init = function()
    if not fox.systemhas "rg" then
      vim.notify(no_ripgrep_message, vim.log.levels.INFO)
    end
    if not fox.systemhas "fd" then
      vim.notify(no_fd_message, vim.log.levels.INFO)
    end
  end,

  config = function()
    local tele = require "telescope"
    tele.setup {}
    tele.load_extension "fzf"

    local maybe_load_extension = function(module, nameIfDifferentFromModule)
      local ok, _ = pcall(require, module)
      if ok then tele.load_extension(nameIfDifferentFromModule or module) end
    end

    local extensions = {
      { "scope" },
    }

    for _, ext in ipairs(extensions) do
      maybe_load_extension(ext[1], ext[2])
    end
  end,
}

return spec
