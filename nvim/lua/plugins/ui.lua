return {

  -- ── Theme: VSCode Dark+ (matte-black) ─────────────────────
  {
    "Mofiqul/vscode.nvim",
    lazy    = false,
    priority = 1000,
    config  = function()
      local c = require("vscode.colors").get_colors()
      require("vscode").setup({
        style                      = "dark",
        transparent                = false,
        italic_comments            = true,
        disable_nvimtree_bg        = true,
        color_overrides = {
          -- Pure matte-black background (no blue tint)
          vscBack       = "#0d0d0d",
          vscLeftDark   = "#111111",
          vscLeftMid    = "#1a1a1a",
          vscTabCurrent = "#1e1e1e",
          vscTabOther   = "#111111",
          vscTabOutside = "#0d0d0d",
          vscPopupBack  = "#141414",
          vscSplitLight = "#2a2a2a",
          vscSplitThumb = "#424242",
          vscCursorDark = "#1a1a1a",
        },
        group_overrides = {
          -- Slightly brighter identifiers for clarity
          Identifier     = { fg = c.vscLightBlue,  bg = "NONE" },
          Comment        = { fg = "#6a737d",        italic = true },
          LineNr         = { fg = "#404040" },
          CursorLineNr   = { fg = "#c6c6c6",        bold = true },
          FloatBorder    = { fg = "#444444",         bg = "#141414" },
          NormalFloat    = { bg = "#141414" },
          Pmenu          = { bg = "#1a1a1a" },
          PmenuSel       = { bg = "#264f78",         fg = "#ffffff" },
          WinSeparator   = { fg = "#333333" },
        },
      })
      vim.cmd("colorscheme vscode")
    end,
  },

  -- ── Statusline ────────────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local vscode_colors = {
        bg       = "#111111",
        fg       = "#c6c6c6",
        blue     = "#4fc1ff",
        green    = "#4ec994",
        red      = "#f44747",
        yellow   = "#ffcc00",
        purple   = "#c586c0",
        orange   = "#ce9178",
        darkgray = "#3c3c3c",
      }
      require("lualine").setup({
        options = {
          theme = {
            normal   = { a = { bg = vscode_colors.blue,   fg = "#0d0d0d", gui = "bold" },
                         b = { bg = vscode_colors.darkgray, fg = vscode_colors.fg },
                         c = { bg = vscode_colors.bg,      fg = vscode_colors.fg } },
            insert   = { a = { bg = vscode_colors.green,  fg = "#0d0d0d", gui = "bold" } },
            visual   = { a = { bg = vscode_colors.purple, fg = "#0d0d0d", gui = "bold" } },
            replace  = { a = { bg = vscode_colors.red,    fg = "#0d0d0d", gui = "bold" } },
            command  = { a = { bg = vscode_colors.yellow, fg = "#0d0d0d", gui = "bold" } },
            inactive = { a = { bg = vscode_colors.bg,     fg = vscode_colors.darkgray } },
          },
          component_separators = "",
          section_separators   = { left = "", right = "" },
          globalstatus         = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            { "filename", path = 1, symbols = { modified = " ●", readonly = " ", unnamed = " [No Name]" } },
          },
          lualine_x = {
            { function() return vim.fn["codeium#GetStatusString"]() end, color = { fg = "#4fc1ff" } },
            "encoding", "fileformat",
            { "filetype", icon_only = true },
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- ── Bufferline (tabs) ─────────────────────────────────────
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode              = "buffers",
          separator_style   = "slant",
          show_buffer_close_icons = true,
          show_close_icon   = false,
          color_icons       = true,
          diagnostics       = "nvim_lsp",
          diagnostics_indicator = function(_, _, diag)
            local icons = { error = " ", warning = " " }
            return (diag.error and icons.error .. diag.error or "")
              .. (diag.warning and icons.warning .. diag.warning or "")
          end,
          offsets = {
            { filetype = "NvimTree", text = "  Explorer", highlight = "Directory", separator = true }
          },
        },
        highlights = {
          fill                = { bg = "#0d0d0d" },
          background          = { bg = "#111111", fg = "#555555" },
          tab_selected        = { bg = "#1e1e1e", fg = "#c6c6c6", bold = true },
          buffer_selected     = { bg = "#1e1e1e", fg = "#ffffff", bold = true },
          separator           = { bg = "#111111", fg = "#0d0d0d" },
          separator_selected  = { bg = "#1e1e1e", fg = "#0d0d0d" },
          indicator_selected  = { fg = "#4fc1ff" },
        },
      })
    end,
  },

  -- ── File Explorer ─────────────────────────────────────────
  {
    "nvim-tree/nvim-tree.lua",
    cmd  = { "NvimTreeToggle", "NvimTreeFocus" },
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-tree").setup({
        view            = { width = 32, side = "left" },
        renderer = {
          highlight_git    = true,
          group_empty      = true,
          indent_markers   = { enable = true },
          icons = {
            glyphs = {
              default  = "",
              symlink  = "",
              folder   = { default = "", open = "", empty = "", empty_open = "" },
            },
          },
        },
        filters         = { dotfiles = false },
        git             = { enable = true, ignore = false },
        actions = {
          open_file = { quit_on_open = false, resize_window = true },
        },
      })
    end,
  },

  -- ── Dashboard ─────────────────────────────────────────────
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha  = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        "                                                ",
        "  ██████╗  █████╗ ████████╗ █████╗             ",
        "  ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗            ",
        "  ██║  ██║███████║   ██║   ███████║            ",
        "  ██║  ██║██╔══██║   ██║   ██╔══██║            ",
        "  ██████╔╝██║  ██║   ██║   ██║  ██║            ",
        "  ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝            ",
        "     AI & Data Engineering — Neovim            ",
        "                                                ",
      }
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file",     "<cmd>Telescope find_files<CR>"),
        dashboard.button("r", "  Recent files",  "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("g", "  Live grep",     "<cmd>Telescope live_grep<CR>"),
        dashboard.button("p", "  Projects",      "<cmd>Telescope projects<CR>"),
        dashboard.button("n", "  New file",      "<cmd>enew<CR>"),
        dashboard.button("l", "  Lazy plugins",  "<cmd>Lazy<CR>"),
        dashboard.button("q", "  Quit",          "<cmd>qa<CR>"),
      }
      alpha.setup(dashboard.opts)
    end,
  },

  -- ── Indent guides ─────────────────────────────────────────
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    main  = "ibl",
    config = function()
      require("ibl").setup({
        indent  = { char = "│", highlight = "IblIndent" },
        scope   = { enabled = true, highlight = "IblScope" },
      })
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#222222" })
      vim.api.nvim_set_hl(0, "IblScope",  { fg = "#3c3c3c" })
    end,
  },

  -- ── Zen mode ──────────────────────────────────────────────
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = function()
      require("zen-mode").setup({
        window = { width = 100, options = { number = true } },
        plugins = { tmux = { enabled = true } },
      })
    end,
  },

  -- ── Which-key (keybinding hints) ─────────────────────────
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({ win = { border = "rounded" } })
      wk.add({
        { "<leader>a",  group = "AI" },
        { "<leader>d",  group = "Database" },
        { "<leader>f",  group = "Find" },
        { "<leader>j",  group = "Jupyter" },
        { "<leader>l",  group = "LaTeX / LSP" },
        { "<leader>m",  group = "Markdown" },
        { "<leader>p",  group = "Python / PDF" },
        { "<leader>s",  group = "Split" },
      })
    end,
  },

  -- ── Notifications ─────────────────────────────────────────
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      require("notify").setup({
        background_colour = "#0d0d0d",
        stages            = "slide",
        timeout           = 3000,
        render            = "compact",
      })
      vim.notify = require("notify")
    end,
  },

  -- ── Better UI for select/input ────────────────────────────
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup({ input = { border = "rounded" } })
    end,
  },

  -- ── Colour highlighter ────────────────────────────────────
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPost",
    config = function()
      require("colorizer").setup({
        user_default_options = { mode = "background", tailwind = true },
      })
    end,
  },

}
