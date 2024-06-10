-- LazyVim

local fox = require "foxutils"

assert(
  fox.systemhas "git",
  [[WTF?
  You do not have `git` in your PATH.
  Lazy.nvim won't be installed, nor will any of the plugins and awesome configs.]]
)

-- Installation path (`$XDG_CONFIG_HOME/nvim/lazy`)
local lazypath = vim.fn.stdpath "config" .. "/lazy"

-- Automatically install LazyVim
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end

-- Make NeoVim aware of LazyVim
vim.opt.rtp:prepend(lazypath)

-- Not everything is written in here, if you want to know all the defaults that you can override,
-- check here: https://github.com/folke/lazy.nvim
require("lazy").setup {
  -- Lua module to load specs from `stdpath('config')/lua/plugins`
  -- Will automatically merge all specs returned from modules inside `plugins`.
  import = "/plugins",

  -- Lazy load plugins by default
  lazy = true,

  -- Options for plugin devs
  -- You Surely want to change this to whatever dir contains your NeoVim plugin repos
  dev = {
    path = "~/Repos/nvim/", -- Root to all the plugins you dev
  },

  -- Cotrol installing plugins automatically
  install = {
    missing = true, -- If a plugin is missing on startup, install it
    -- Try to load one of these color schemes during start-up install phase
    -- I've never managed to get it to work so... weird.
    colorscheme = {
      "duskfox",
    },
  },

  -- Automatic update checker
  checker = {
    enabled = true,
  },
}

fox.keys.noremap.n("Open Lazy's control panel", "<C-l>", vim.cmd.Lazy, {
  silent = true,
})
