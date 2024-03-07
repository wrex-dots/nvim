local M = {}
local fs = vim.fs

local HERE = debug.getinfo(1, "S").source:gsub("^@", "")

M.current_file = {}

function M.current_file.name()
  local path = debug.getinfo(1, "S").source:gsub("^@", "")

  if path == HERE then path = debug.getinfo(2, "S").source:gsub("^@", "") end

  return fs.normalize(fs.basename(path))
end

function M.current_file.dirname()
  local path = debug.getinfo(1, "S").source:gsub("^@", "")

  if path == HERE then path = debug.getinfo(2, "S").source:gsub("^@", "") end

  return fs.normalize(fs.dirname(path))
end

function M.current_file.path()
  local path = debug.getinfo(1, "S").source:gsub("^@", "")

  if path == HERE then path = debug.getinfo(2, "S").source:gsub("^@", "") end

  return fs.normalize(path)
end

return M
