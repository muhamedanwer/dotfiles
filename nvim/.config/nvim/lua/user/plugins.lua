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
        extensions = {
          fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case" },
          live_grep_args = { auto_quoting = true },
        },
      })
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("live_grep_args")
      local builtin = require("telescope.builtin")
      local extensions = require("telescope").extensions
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", extensions.live_grep_args.live_grep_args, { desc = "Live grep (args)" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
      vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "LSP references" })
      vim.keymap.set("n", "<leader>fd", builtin.lsp_document_symbols, { desc = "Document symbols" })
      vim.keymap.set("n", "<leader>fw", builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })
    end
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "folke/tokyonight.nvim", lazy = false, config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = "dark",
          floats = "dark",
        },
        sidebars = { "qf", "help", "terminal", "lazy", "mason", "neo-tree" },
        on_colors = function(colors)
          colors.bg = "#0a0a0a"
          colors.bg_dark = "#080808"
          colors.bg_float = "#0d0d0d"
          colors.bg_highlight = "#151515"
          colors.bg_popup = "#0d0d0d"
          colors.bg_search = "#252525"
          colors.bg_sidebar = "#0a0a0a"
          colors.bg_statusline = "#0a0a0a"
          colors.bg_visual = "#1a1a1a"
          colors.border = "#1a1a1a"
          colors.fg = "#c0c0c0"
          colors.comment = "#505050"
        end,
      })
    end
  },
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
        " █████╗  ███╗   ██╗██╗ ███╗   ██╗ █████╗ ██████╗ ",
        "██╔══██╗ ████╗  ██║██║ ████╗  ██║██╔══██╗██╔══██╗",
        "███████║ ██╔██╗ ██║██║ ██╔██╗ ██║███████║██████╔╝",
        "██╔══██║ ██║╚██╗██║██║ ██║╚██╗██║██╔══██║██╔══██╗",
        "██║  ██║ ██║ ╚████║██║ ██║ ╚████║██║  ██║██║  ██║",
        "╚═╝  ╚═╝ ╚═╝  ╚═══╝╚═╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═╝",
        "",
        "  Neovim IDE ready • <leader>ff to find files",
      }
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
        dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", "  Find text", ":Telescope live_grep_args <CR>"),
        dashboard.button("e", "  File explorer", ":NvimTreeToggle <CR>"),
        dashboard.button("p", "  Projects", ":Telescope find_files <CR>"),
        dashboard.button("s", "  Settings", ":e $MYVIMRC <CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }
      dashboard.section.footer.val = "Neovim IDE • <leader>ff to find files"
      dashboard.config.opts.noautocmd = true
      alpha.setup(dashboard.config)
    end,
  },

  -- Session persistence
  { "folke/persistence.nvim", event = "BufReadPre", config = true },

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

  -- Enhanced LSP UX
  { "rachartier/tiny-inline-diagnostic.nvim", event = "LspAttach", config = true },
  { "ray-x/lsp_signature.nvim", event = "LspAttach", config = true },

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
  { "tpope/vim-rhubarb" },
  { "sindrets/diffview.nvim", cmd = { "DiffviewOpen", "DiffviewFileHistory" } },
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
  { "folke/noice.nvim", event = "VeryLazy", dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" }, config = function()
      require("noice").setup({
        lsp = { override = { ["vim.lsp.util.convert_input_to_markdown_lines"] = true, ["vim.lsp.util.stylize_markdown"] = true, ["cmp.entry.get_documentation"] = true } },
        presets = { bottom_search = true, command_palette = true, long_message_to_split = true, inc_rename = false, lsp_doc_border = true },
        views = { cmdline_popup = { border = { style = "rounded" }, position = { row = 5, col = "50%" } } },
      })
    end
  },

  -- Indent guides & folding
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async", event = "BufReadPost", config = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      require("ufo").setup({ provider_selector = function() return { "treesitter", "indent" } end })
    end
  },
  { "nvim-treesitter/nvim-treesitter-context", config = true },
  { "nvim-treesitter/nvim-treesitter-textobjects" },

  -- Navigation
  { "ThePrimeagen/harpoon", branch = "harpoon2", dependencies = "nvim-lua/plenary.nvim", config = true },
  { "akinsho/toggleterm.nvim", version = "*", config = true },

  -- File explorer
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({ view = { width = 30 }, renderer = { group_empty = true } })
    end,
    keys = { { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" } }
  },

  { "mbbill/undotree" },
}, { checker = { enabled = true } })

vim.cmd.colorscheme("tokyonight")