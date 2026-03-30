return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("which-key").setup(opts)
      -- Optional: register your leader prefix
      local wk = require("which-key")
      wk.add({
        { "<leader>", group = "User" },
      })
    end,
  },
}
