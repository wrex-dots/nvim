---@param pyver string
local function splitver(pyver)
  local v = {}
  for n in pyver:gmatch "%d+" do
    table.insert(v, tonumber(n))
  end
  return v
end

local function has_prereqs()
  if not vim.fn.has "nvim0.5" then return false end

  local pyver = vim.fn.has "python3"
    and vim.fn.system("python3 --version"):gsub("^[^0-9]+", "")
  if not pyver or vim.version.lt(splitver(pyver), { 3, 8, 2 }) then
    return false
  end

  if not vim.fn.executable "sqlite3" then return false end

  return true
end

local function maybe_enable()
  local enable = has_prereqs()
  if not enable then
    vim.notify(
      "[Coq.nvim] Some prerequisites aren't met, completion will not be enabled.",
      vim.log.levels.ERROR
    )
  end
  return enable
end

---@type LazyPluginSpec
local spec = {
  "ms-jpq/coq_nvim",

  cond = maybe_enable(),

  branch = "coq",
  build = ":COQdeps",

  event = "InsertEnter",

  dependencies = {
    {
      "ms-jpq/coq.artifacts",
      branch = "artifacts",
    },
    {
      "ms-jpq/coq.thirdparty",
      branch = "3p",
    },
  },

  -- Automatic and silent startup
  init = function()
    vim.g.coq_settings = {
      auto_start = "shut-up",
    }
  end,
}

return spec
