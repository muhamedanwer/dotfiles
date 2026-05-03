return {

  -- ── Molten — Jupyter kernel inside Neovim ─────────────────
  -- Requirements: sudo pacman -S python-pynvim python-jupyter-client python-cairosvg python-plotly python-kaleido python-pnglatex
  {
    "benlubas/molten-nvim",
    version      = "^1.0.0",
    build        = ":UpdateRemotePlugins",
    ft           = { "python", "jupyter" },
    dependencies = { "3rd/image.nvim" },   -- for image output
    init = function()
      -- Output window settings (matte-black style)
      vim.g.molten_output_win_max_height = 24
      vim.g.molten_output_win_style      = "minimal"
      vim.g.molten_output_win_border     = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
      vim.g.molten_auto_open_output      = true
      vim.g.molten_wrap_output           = true
      vim.g.molten_virt_text_output      = true      -- inline output preview
      vim.g.molten_virt_lines_off_by_1   = true
      vim.g.molten_image_provider        = "image.nvim"
      vim.g.molten_use_border_highlights = true
      vim.g.molten_tick_rate             = 142       -- ~7fps refresh
    end,
  },

  -- Image rendering (for Jupyter plot output)
  {
    "3rd/image.nvim",
    lazy = true,
    config = function()
      require("image").setup({
        backend                       = "kitty",    -- requires kitty terminal
        integrations                  = {
          markdown = { enabled = true },
          neorg    = { enabled = false },
        },
        max_width                     = 100,
        max_height                    = 40,
        max_width_window_percentage   = math.huge,
        max_height_window_percentage  = 50,
        kitty_method                  = "normal",
      })
    end,
  },

  -- ── jupytext: open .ipynb as clean Python ─────────────────
  -- Requires: sudo pacman -S python-jupytext
  {
    "GCBallesteros/jupytext.nvim",
    ft  = "ipynb",
    config = function()
      require("jupytext").setup({
        style         = "hydrogen",      -- # %% cell markers
        output_extension = "py",
        force_ft      = "python",
      })
    end,
  },

  -- ── NotebookNavigator (cell navigation) ──────────────────
  {
    "GCBallesteros/NotebookNavigator.nvim",
    dependencies = { "benlubas/molten-nvim", "echasnovski/mini.ai" },
    ft  = { "python", "jupyter" },
    config = function()
      local nn = require("notebook-navigator")
      nn.setup()
      vim.keymap.set("n", "]c", function() nn.move_cell("d") end, { desc = "Next cell" })
      vim.keymap.set("n", "[c", function() nn.move_cell("u") end, { desc = "Prev cell" })
      vim.keymap.set("n", "<leader>jc", nn.run_cell,          { desc = "Run cell" })
      vim.keymap.set("n", "<leader>jC", function()
        require("notebook-navigator").run_cells_below()
      end, { desc = "Run cells below" })
      vim.keymap.set("n", "<leader>jA", nn.run_all_cells,     { desc = "Run all cells" })
    end,
  },

}
