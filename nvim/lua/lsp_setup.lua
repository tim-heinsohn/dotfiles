---@diagnostic disable: undefined-global

vim.lsp.config('solargraph', {
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby" },
  root_markers = { "Gemfile", ".git" },
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
})

-- TODO: does not work yet
vim.filetype.add({
  pattern = {
    ["**/tasks/*.yaml"] = "yaml.ansible"
  },
})

vim.lsp.config('eslint', {
  settings = {
    eslint = {
      enable = true,
      packageManager = "npm",
    }
  }
})

vim.lsp.config('bashls', {
  filetypes = { "bash", "sh", "zsh" }
})

vim.lsp.config('docker_compose_language_service', {
  cmd = { "docker-compose-langserver", "--stdio" },
  filetypes = { "yaml.docker-compose" },
  root_markers = { 'docker-compose.yaml', 'docker-compose.yml', 'compose.yaml', 'compose.yml' },
})
-- add filetype detection
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
 pattern = { "docker-compose.yml", "docker-compose.yaml", "compose.yml", "compose.yaml" },
 callback = function()
   vim.bo.filetype = "yaml.docker-compose"
 end,
})

vim.lsp.enable({
  'ruby_lsp',
  -- 'rubocop',
  'solargraph',
  'ansiblels',
  'ts_ls',
  'pyright',
  'eslint',
  'bashls',
  'lua_ls',
  'docker_compose_language_service',
  'dockerls',
  'terraformls',
})

vim.diagnostic.config({
  float = {
    show_header = true,
    source = 'always',
    focusable = false,
  }
})
