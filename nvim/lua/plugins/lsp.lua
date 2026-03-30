-- lsp.lua – Robust LSP configuration for Neovim 0.11+
-- Uses the new vim.lsp.config API (no deprecation warnings)

return {
  -- 1. Mason: install and manage LSP servers, formatters, etc.
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        -- LSP servers
        "pyright", "rust-analyzer", "clangd", "jdtls", "sqls",
        "dockerfile-language-server", "lua-language-server",
        -- Formatters & debuggers
        "stylua", "black", "debugpy", "codelldb",
      },
    },
  },

  -- 2. Bridge between Mason and LSP: ensures servers are installed and configured.
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      automatic_installation = true,
      -- Names must match those in lspconfig (e.g., rust_analyzer, not rust-analyzer)
      ensure_installed = {
        "pyright",
        "rust_analyzer",
        "clangd",
        "jdtls",
        "sqls",
        "dockerls",
        "lua_ls",
      },
    },
  },

  -- 3. LSP configuration using Neovim's built‑in vim.lsp.config API
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      -- Optional: add cmp capabilities if nvim-cmp is present
      local has_cmp, cmp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      if has_cmp then
        capabilities = cmp.default_capabilities(capabilities)
      end

      -- Define the on_attach function that attaches keymaps and buffer‑local settings
      local function on_attach(client, bufnr)
        -- Disable formatting if you want to use a dedicated formatter like conform.nvim
        -- client.server_capabilities.documentFormattingProvider = false

        local opts = { buffer = bufnr, remap = false }

        -- Standard LSP keymaps
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

        -- Diagnostics navigation
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)

        -- Formatting
        vim.keymap.set("n", "<leader>lf", function()
          vim.lsp.buf.format({ async = true })
        end, opts)

        -- Inlay hints (if supported)
        if client.server_capabilities.inlayHintProvider then
          vim.keymap.set("n", "<leader>lh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
          end, opts)
        end
      end

      -- Global LSP configuration applied to every server
      vim.lsp.config("*", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- List of servers to enable (must match the ensure_installed list above)
      local servers = {
        "pyright",
        "rust_analyzer",
        "clangd",
        "jdtls",
        "sqls",
        "dockerls",
        "lua_ls",
      }

      -- Enable all servers – this starts them automatically when a relevant file is opened
      vim.lsp.enable(servers)

      -- Configure mason-lspconfig to automatically install missing servers
      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_installation = true,
      })
    end,
  },

  -- 4. Completion engine (nvim-cmp)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "kristijanhusak/vim-dadbod-completion", -- SQL completion
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
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
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "dadbod" },
        }),
      })
    end,
  },

  -- 5. Treesitter for syntax highlighting (optional but recommended)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "rust", "python", "java", "sql", "dockerfile", "lua", "markdown" },
        auto_install = true,
        highlight = { enable = true },
      })
    end,
  },
}
