return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        rust = { "rustfmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        java = { "google-java-format" },
        sql = { "sqlfmt" },      -- optional
        markdown = { "prettier" },
      },
      format_on_save = { timeout_ms = 500 },
    },
    config = function(_, opts)
      require("conform").setup(opts)
      vim.keymap.set("n", "<leader>f", function() require("conform").format() end, { desc = "Format buffer" })
    end,
  },
}
