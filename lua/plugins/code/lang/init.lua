local foxfs = require "foxutils.fs"

local M = {}

local language_plugins = {}
local langspath = foxfs.current_file.dirname()
local langsmodule = vim.fs.basename(langspath)
local langsdirs = vim.fs.find(function() return true end, {
  type = "directory",
  path = langspath,
  limit = math.huge,
})

local function is_extra_spec(name)
  return not name:match "lspconfig.lua"
    and not name:match "nullconfig.lua"
    and name:match ".*%.lua$"
end

---@param path string
local function get_module(path)
  local req = (
    "plugins.code."
    .. langsmodule
    .. path:gsub(langspath, ""):gsub("%.lua$", ""):gsub("/", ".")
  )
  return require(req)
end

for _, path in ipairs(langsdirs) do
  ---@type string[]
  local specfiles = vim.fs.find(is_extra_spec, {
    type = "file",
    limit = math.huge,
    path = path,
  })
  if #specfiles == 0 then goto SKIP_DIR end

  local rootname = vim.fs.basename(path)
  language_plugins[rootname] = {}
  for _, file in ipairs(specfiles) do
    local spec = get_module(file)
    local t = type(spec)
    if t == "string" or t == "table" then
      table.insert(language_plugins[rootname], get_module(file))
    end
  end

  -- cleanup in case some lang dir contained only non-returning modules
  for key, _ in pairs(language_plugins) do
    if #language_plugins[key] == 0 then language_plugins[key] = nil end
  end

  ::SKIP_DIR::
end

M.plugins = language_plugins
M.langs = vim.tbl_map(vim.fs.basename, langsdirs)

return M
