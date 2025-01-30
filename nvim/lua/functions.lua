local M = {}

-- Close all tabs to the left of current tab
function M.tabcloseleft()
  local current_tab = vim.api.nvim_tabpage_get_number(0)
  for i = 1, current_tab - 1 do
    vim.cmd("tabclose 1")
  end
end

-- Close all tabs to the right of current tab
function M.tabcloseright()
  local current_tab = vim.api.nvim_tabpage_get_number(0)
  local tab_count = vim.fn.tabpagenr("$")
  for i = current_tab + 1, tab_count do
    vim.cmd("tabclose " .. current_tab + 1)
  end
end

return M
