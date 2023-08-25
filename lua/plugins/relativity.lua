return {
  {
    'kennykaye/vim-relativity',

    event = 'BufLeave',

    init = function()
      local ignored_fts = {
        'NvimTree',
      }

      vim.o.number = true
      vim.o.relativenumber = true
      vim.g.relativity_filetype_ignore = ignored_fts
    end,

    config = function()
      vim.cmd.Relativity()
    end,
  }
}
