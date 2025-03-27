---@diagnostic disable: undefined-global
local M = {}

function M.setup()
  -- General mappings
  vim.keymap.set('n', '<leader>h', ':nohls<CR>', { silent = true, desc = "Turn off search highlighting" })
  vim.keymap.set('n', '<leader>km', '<cmd>Telescope keymaps<CR>', { desc = "Show keymaps in Telescope" })

  -- File/Buffer navigation
  vim.keymap.set('n', '<leader>b', '<cmd>Telescope buffers<CR>', { desc = "Show buffers in Telescope" })
  vim.keymap.set('n', '<leader>f', '<cmd>Ranger<CR>', { desc = "Open Ranger file explorer" })

  -- ... fzf
  local function fzx(include_hidden)
    local cmd = "fd -t f --no-ignore-vcs" .. (include_hidden and " --hidden" or "")
    local search_path = vim.g.fzx_search_path or "."
    cmd = cmd .. " " .. search_path

    vim.fn['fzf#run'](vim.fn['fzf#wrap']({
      source = cmd,
      sink = 'e'
    }))
  end

  vim.keymap.set('n', '<leader>g', function() fzx(false) end,
    { silent = true, desc = "FZF search non-hidden files" })
  vim.keymap.set('n', '<leader>G', function() fzx(true) end,
    { silent = true, desc = "FZF search all files including hidden" })

  -- LSP keymaps
  local function setup_lsp_keymaps(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end

  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  vim.keymap.set('n', '<space>d', vim.diagnostic.open_float)
  vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist)
  vim.keymap.set('n', '<leader>dh', vim.diagnostic.hide)
  vim.keymap.set('n', '<leader>ds', vim.diagnostic.show)
  vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev)
  vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next)

  -- Set up LSP keymaps when LSP attaches
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = setup_lsp_keymaps
  })

  -- Aerial navigation
  vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>', { desc = "Toggle Aerial outline" })

  -- Git mappings
  vim.keymap.set('n', '<leader>dm', ':DiffviewOpen origin/main -- %<CR>',
    { noremap = true, silent = true, desc = "Diff against main branch" })
  vim.keymap.set('n', '<leader>dc', ':DiffviewClose<CR>:tabn -1<CR>',
    { noremap = true, silent = true, desc = "Close diff view" })

  -- Tig mappings
  vim.keymap.set('n', '<Leader>tr', '<cmd>TigOpenProjectRootDir<CR>', { desc = "tig" })
  vim.keymap.set('n', '<Leader>tl', '<cmd>TigOpenCurrentFile<CR>', { desc = "tig logs on current file" })
  vim.keymap.set('n', '<Leader>tb', '<cmd>TigBlame<CR>', { desc = "tig blame" })

  -- Tab management
  vim.keymap.set('n', '<leader>tcl', function() require('functions').tabcloseleft() end,
    { desc = "Close tabs to the left" })
  vim.keymap.set('n', '<leader>tcr', function() require('functions').tabcloseright() end,
    { desc = "Close tabs to the right" })

  -- Ruby documentation
  vim.keymap.set('n', '<leader>y', '<Plug>(doge-generate)', { desc = "Generate documentation" })

  -- Session write and quit
  local function save_session_and_quit()
    local session_file
    local viminfo_file

    if vim.g.proj_file then
      session_file = vim.g.proj_file
      viminfo_file = vim.g.proj_file .. '.viminfo'
    else
      session_file = vim.fn.expand('~/.vim/.vimsession')
      viminfo_file = vim.fn.expand('~/.vim/.viminfo')
    end

    -- Ensure ~/.vim directory exists
    vim.fn.mkdir(vim.fn.expand('~/.vim'), 'p')

    -- Save session and viminfo
    vim.cmd('mksession! ' .. session_file)
    vim.cmd('wviminfo! ' .. viminfo_file)

    -- Quit
    vim.cmd('qa')
  end

  vim.keymap.set('n', '<F10>', save_session_and_quit,
    { desc = "Save session and quit" })

  -- Mail editing (from vimrc)
  vim.keymap.set('n', '<F12>', ':%s/\\(> \\)\\+$//g<CR>',
    { desc = "Clean up quoted email lines" })

  -- Code cleanup
  vim.keymap.set('n', '<leader>ct', ':%s/\\t/    /g<CR>:%s/\\s\\+$//g<CR>',
    { silent = true, desc = "Convert tabs to spaces and trim trailing whitespace" })
  vim.keymap.set('n', '<leader>cs', ':%s/\\s\\+$//g<CR>',
    { silent = true, desc = "Trim trailing whitespace" })
end

return M
