local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Core
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    opts = {
      ensure_installed = { "lua", "python", "c", "cpp", "rust", "r", "help", "bash", "dockerfile", "yaml", "json", "toml", "sql", "markdown", "markdown_inline" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        pickers = { find_files = { hidden = true } },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
      vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "LSP references" })
      vim.keymap.set("n", "<leader>fd", builtin.lsp_document_symbols, { desc = "Document symbols" })
      vim.keymap.set("n", "<leader>fw", builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })
    end
  },
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({ options = { theme = "auto" } })
    end
  },

  -- Dashboard
  { "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        "    _   _   _   _   _   _   _   _   _",
        "   / \\ / \\ / \\ / \\ / \\ / \\ / \\ / \\ / \\",
        "  ( A | n | w | a | r )",
        "   \\_/ \\_/ \\_/ \\_/ \\_/ \\_/ \\_/ \\_/ \\_/",
      }
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
        dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", "  Find text", ":Telescope live_grep <CR>"),
        dashboard.button("e", "  File explorer", ":NvimTreeToggle <CR>"),
        dashboard.button("p", "  Projects", ":Telescope projects <CR>"),
        dashboard.button("s", "  Settings", ":e $MYVIMRC <CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }
      dashboard.section.footer.val = "Neovim IDE • <leader>ff to find files"
      dashboard.config.opts.noautocmd = true
      alpha.setup(dashboard.config)
    end,
  },

  -- LSP & Mason
  { "williamboman/mason.nvim", build = ":MasonUpdate" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "saadparwaiz1/cmp_luasnip" },
  { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
  { "rafamadriz/friendly-snippets" },
  { "stevearc/conform.nvim" },

  -- Python
  { "mfussenegger/nvim-dap-python" },
  { "linux-cultist/venv-selector.nvim", dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" }, ft = "python",
    config = function() require("venv-selector").setup() end,
    keys = { { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select venv" } }
  },
  { "nvim-neotest/neotest", dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter", "nvim-neotest/neotest-python" },
    config = function() require("neotest").setup({ adapters = { require("neotest-python") } }) end,
    keys = { { "<leader>tt", function() require("neotest").run.run() end, desc = "Run test" } }
  },

  -- Rust
  { "mrcjkb/rustaceanvim", version = "^5", ft = { "rust" } },
  { "Saecki/crates.nvim", ft = { "rust", "toml" }, config = true },

  -- C/C++
  { "p00f/clangd_extensions.nvim", ft = { "c", "cpp" } },

  -- Database
  { "tpope/vim-dadbod" },
  { "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_force_echo_notifications = 1
    end,
  },
  { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },

  -- Markdown
  { "iamcco/markdown-preview.nvim", build = "cd app && yarn install", ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_browser = ""
      vim.g.mkdp_theme = "dark"
    end
  },
  { "MeanderingProgrammer/render-markdown.nvim", ft = "markdown", dependencies = { "nvim-treesitter/nvim-treesitter" }, config = true },

  -- Git
  { "tpope/vim-fugitive" },
  { "lewis6991/gitsigns.nvim", config = true },

  -- Debugging
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
  { "theHamsta/nvim-dap-virtual-text", config = true },

  -- AI
  { "olimorris/codecompanion.nvim", dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" } },

  -- UI/UX
  { "folke/zen-mode.nvim",
    opts = { window = { backdrop = 0.95, width = 120, height = 1 } },
    cmd = "ZenMode",
  },
  { "folke/which-key.nvim", event = "VeryLazy", config = true },
  { "numToStr/Comment.nvim", config = true },
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
  { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = true },

  -- File explorer
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({ view = { width = 30 }, renderer = { group_empty = true } })
    end,
    keys = { { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" } }
  },

  { "mbbill/undotree" },
}, { checker = { enabled = true } })

vim.cmd.colorscheme("matteblack")