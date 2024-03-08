--- .lua configuration directory
local luaconfd = vim.fn.stdpath("config") .. "/lua/config"

--- Get all files recursively
local luaconfs = vim.fs.find(function(name)
  return name:match(".*%.lua")
end, {
  type = "file",
  path = luaconfd,
  limit = math.huge,
})

-- Source all files fetched into luaconfs
for _, conf in ipairs(luaconfs) do
  require("config." .. vim.fs.basename(conf):gsub("%.lua$", ""))
end

-- .vim configuration files directory
local vimconfd = vim.fn.stdpath("config") .. "/vim.d"

-- Get all the .vim files from vimconfd recursively
local vimfiles = vim.fs.find(function(name)
  return name:match(".*%.vim")
end, {
  type = "file",
  path = vimconfd,
  limit = math.huge,
})

-- Source all files fetched into vimfiles
for _, conf in ipairs(vimfiles) do
  vim.cmd.source(conf)
end

-- Install LazyVim if necessary, then install all configured plugins
require("lazyconfig")
