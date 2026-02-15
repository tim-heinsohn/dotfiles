local util = require('lspconfig.util')

---@diagnostic disable: undefined-global
local lspconfig = require('lspconfig')
lspconfig.ruby_lsp.setup{}
-- lspconfig.rubocop.setup{}
lspconfig.solargraph.setup{
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby" },
  root_dir = require('lspconfig.util').root_pattern("Gemfile", ".git", "."),
  settings = {
    solargraph = {
      diagnostics = true,
      completion = true,
      definitions = true,
      symbols = true,
      rails = true,
      rspec = true,
    }
  }
}

lspconfig.ansiblels.setup{}
-- TODO: does not work yet
vim.filetype.add({
  pattern = {
    ["**/tasks/*.yaml"] = "yaml.ansible"
  },
})

lspconfig.ts_ls.setup{}
lspconfig.pyright.setup{}
lspconfig.eslint.setup{
  settings = {
    eslint = {
      enable = true,
      packageManager = "npm",
    }
  }
}

lspconfig.bashls.setup{
  filetypes = { "bash", "sh", "zsh" }
}
lspconfig.lua_ls.setup{}

lspconfig.docker_compose_language_service.setup{
  cmd = { "docker-compose-langserver", "--stdio" },
  filetypes = { "yaml.docker-compose" },
  root_dir = util.root_pattern('docker-compose.yaml', 'docker-compose.yml', 'compose.yaml', 'compose.yml'),
  single_file_support = true,
}
-- add filetype detection
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
 pattern = { "docker-compose.yml", "docker-compose.yaml", "compose.yml", "compose.yaml" },
 callback = function()
   vim.bo.filetype = "yaml.docker-compose"
 end,
})
lspconfig.dockerls.setup{}

lspconfig.terraformls.setup{}

vim.diagnostic.config({
  float = {
    show_header = true,
    source = 'always',
    focusable = false,
  }
})
