return {
  -- Package manager itself (no config needed)
  { "folke/lazy.nvim" },

  -- LSP & Mason
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },

  -- Completion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- AI assistance (free)
  { "Exafunction/codeium.nvim",        lazy = false }, -- Codeium (free, no key)
  -- { "David-Kunz/gen.nvim",            lazy = false }, -- optional Ollama (see comment in ai.lua)

  -- UI – Matte black theme (no orange)
  { "EdenEast/nightfox.nvim", priority = 1000 }, -- carbonfox = matte black

  -- Statusline
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

  -- Bufferline (tabs)
  { "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

  -- File explorer (minimal)
  { "stevearc/oil.nvim", opts = {} },

  -- Fuzzy finder
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Git signs
  { "lewis6991/gitsigns.nvim" },

  -- Debugging
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },

  -- Database (PostgreSQL)
  { "tpope/vim-dadbod" },
  { "kristijanhusak/vim-dadbod-ui" },
  { "kristijanhusak/vim-dadbod-completion" },

  -- Jupyter / notebook integration
  { "dccsillag/magma-nvim", run = ":UpdateRemotePlugins", ft = "python" },

  -- Docker / Container support
  { "pocco81/dap-buddy.nvim" },      -- optional DAP helpers
  { "jose-elias-alvarez/null-ls.nvim" }, -- for Dockerfile linting (optional)

  -- Markdown preview
  { "iamcco/markdown-preview.nvim", build = "cd app && npm install", ft = "markdown" },

  {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup()
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
  end,
},

}
