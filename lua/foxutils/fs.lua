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

---Look upwards to find any directory or file that match given name.
--
---@param  name string Name of a file or directory to find up the fs tree
--
---@return table<string> matches A table of paths to directories and files matched by name
function M.find_upwards(name)
  return vim.fs.find(name, {
    upwards = true,
    stop = "/home",
    limit = math.huge,
  })
end

---Look upwards to find the first directory or file that matches given name.
--
---@param  name string Name of a file or directory to find up the fs tree
--
---@return boolean       found True if a match has been found, false otherwise
---@return string | nil  match A path to a directory or file matched by name
function M.find_upwards_first(name)
  local found = M.find_upwards(name)
  if #found == 0 then return false, nil end
  return true, found[1]
end

---Check that a given path is inside a git directory.
--
---@param  path string Path to a directory to check
--
---@return boolean
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
