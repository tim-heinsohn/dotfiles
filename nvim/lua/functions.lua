---@diagnostic disable: undefined-global
local M = {}

function M.setup()
    -- GitFileName - returns the filename relative to git root
    -- Used by lightline for displaying file path in git repos
    _G.GitFileName = function()
      local gitbranch_path = vim.b.gitbranch_path
      if not gitbranch_path then
        return vim.fn.expand('%')
      end
      local root = vim.fn.fnamemodify(gitbranch_path, ':h:h')
      local path = vim.fn.expand('%:p')
      if path:sub(1, #root) == root then
        return path:sub(#root + 2)
      end
      return vim.fn.expand('%')
    end

    -- Close all tabs to the left of current tab
    _G.TabCloseLeft = function()
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
    _G.TabCloseRight = function()
      local current_tab = vim.api.nvim_tabpage_get_number(0)
      local tab_count = vim.fn.tabpagenr("$")
      -- Close tabs from right to left to prevent shifting
      for i = tab_count, current_tab + 1, -1 do
        vim.cmd("tabclose " .. i)
      end
    end
end

return M
