local defaults = {}

---@alias PubDiagsEvent
---| "change"
---| "insert_leave"

---@alias CodeAction
---| "fix_all"
---| "add_missing_imports"
---| "remove_unused"
---| "remove_unused_imports"
---| "organize_imports"

---@alias CodeActionExpose
---| Array<CodeAction>
---| "all"

---@alias MaxMemory
---| integer
---| "auto"

---@alias CodeLensTrigger
---| "off"
---| "all"
---| "implementations_only"
---| "references_only"

---@class JsxCloseTagOpts
---@field enable    boolean
---@field filetypes Array<string>

---@class Settings
---@field separate_diagnostic_server           boolean          Spawn additional tsserver instance to calculate diagnostics on it
---@field publish_diagnostic_on                PubDiagsEvent    Determine when the client asks the server about diagnostic
---@field expose_as_code_action                CodeActionExpose Specify commands exposed as code_actions
---@field tsserver_path                        string | nil     Path to tsserver binary. If nil or on error, defaults to standard resolution strategy
---@field tsserver_plugins                     Array<string>    List of plugins for tsserver to load, e.g. for `styled-components` support
---@field tsserver_max_memory                  MaxMemory        Passed to `--max-old-space-sizesize-in-megabytes`
---@field tsserver_format_options              table            See https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3418
---@field tsserver_file_preferences            table            See https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3439
---@field tsserver_locale                      string           Language settings for the text printed by the server
---@field complete_function_calls              boolean          ?
---@field include_completions_with_insert_text boolean          ?
---@field code_lens                            CodeLensTrigger  WARNING: Also experimental in VSC. Might cause performance issues
---@field disable_member_code_lens             boolean          Prevent Lens from showing up on object members, reducing IDE noise
---@field jsx_close_tag                        JsxCloseTagOpts  Automatic insertion of closing tags in React files

---@type fun(T: LspTools): fun(client: lsp.Client, buffer: integer) : nil
local function on_attach(T)
  return function(client, buffer)
    T.hook_fmt(client, buffer)
    require("twoslash-queries").attach(client, buffer)
  end
end

---@type HandlerModule
local M = {
  get_handler = function(T)
    return function()
      local api = require("typescript-tools.api")
      require("typescript-tools").setup {
        on_attach = on_attach(T),

        ---@type Settings
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
  end,
}

return M
