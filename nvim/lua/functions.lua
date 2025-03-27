---@diagnostic disable: undefined-global
local M = {}

function M.setup()

    -- Close all tabs to the left of current tab
    function TabCloseLeft()
      local current_tab = vim.api.nvim_tabpage_get_number(0)
      -- Return early if there are no tabs to the left
      if current_tab <= 1 then
        return
      end
      -- Close tabs from right to left to prevent shifting
      for i = current_tab - 1, 1, -1 do
        vim.cmd("tabclose " .. i)
      end
    end

    -- Close all tabs to the right of current tab
    function TabCloseRight()
      local current_tab = vim.api.nvim_tabpage_get_number(0)
      local tab_count = vim.fn.tabpagenr("$")
      -- Close tabs from right to left to prevent shifting
      for i = tab_count, current_tab + 1, -1 do
        vim.cmd("tabclose " .. i)
      end
    end
end

return M
