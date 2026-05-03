return {

  -- ── Mason (LSP installer) ─────────────────────────────────
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons  = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
        },
      })
    end,
  },

  -- ── Mason-LSPConfig bridge ────────────────────────────────
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",      -- Python
          "ruff",         -- Python linter/formatter
          -- "sqls",       -- SQL — requires `go` installed system-wide
          "texlab",       -- LaTeX
          "marksman",     -- Markdown
          "jsonls",       -- JSON
          "yamlls",       -- YAML
          "taplo",        -- TOML
          "bashls",       -- Shell scripts
          "lua_ls",       -- Lua (for editing this config)
        },
        automatic_installation = true,
        -- Use new vim.lsp.enable handler (Nvim 0.11+)
        handlers = {
          function(server_name)
            vim.lsp.enable(server_name)
          end,
        },
      })
    end,
  },

  -- ── LSP Config (Nvim 0.11+ vim.lsp API) ──────────────────
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Shared on_attach for all servers
      vim.lsp.config("*", {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          local buf = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end
          buf("n", "gd",         vim.lsp.buf.definition,                "Go to definition")
          buf("n", "gD",         vim.lsp.buf.declaration,               "Go to declaration")
          buf("n", "gi",         vim.lsp.buf.implementation,            "Go to implementation")
          buf("n", "gr",         "<cmd>Telescope lsp_references<CR>",   "References")
          buf("n", "K",          vim.lsp.buf.hover,                     "Hover docs")
          buf("n", "<leader>la", vim.lsp.buf.code_action,               "Code action")
          buf("n", "<leader>lr", vim.lsp.buf.rename,                    "Rename")
          buf("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format")

          -- Show diagnostics in float on cursor hold
          vim.api.nvim_create_autocmd("CursorHold", {
            buffer   = bufnr,
            callback = function()
              vim.diagnostic.open_float({ border = "rounded" })
            end,
          })
        end,
      })

      -- Diagnostic display
      vim.diagnostic.config({
        virtual_text  = { prefix = "●", source = "if_many" },
        signs         = {
          text = {
            [vim.diagnostic.severity.ERROR]   = " ",
            [vim.diagnostic.severity.WARN]    = " ",
            [vim.diagnostic.severity.HINT]    = "󰌵 ",
            [vim.diagnostic.severity.INFO]    = " ",
          },
        },
        underline     = true,
        update_in_insert = false,
        severity_sort = true,
        float         = { border = "rounded", source = "always" },
      })

      -- ── Python ────────────────────────────────────────────
      vim.lsp.config("pyright", {
        settings = {
          python = {
            analysis = {
              autoImportCompletions    = true,
              autoSearchPaths          = true,
              diagnosticMode           = "workspace",
              typeCheckingMode         = "basic",
              useLibraryCodeForTypes   = true,
            },
          },
        },
      })

      -- Ruff (fast Python linter/formatter)
      vim.lsp.config("ruff", {
        on_attach = function(client, bufnr)
          client.server_capabilities.hoverProvider = false
        end,
        init_options = {
          settings = { args = { "--line-length=88" } },
        },
      })

      -- ── SQL ───────────────────────────────────────────────
      vim.lsp.config("sqls", {
        settings = {
          sqls = {
            connections = {
              -- Add your database connections here:
              -- { driver = "postgresql", dataSourceName = "host=localhost dbname=mydb sslmode=disable" },
              -- { driver = "mysql",      dataSourceName = "root:password@tcp(localhost:3306)/mydb" },
              -- { driver = "sqlite3",    dataSourceName = "/path/to/db.sqlite3" },
            },
          },
        },
      })

      -- ── LaTeX ─────────────────────────────────────────────
      vim.lsp.config("texlab", {
        settings = {
          texlab = {
            build = {
              executable   = "latexmk",
              args         = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
              onSave       = true,
              forwardSearchAfter = true,
            },
            forwardSearch = {
              executable   = "zathura",
              args         = { "--synctex-forward", "%l:1:%f", "%p" },
            },
            chktex    = { onEdit = true, onOpenAndSave = true },
            latexindent = { modifyLineBreaks = false },
          },
        },
      })

      -- ── Lua (for editing this config) ─────────────────────
      vim.lsp.config("lua_ls", {
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
      })

      -- ── Enable all servers (filetype-based activation) ────
      vim.lsp.enable({
        "pyright",
        "ruff",
        -- "sqls",  -- requires `go` installed system-wide
        "texlab",
        "marksman",
        "jsonls",
        "yamlls",
        "taplo",
        "bashls",
        "lua_ls",
      })
    end,
  },

  -- ── Trouble (diagnostics panel) ──────────────────────────
  {
    "folke/trouble.nvim",
    cmd  = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble<CR>",                       desc = "Toggle trouble" },
      { "<leader>xw", "<cmd>Trouble diagnostics<CR>",            desc = "Workspace diag" },
      { "<leader>xd", "<cmd>Trouble diagnostics filter.buf=0<CR>", desc = "Document diag" },
    },
    config = function()
      require("trouble").setup({})
    end,
  },

}
