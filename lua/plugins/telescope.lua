local fox = require('foxutils')

local no_ripgrep_message = [[
I recommend you install RipGrep on your machine (or make it available in your PATH).
Installing it will immediately greatly improve Telescope's perofmance.
  => https://github.com/BurntSushi/ripgrep
]]

local no_fd_message = [[
I recommend you install fd on your machine (or make it available in your PATH).
Telescope will be disabled until you install it and restart your editor.
  => https://github.com/sharkdp/fd
]]


return {
  {
    'nvim-telescope/telescope.nvim',

    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
    },

    keys = fox.keys.lazy({
        {
          '<leader>ff',
          function()
            vim.cmd.Telescope('find_files')
          end,
          desc = 'File picker',
        },
        {
          '<leader>fg',
          function()
            vim.cmd.Telescope('live_grep')
          end,
          desc = 'Live GREP',
        },
        {
          '<leader>fb',
          function()
            vim.cmd.Telescope('buffers')
          end,
          desc = 'Buffer picker',
        },
        {
          '<leader>ft',
          function()
            vim.cmd.Telescope('treesitter')
          end,
          desc = 'TreeSitter tags',
        },
      },
      {
        mode = { 'i', 'n', 'x' },
        silent = true,
        noremap = true,
        prefix = 'Telescope: ',
      }
    ),

    init = function()
      if not fox.systemhas('rg') then
        vim.notify(no_ripgrep_message, vim.log.levels.INFO)
      end
      if not fox.systemhas('fd') then
        vim.notify(no_fd_message, vim.log.levels.INFO)
      end
    end,

    config = function()
      local tele = require('telescope')

      tele.setup {

      }

      local extensions = {
        'fzf',
      }

      for _, ext in ipairs(extensions) do
        tele.load_extension(ext)
      end
    end
  },
}
