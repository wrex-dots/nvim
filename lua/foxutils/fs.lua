local M = {}
local fs = vim.fs
local resolve = vim.fn.resolve

local HERE = debug.getinfo(1, "S").source:gsub("^@", "")

M.current_file = {}

function M.current_file.name()
  local path = debug.getinfo(1, "S").source:gsub("^@", "")

  if path == HERE then path = debug.getinfo(2, "S").source:gsub("^@", "") end

  return resolve(fs.basename(path))
end

function M.current_file.dirname()
  local path = debug.getinfo(1, "S").source:gsub("^@", "")

  if path == HERE then path = debug.getinfo(2, "S").source:gsub("^@", "") end

  return resolve(fs.dirname(path))
end

function M.current_file.path()
  local path = debug.getinfo(1, "S").source:gsub("^@", "")

  if path == HERE then path = debug.getinfo(2, "S").source:gsub("^@", "") end

  return resolve(path)
end

function M.is_git_dir(path)
  return 0
    ~= #vim.fs.find(".git", {
      type = "directory",
      path = path,
      upwards = true,
      stop = vim.loop.os_homedir(),
      limit = math.huge,
    })
end

function M.cwd_is_git_dir() return M.is_git_dir(vim.fn.getcwd()) end

return M
