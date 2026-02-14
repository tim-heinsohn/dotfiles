---@diagnostic disable: undefined-global
return {
  -- Finder
  "junegunn/fzf",
  "junegunn/fzf.vim",
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  "francoiscabrol/ranger.vim", -- <Leader>f to run ranger within Vim
  {
    'stevearc/aerial.nvim',
    opts = {},
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
  },

  -- Statusline
  "itchyny/lightline.vim",
  "itchyny/vim-gitbranch",

  -- Diagnostics
  "neovim/nvim-lspconfig",

  -- Colors
  "rebelot/kanagawa.nvim",
  "folke/tokyonight.nvim",
  "EdenEast/nightfox.nvim",

  -- Fonts
  "nvim-tree/nvim-web-devicons",

  -- Git
  {
    "iberianpig/tig-explorer.vim",
    dependencies = { "rbgrouleff/bclose.vim" }
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("git-conflict").setup({
        default_mappings = true,
        default_commands = true,
        disable_diagnostics = false,
        highlights = {
          incoming = 'DiffText',
          current = 'DiffAdd',
        }
      })
    end
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
  },
  {
    "rhysd/committia.vim",
    config = function()
      vim.g.committia_hooks = {}
      vim.g.committia_hooks.edit_open = function(info)
        vim.cmd('wincmd =') -- render all windows almost equally high and wide
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
        vim.opt_local.complete:append("kspell")
      end
    end
  },

  -- Live Share / Instant w/ localhost.run
  {
    "azratul/live-share.nvim",
    dependencies = { "jbyuki/instant.nvim" },
    config = function()
      vim.g.instant_username = "Smileson"
      require("live-share").setup({
        port_internal = 7709,
        max_attempts = 40, -- 10 seconds
        service = "localhost.run"
      })
    end
  },

  -- Files and Buffer
  --"ludovicchabant/vim-gutentags",
  --{
  --  "preservim/tagbar",
  --  keys = {
  --    { "<leader>t", "<cmd>TagbarToggle<CR>", desc = "Toggle Tagbar" }
  --  }
  --},

  -- All Languages
  {
    "tpope/vim-commentary",
    -- gc to comment/uncomment lines
  },
  "godlygeek/tabular",

  -- Markdown
  "preservim/vim-markdown",

  -- Ruby/Rails
  -- "ruby-formatter/rufo-vim",
  "vim-utils/vim-ruby-fold",
  "rlue/vim-fold-rspec",
  -- {
  --   "danchoi/ri.vim",
  --   init = function()
  --     vim.g.ri_no_mappings = 1
  --     vim.keymap.set("n", "<leader>ri", ":call ri#OpenSearchPrompt(0)<CR>", { desc = "Ri Horizontal Split" })
  --     vim.keymap.set("n", "<leader>RI", ":call ri#OpenSearchPrompt(1)<CR>", { desc = "Ri Vertical Split" })
  --     vim.keymap.set("n", "<leader>RK", ":call ri#LookupNameUnderCursor()<CR>", { desc = "Ri Lookup Keyword" })
  --   end
  -- },
  {
    "kkoomen/vim-doge"
  },

  -- Caddy
  "isobit/vim-caddyfile",
}
