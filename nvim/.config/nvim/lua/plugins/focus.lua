-- Focus/Zen plugins for Neovim
-- ~/.config/nvim/lua/plugins/focus.lua

return {
  -- Zen Mode - Distraction free coding
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
    opts = {
      window = {
        backdrop = 0.95,
        width = 0.6,
        height = 0.9,
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = "0",
          list = false,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = true },
        kitty = { enabled = true, font = "+4" },
      },
      on_open = function()
        if vim.fn.filereadable("/tmp/hypr-focus-mode") == 0 then
          vim.fn.system("~/.config/hypr/scripts/focus-mode.sh")
        end
      end,
      on_close = function()
        if vim.fn.filereadable("/tmp/hypr-focus-mode") == 1 then
          vim.fn.system("~/.config/hypr/scripts/focus-mode.sh")
        end
      end,
    },
  },

  -- Twilight - Dim inactive code
  {
    "folke/twilight.nvim",
    cmd = "Twilight",
    keys = {
      { "<leader>tw", "<cmd>Twilight<cr>", desc = "Twilight" },
    },
    opts = {
      dimming = {
        alpha = 0.35,
        color = { "Normal", "#0a0a0a" },
        term_bg = "#0a0a0a",
        inactive = true,
      },
      context = 10,
      treesitter = true,
      expand = {
        "function",
        "method",
        "table",
        "if_statement",
        "for_statement",
        "while_statement",
        "switch_statement",
        "try_statement",
        "catch_clause",
      },
      exclude = {},
    },
  },

  -- Focus mode toggle (integrates with system focus mode)
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>Z", function()
          local zen = require("zen-mode")
          if zen.view and zen.view.win and vim.api.nvim_win_is_valid(zen.view.win) then
            zen.close()
          else
            zen.open()
          end
        end, desc = "Toggle Zen Mode" },
    },
  },
}