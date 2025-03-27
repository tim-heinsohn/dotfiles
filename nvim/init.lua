---@diagnostic disable: undefined-global

-- Set leader key before loading any keymaps
vim.g.mapleader = "_"
vim.g.maplocalleader = "\\"

-- source existing ~/.vimrc
vim.cmd('source ~/.vimrc')

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
  ensure_installed = { "ruby" },
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
