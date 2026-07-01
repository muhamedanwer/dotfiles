require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = { "pyright", "clangd", "rust_analyzer", "r_language_server", "yamlls", "bashls", "jsonls", "taplo", "sqlls", "dockerls" },
  automatic_installation = true,
})

local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

local function make_lsp_opts(server)
  local opts = { capabilities = capabilities }
  if server == "pyright" then
    opts.settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
        },
      },
    }
  elseif server == "clangd" then
    opts.cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed", "--header-insertion=iwyu" }
  elseif server == "rust_analyzer" then
    opts.settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        checkOnSave = { command = "clippy" },
        procMacro = { enable = true },
      },
    }
  elseif server == "yamlls" then
    opts.settings = {
      yaml = {
        schemas = {
          ["https://raw.githubusercontent.com/dbt-labs/dbt-jsonschema/main/schemas/dbt.yml"] = "dbt_project.yml",
          ["https://raw.githubusercontent.com/airflow/apache-airflow/main/airflow/config_templates/airflow.cfg"] = "airflow.cfg",
        },
      },
    }
  end
  return opts
end

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, noremap = true, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
  end,
})

-- nvim-cmp
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
  }, {
    { name = "buffer" },
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

-- Use cmdline & path source for ':' and '/'
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = "buffer" } },
})
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

-- LSP configurations: use mason-lspconfig handlers to avoid requiring the
-- deprecated `lspconfig` framework directly. This defers setup until
-- mason has registered the server and prevents deprecation warnings.
if type(mason_lspconfig.setup_handlers) == "function" then
  mason_lspconfig.setup_handlers({
    function(server_name)
      local ok, opts = pcall(make_lsp_opts, server_name)
      if not ok then
        opts = {}
      end

      if vim.lsp.config and vim.lsp.config[server_name] and type(vim.lsp.config[server_name].setup) == "function" then
        vim.lsp.config[server_name].setup(opts)
      else
        vim.notify(string.format("LSP: no setup function for %s (skipping)", server_name), vim.log.levels.WARN)
      end
    end,
  })
else
  -- Fallback: mason-lspconfig doesn't provide setup_handlers (older version).
  -- Configure known servers directly; try vim.lsp.config first, then lspconfig.
  local fallback_servers = { "pyright", "bashls", "clangd", "jsonls", "taplo", "sqlls", "dockerls", "rust_analyzer", "yamlls", "r_language_server" }
  for _, server_name in ipairs(fallback_servers) do
    local ok, opts = pcall(make_lsp_opts, server_name)
    if not ok then opts = {} end

    local handled = false
    if vim.lsp.config and vim.lsp.config[server_name] and type(vim.lsp.config[server_name].setup) == "function" then
      pcall(vim.lsp.config[server_name].setup, opts)
      handled = true
    else
      -- No compatible handler available; skip and warn. Upgrading
      -- `mason-lspconfig` or `nvim-lspconfig` (or Neovim) will enable
      -- proper setup via `mason_lspconfig.setup_handlers`.
    end

    if not handled then
      vim.notify(string.format("LSP: could not setup %s (no handler)", server_name), vim.log.levels.WARN)
    end
  end
end

-- conform.nvim (auto-format)
require("conform").setup({
  formatters_by_ft = {
    python = { "ruff_format", "ruff_fix" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    rust = { "rustfmt" },
    r = { "styler" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    yaml = { "prettier" },
    json = { "prettier" },
    markdown = { "prettier" },
    sql = { "prettier" },
    dockerfile = { "prettier" },
    toml = { "taplo" },
  },
  format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
})

-- Diagnostic config
vim.diagnostic.config({
  virtual_text = { prefix = "●" },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded" },
})