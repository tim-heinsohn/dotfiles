---@diagnostic disable: undefined-global

-- Set leader key before loading any keymaps
vim.g.mapleader = "_"
vim.g.maplocalleader = "\\"

-- Neovim settings migrated from vim/vimrc
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.autochdir = true
vim.opt.exrc = true
vim.opt.secure = true
vim.opt.visualbell = true
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.laststatus = 2
vim.opt.report = 0
vim.opt.ruler = true
vim.opt.mouse = "a"
vim.opt.mousehide = true
vim.opt.scrolloff = 10
vim.opt.shortmess:append("aOstTI")
vim.opt.showcmd = true
vim.opt.sidescrolloff = 10
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.iskeyword:append("_,$,@,%,#")
vim.opt.list = true
vim.opt.listchars = { tab = ">-.", trail = "_" }
vim.opt.startofline = false
vim.opt.shiftwidth = 2
vim.opt.showmatch = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.eol = false
vim.opt.fileformat = "unix"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildignore:append({ ".git", ".svn", "*.bak", "*.jpg", "*.gif", "*.png", "*.pdf" })
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.autoread = true

-- Jump to last position when reopening file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- gopass: disable swap/backup/undo for sensitive files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "/dev/shm/gopass.*",
  callback = function()
    vim.opt_local.swapfile = false
    vim.opt_local.backup = false
    vim.opt_local.undofile = false
  end,
})

-- Ruby/YAML: remove : from iskeyword (inherited from vimrc)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "ruby", "yaml" },
  callback = function()
    vim.opt_local.iskeyword:remove(":")
  end
})

-- Gitcommit: set textwidth and format options
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.formatoptions:append("tcrqnlj1")
  end
})

-- lazy load lazy, the plugin manager
---@see lazy.nvim README https://raw.githubusercontent.com/folke/lazy.nvim/main/README.md
---@see lazy.nvim.usage `:help lazy.nvim-lazy.nvim-usage`
---@see lazy.help `:Lazy help`
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup(require("plugins"))

-- DIAGNOSTICS
-- setup Rubocop as LSP server
---@see rubocop.lsp https://docs.rubocop.org/rubocop/usage/lsp.html#neovim-nvim-lspconfig
vim.opt.signcolumn = "yes"
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "ruby",
--   callback = function()
--     vim.lsp.start {
--       name = "rubocop",
--       cmd = { "rubocop", "--lsp" },
--     }
--   end,
-- })
---@see lspconfig.configs https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

require('lsp_setup')

-- Global settings
vim.opt.isfname:append(".")

-- Ruby settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    vim.opt_local.iskeyword:remove(":")
    vim.opt_local.iskeyword:append("?")
    vim.opt_local.isfname:remove(".")
    vim.opt_local.isfname:append("?")
  end
})

-- Load custom functions
require('functions').setup()

-- Load keymaps
require('keymaps').setup()

-- Enable completion triggered by <c-x><c-o>
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
  end,
})


-- Aerial
require('aerial').setup({
  -- prefer LSP over Treesitter
   backends = { "lsp", "treesitter", "markdown", "man" },
  -- use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- jump forwards/backwards with '{' and '}'
    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
  end,
  -- Show box drawing characters for the tree hierarchy
  show_guides = true,
})

-- Treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = { "ruby", "python" },
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = { enable = true },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
})

-- STATUSLINE
vim.g.lightline = {
  colorscheme = "powerline",
  active = {
    left = {
      { "mode", "past" },
      { "filename", "readonly", "modified", "gitbranch" }
    }
  },
  inactive = {
    left = {
      {},
      { "gitfilename", "modified" }
    }
  },
  component_function = {
    gitbranch = "gitbranch#name",
    gitfilename = "GitFileName"
  }
}


-- COLORS
---@see kanagawa.readme https://github.com/rebelot/kanagawa.nvim#readme
require('kanagawa').setup({
    dimInactive = true,          -- dim inactive window `:h hl-NormalNC`
})
---@see tokyonight https://github.com/folke/tokyonight.nvim

---@todo put note into (post) install script
---@note to remove default color schemes from :colo completion, remove files
--	 from </usr/share/nvim/runtime/colors>

-- kanagwa: setup must be called before loading
vim.cmd("colorscheme kanagawa-wave")
