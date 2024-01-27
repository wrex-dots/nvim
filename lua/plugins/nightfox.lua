return {
  {
    "anuvyklack/windows.nvim",

    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },

    config = true,
  },
  {
    "EdenEast/nightfox.nvim",

    lazy = false,
    priority = 100,

    config = function()
      vim.o.termguicolors = true
      require("nightfox").setup {
        options = {
          transparent = true,
          dim_inactive = false,
          styles = {
            keywords = "bold",
            functions = "bold",
          },
        },
      }
      vim.cmd.colorscheme("duskfox")
    end,
  },
}
