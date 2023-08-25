---Check if the system has given binary in its path
---@param bin string Name of a PATH executable to look for
return function(bin)
  return pcall(
    function()
      vim.fn.system({bin})
    end
  )
end
