-- LazyVim

---@type LazyPluginSpec[]
local linenums = {
  {
    "airblade/vim-gitgutter",

    init = function() vim.g.gitgutter_highlight_linenrs = 1 end,
  },
  {
    "kennykaye/vim-relativity",

    init = function()
      local ignored_fts = {
        "NvimTree",
      }

      vim.o.number = true
      vim.o.relativenumber = true
      vim.g.relativity_enabled_on_start = 1
      vim.g.relativity_focus_toggle = 1
      vim.g.relativity_filetype_ignore = ignored_fts
    end,
  },
}

return linenums
