-- .vim configuration files directory
local vimconfd = vim.fn.stdpath('config') .. '/vim.d'

-- Get all the .vim files from vimconfd recursively
local vimfiles = vim.fs.find(
  function(name) return name:match('.*%.vim') end,
  {
    type = 'file',
    path = vimconfd,
    limit = math.huge,
  }
)

-- Source all files fetched into vimfiles
for _, conf in ipairs(vimfiles) do
  vim.cmd.source(conf)
end

-- Install LazyVim if necessary, then install and configure all plugins
-- defined in lua/plugins
require('lazyconfig')

-- Show todos when entering NeoVim
require('foxutils.todo')
