---@meta

---@alias modestring
---| 'i' # Insert
---| 'n' # Normal
---| 'v' # Visual
---| 'x' # Select and Visual

---@alias modearray Array<modestring>

---@alias mode
---| modestring # Single mode
---| modearray  # Multiple modes

---@alias rhs
---| string   # Vim action
---| function # Lua action

---@alias vimbuffer
---| number # The buffer number
---| true   # Current buffer

---@class optmap
---@field buffer           vimbuffer? The buffer this keymap will be attached to
---@field remap            boolean?   Allow remapping to something else
---@field noremap          boolean?   Prevent remapping to something else
---@field expr             boolean?   I still don't understand what this does exactly
---@field replace_keycodes boolean?   Replace keycodes in the resulting string (true if epr = true)

---@class batchmapping
---@field [1] string Description of the mapping
---@field [2] string Keystroke
---@field [3] rhs    Action to trigger
---@field [4] optmap Options for the mapping

---@class batchmodes
---@field n Array<batchmapping>? Normal
---@field i Array<batchmapping>? Insert
---@field v Array<batchmapping>? Visual
---@field x Array<batchmapping>? Select

---@class batchmap
---@field map batchmodes?     Remappable
---@field noremap batchmodes? Non-remappable
