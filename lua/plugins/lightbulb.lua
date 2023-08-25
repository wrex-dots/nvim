return {
  {
    'kosayoda/nvim-lightbulb',

    event = 'VeryLazy',

    opts = {
      autocmd = { enabled = true },
    },

    config = function(_, opts)
      vim.o.signcolumn = 'yes'

      require('nvim-lightbulb').setup(opts)
    end
  }
}
