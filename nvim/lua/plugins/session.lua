return {
  {
    "rmagatti/auto-session",
    opts = {
      log_level = "error",
      auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
      auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
      auto_session_enable_last_session = true,
      auto_save_enabled = true,
    },
    config = function(_, opts)
      require("auto-session").setup(opts)
      vim.keymap.set("n", "<leader>ws", require("auto-session").SaveSession, { desc = "Save session" })
      vim.keymap.set("n", "<leader>wr", require("auto-session").RestoreSession, { desc = "Restore session" })
    end,
  },
}
