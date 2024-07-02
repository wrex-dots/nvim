---@meta

---@alias MapModeStr
---| 'i' # Insert
---| 'n' # Normal
---| 'o' # Operator pending
---| 'v' # Visual
---| 'x' # Select and Visual

---@alias MapModeTable MapModeStr[]

---@alias mode
---| MapModeStr   # Single mode
---| MapModeTable # Multiple modes

---@alias MapRHS
---| string   # Vim action
---| function # Lua action

---@alias VimBufferNum
---| number # The buffer number
---| true   # Current buffer

---@class MapOptions
---@field buffer           VimBufferNum? The buffer this keymap will be attached to
---@field remap            boolean?      Allow remapping to something else
---@field noremap          boolean?      Prevent remapping to something else
---@field expr             boolean?      I still don't understand what this does exactly
---@field replace_keycodes boolean?      Replace keycodes in the resulting string (true if epr = true)

---@class MapBatchItem
---@field [1] string     Description of the mapping
---@field [2] string     Keystroke
---@field [3] MapRHS     Action to trigger
---@field [4] MapOptions Options for the mapping

---@class MapBatchModes
---@field i MapBatchItem[]? Insert
---@field n MapBatchItem[]? Normal
---@field o MapBatchItem[]? Operator-pending
---@field t MapBatchItem[]? Terminal
---@field v MapBatchItem[]? Visual
---@field x MapBatchItem[]? Select

---@class MapBatch
---@field map     MapBatchModes? Remappable
---@field noremap MapBatchModes? Non-remappable
