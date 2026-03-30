return {
  -- Matte-black theme (carbonfox) with transparency
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,        -- ← CHANGE THIS to true
          terminal_colors = true,
          styles = { comments = "italic", conditionals = "NONE" },
        },
        palettes = {
          carbonfox = {
            orange = "#1E1E1E",   -- kill orange by hiding it
            orange_bright = "#2A2A2A",
          },
        },
      })
      vim.cmd.colorscheme("carbonfox")
    end,
  },

  -- Lualine (statusline) – will inherit transparency automatically
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { theme = "carbonfox" },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Bufferline – also transparent by default when background is clear
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        offsets = { { filetype = "oil", text = "", padding = 1 } },
        color_icons = true,
        themable = true,
      },
    },
  },
}
