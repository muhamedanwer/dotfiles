return {
  -- Telescope (fuzzy finder)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
    end,
  },

  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = { add = { text = "▎" }, change = { text = "▎" }, delete = { text = "" } },
      current_line_blame = false,
    },
  },

  -- Debugging (nvim-dap)
  {
    "mfussenegger/nvim-dap",
    config = function()
      vim.keymap.set("n", "<F5>", require("dap").continue)
      vim.keymap.set("n", "<F10>", require("dap").step_over)
      vim.keymap.set("n", "<F11>", require("dap").step_into)
      vim.keymap.set("n", "<F12>", require("dap").step_out)
      vim.keymap.set("n", "<leader>b", require("dap").toggle_breakpoint)
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
      vim.keymap.set("n", "<leader>du", require("dapui").toggle)
    end,
  },
}