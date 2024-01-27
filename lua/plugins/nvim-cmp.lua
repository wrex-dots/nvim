---@diagnostic disable: missing-fields

local function safeSelect(cmp)
  return cmp.mapping {
    i = function(fallback)
      if cmp.visible() and cmp.get_active_entry() then
        cmp.confirm { behavior = cmp.ConfirmBehavior, select = false }
      else
        fallback()
      end
    end,
    s = cmp.mapping.confirm { select = true },
    c = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior, select = true },
  }
end

local function should_indent()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local buff = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
  local onlyWhitespacesBefore = buff:sub(0, col):match("^%s*$") ~= nil
  local hasTextAfter = buff:sub(col):match("[^%s]+") ~= nil

  return onlyWhitespacesBefore and hasTextAfter
end

local function tabInput(cmp)
  local ls = require("luasnip")

  return cmp.mapping {
    i = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif ls.expand_or_locally_jumpable(1) then
        ls.expand_or_jump(1)
      elseif should_indent() then
        vim.cmd(":>")
      else
        fallback()
      end
    end,
    s = function(fallback)
      if ls.expand_or_locally_jumpable() then
        ls.expand_or_jump()
      elseif should_indent() then
        vim.cmd(":>")
      else
        fallback()
      end
    end,
  }
end

local function shiftTabInput(cmp)
  local ls = require("luasnip")

  return cmp.mapping {
    i = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif ls.expand_or_locally_jumpable(-1) then
        ls.expand_or_jump(-1)
      elseif should_indent() then
        vim.cmd(":<")
      else
        fallback()
      end
    end,
    s = function(fallback)
      if ls.expand_or_locally_jumpable(-1) then
        ls.expand_or_jump(-1)
      elseif should_indent() then
        vim.cmd(":<")
      else
        fallback()
      end
    end,
  }
end

return {
  {
    "hrsh7th/nvim-cmp",

    version = false,

    dependencies = {
      "FelipeLema/cmp-async-path",
      "amarakon/nvim-cmp-buffer-lines",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "onsails/lspkind.nvim",
      "saadparwaiz1/cmp_luasnip",
      "uga-rosa/cmp-dictionary",
      "windwp/nvim-autopairs",
      {
        "ray-x/cmp-treesitter",
        dependencies = {
          "nvim-treesitter/nvim-treesitter",
        },
      },
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "rafamadriz/friendly-snippets",
          "molleweide/LuaSnip-snippets.nvim",
          "honza/vim-snippets",
        },
        build = "make install_jsregexp",
        config = function()
          local luasnip = require("luasnip")

          luasnip.setup {
            keep_roots = true,
            link_roots = true,
            link_children = true,
            enable_autosnippets = true,
            update_events = { "TextChanged", "TextChangedI" },
            delete_check_events = { "TextChanged" },
          }

          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_snipmate").lazy_load()
          require("luasnip.loaders.from_lua").lazy_load()
          require("luasnip.loaders.from_lua").lazy_load {
            paths = vim.fs.normalize(vim.fn.stdpath("config") .. "/lua/snippets"),
          }
        end,
      },
    },

    event = { "InsertEnter" },

    config = function()
      local cmp = require("cmp")
      local pairs = require("nvim-autopairs.completion.cmp")
      local kind = require("lspkind")

      cmp.setup {
        mapping = cmp.mapping.preset.insert {
          ["<CR>"] = safeSelect(cmp),
          ["<ESC>"] = cmp.mapping.abort(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<Tab>"] = tabInput(cmp),
          ["<S-Tab>"] = shiftTabInput(cmp),
          ["<Up>"] = nil,
          ["<Down>"] = nil,
        },

        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },

        view = {
          entries = { name = "custom", selection_order = "near_cursor" },
        },

        formatting = {
          format = kind.cmp_format(),
        },

        sources = cmp.config.sources {
          { name = "nvim_lsp" },
          { name = "nvim_lsp_document_symbol" },
          { name = "nvim_lsp_signature_help" },
          { name = "treesitter" },
          {
            name = "luasnip",
            option = {
              show_autosnippets = true,
            },
          },
          { name = "buffer" },
          {
            name = "dictionary",
            keyword_length = 4,
          },
          { name = "async_path" },
        },
      }

      cmp.setup.filetype({ "c", "cpp" }, {
        soures = {
          { name = "buffer-lines" },
        },
      })

      cmp.event:on("confirm_done", pairs.on_confirm_done())
    end,
  },
  {
    "davidsierradz/cmp-conventionalcommits",

    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "FelipeLema/cmp-async-path",
      "hrsh7th/cmp-emoji",
    },

    ft = "gitcommit",

    config = function()
      local cmp = require("cmp")

      cmp.setup.buffer {
        sources = cmp.config.sources {
          { name = "conventionalcommits" },
          { name = "emoji" },
          { name = "async_path" },
          { name = "buffer" },
        },
      }
    end,
  },
  {
    "hrsh7th/cmp-cmdline",

    -- Too clunky to use for now
    enabled = false,

    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "FelipeLema/cmp-async-path",
      "amarakon/nvim-cmp-buffer-lines",
    },

    event = "CmdLineChanged",

    config = function()
      local cmp = require("cmp")
      local mapping = cmp.mapping.preset.cmdline {
        ["<CR>"] = cmp.mapping(cmp.mapping.confirm { select = true }, { "i", "c" }),
        ["<Up>"] = cmp.mapping.select_next_item(),
        ["<Down>"] = cmp.mapping.select_prev_item(),
      }

      -- cmp.setup.cmdline(':', {
      --   maping = mapping,
      --   sources = {
      --     { name = 'async_path' },
      --     {
      --       name = 'cmdline',
      --       option = {
      --         ignore_cmds = { 'Man', '!' }
      --       }
      --     }
      --   }
      -- })

      cmp.setup.cmdline({ "/", "?" }, {
        maping = mapping,
        sources = {
          {
            name = "buffer",
            option = {
              keyword_pattern = [[\k\+]],
            },
          },
          { name = "buffer-line" },
        },
      })
    end,
  },
  {
    "David-Kunz/cmp-npm",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },

    enabled = false,

    event = "BufEnter package.json",

    config = function()
      local cmp = require("cmp")
      require("cmp-npm").setup()

      cmp.setup {
        sources = {
          { name = "npm", keyword_length = 1 },
        },
      }
    end,
  },
  {
    "mtoohey31/cmp-fish",

    dependencies = {
      "hrsh7th/nvim-cmp",
    },

    cond = require("foxutils").systemhas("fish"),

    ft = "fish",

    config = function()
      local cmp = require("cmp")

      cmp.setup.filetype("fish", {
        sources = {
          { name = "fish" },
        },
      })
    end,
  },
  {
    -- TODO: Look into this some day
    "garyhurtz/cmp_kitty",

    dependencies = {
      "hrsh7th/nvim-cmp",
    },

    enabled = false,
  },
}
