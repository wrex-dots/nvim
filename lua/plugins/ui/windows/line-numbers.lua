local foxfs = require "foxutils.fs"

---@type LazyPluginSpec[]
local linenums = {
  {
    "airblade/vim-gitgutter",

    init = function() vim.g.gitgutter_highlight_linenrs = 1 end,

    enabled = foxfs.cwd_is_git_dir(),
  },
  {
    "kennykaye/vim-relativity",

    event = "BufLeave",

    init = function()
      local ignored_fts = {
        "NvimTree",
      }

      vim.o.number = true
      vim.o.relativenumber = true
      vim.g.relativity_filetype_ignore = ignored_fts
    end,

    config = function() vim.cmd.Relativity() end,
  },
}

return linenums
