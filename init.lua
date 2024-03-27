--[[
   For better comfort, it is recommened to edit it from the
   nvim configuration's `lua/` directory, where a link to it
   is there, named `vim-init.lua`.

   This is because when you're using NeoVim from *inside*
   this `lua/` directory, `vim` will not be marked as
   undefined by the lua LSP, and also you'll get VERY useful
   IntelliSense for most plugins and (n)vim APIs.
--]]

local fn, fs, source = vim.fn, vim.fs, vim.cmd.source

local function fetch_configs(ext, path)
  return ipairs(
    fs.find(function(name) return name:match ".*%." .. ext .. "$" end, {
      path = path,
      type = "file",
      limit = math.huge,
    })
  )
end

local luadir = "config"
local luaconfd = fs.normalize(fn.stdpath "config" .. "/lua/" .. luadir)
local vimconfd = fs.normalize(fn.stdpath "config" .. "/vim.d")

for _, conf in fetch_configs("lua", luaconfd) do
  require(luadir .. "." .. fs.basename(conf):gsub("%.lua$", ""))
end

for _, conf in fetch_configs("vim", vimconfd) do
  source(conf)
end

-- Start plugin setup
require "lazyconfig"
