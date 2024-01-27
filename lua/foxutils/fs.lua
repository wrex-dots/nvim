local M = {}
M.current_file = {}

function M.current_file.name()
  local path = debug.getinfo(1, "S").source:gsub("^\\@", "")
  return vim.fs.basename(path)
end

function M.current_file.dirname()
  local path = debug.getinfo(1, "S").source:gsub("^\\@", "")
  return vim.fs.dirname(path)
end

function M.current_file.path()
  local path = debug.getinfo(1, "S").source:gsub("^@", "")
  return vim.fs.normalize(path)
end

return M
