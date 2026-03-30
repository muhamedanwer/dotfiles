return {
  -- PostgreSQL / DB client
  { "tpope/vim-dadbod" },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod", "kristijanhusak/vim-dadbod-completion" },
    config = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.keymap.set("n", "<leader>db", ":DBUIToggle<CR>")
    end,
  },
  -- Completion for SQL (already included in cmp sources)
  { "kristijanhusak/vim-dadbod-completion" },

  -- Jupyter / Magma (disabled to avoid conflict with jupytext+slime)
  -- {
  --   "dccsillag/magma-nvim",
  --   run = ":UpdateRemotePlugins",
  --   ft = { "python", "julia" },
  --   config = function()
  --     vim.keymap.set("n", "<leader>mr", ":MagmaEvaluateOperator<CR>")
  --     vim.keymap.set("n", "<leader>ms", ":MagmaEvaluateLine<CR>")
  --     vim.keymap.set("v", "<leader>m", ":MagmaEvaluateVisual<CR>")
  --   end,
  -- },

  -- Dockerfile support (syntax + LSP)
  {
    "pocco81/dap-buddy.nvim",   -- optional
    ft = "dockerfile",
  },
}
