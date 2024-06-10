local foxfs = require("foxutils").fs
local ensure = require "plugins.code.lang.ensure-installed"
local server = "tsserver"

ensure["mason"]:add {
  server,
  "eslint",
}

ensure["null-ls"]:add {
  "prettierd",
}
vim.fn.setenv(
  "PRETTIERD_DEFAULT_CONFIG",
  foxfs.current_file.dirname() .. "/.prettierrc.yaml"
)

ensure["tree-sitter"]:add {
  "javascript",
  "typescript",
  "tsx",
}

local EslintFixAll = vim.api.nvim_create_augroup("EslintFixAll", {})

---@type fun(T: LspTools): fun(client: lsp.Client, buffer: integer) : nil
local function on_attach(T)
  return function(client, buffer)
    -- LSP info tab for Eslint says there's an `EslintFixAll` command but it's a lie.
    --   vim.api.nvim_create_autocmd("BufWritePre", {
    --     group = EslintFixAll,
    --     buffer = buffer,
    --     command = "EslintFixAll",
    --   })

    require("twoslash-queries").attach(client, buffer)
    T.hook_fmt(client, buffer)
  end
end

---@type LspHandlerFactory
local factory = function(T)
  return function()
    local api = require "typescript-tools.api"
    require("typescript-tools").setup {
      on_attach = on_attach(T),

      ---@diagnostic disable-next-line: missing-fields
      settings = {
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",
        expose_as_code_action = "all",
        tsserver_path = nil,
        tsserver_plugins = {},
        tsserver_max_memory = "auto",
        tsserver_format_options = {},
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = false,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
        tsserver_locale = "en",
        complete_function_calls = false,
        include_completions_with_insert_text = true,
        code_lens = "implementations_only",
        disable_member_code_lens = true,
        jsx_close_tag = {
          enable = true,
          filetypes = { "javascriptreact", "typescriptreact" },
        },
      },

      handlers = {
        ["textDocument/publishDiagnostics"] = api.filter_diagnostics { 80006 }, -- Ignore 'This may be converted to an async function' diagnostics.
      },
    }
  end
end

return {
  [server] = factory,
}
