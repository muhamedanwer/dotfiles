-- Matte Black Theme for LazyVim
-- ~/.config/nvim/lua/plugins/theme.lua

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = { "qf", "help", "terminal", "lazy", "mason", "neo-tree" },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = false,
      on_colors = function(colors)
        -- Matte Black Palette
        colors.bg = "#0a0a0a"
        colors.bg_dark = "#080808"
        colors.bg_float = "#0d0d0d"
        colors.bg_highlight = "#151515"
        colors.bg_popup = "#0d0d0d"
        colors.bg_search = "#252525"
        colors.bg_sidebar = "#0a0a0a"
        colors.bg_statusline = "#0a0a0a"
        colors.bg_visual = "#1a1a1a"
        colors.border = "#1a1a1a"
        colors.fg = "#c0c0c0"
        colors.fg_dark = "#909090"
        colors.fg_gutter = "#404040"
        colors.comment = "#505050"
        colors.black = "#0a0a0a"
        colors.blue = "#70a0d0"
        colors.cyan = "#60b0c0"
        colors.green = "#70a070"
        colors.magenta = "#b070b0"
        colors.orange = "#d0a060"
        colors.purple = "#a070d0"
        colors.red = "#d06060"
        colors.teal = "#50b0a0"
        colors.yellow = "#d0c060"
        colors.git = {
          add = "#70a070",
          change = "#d0a060",
          delete = "#d06060",
        }
      end,
      on_highlights = function(hl, c)
        -- Editor
        hl.Normal = { fg = c.fg, bg = c.bg }
        hl.NormalFloat = { fg = c.fg, bg = c.bg_float }
        hl.NormalNC = { fg = c.fg_dark, bg = c.bg }
        hl.NormalSB = { fg = c.fg_dark, bg = c.bg_sidebar }

        -- Cursor
        hl.Cursor = { fg = c.bg, bg = c.fg }
        hl.CursorLine = { bg = "#121212" }
        hl.CursorLineNr = { fg = c.fg, bold = true }
        hl.LineNr = { fg = c.fg_gutter }
        hl.LineNrAbove = { fg = c.fg_gutter }
        hl.LineNrBelow = { fg = c.fg_gutter }

        -- Visual
        hl.Visual = { bg = c.bg_visual }
        hl.VisualNOS = { bg = c.bg_visual }

        -- Search
        hl.Search = { bg = c.bg_search, fg = c.fg }
        hl.IncSearch = { bg = c.orange, fg = c.bg, bold = true }
        hl.CurSearch = { bg = c.orange, fg = c.bg, bold = true }

        -- Statusline
        hl.StatusLine = { fg = c.fg_dark, bg = c.bg_statusline }
        hl.StatusLineNC = { fg = c.fg_gutter, bg = c.bg_statusline }
        hl.WinSeparator = { fg = c.border, bg = c.bg }

        -- Tabline
        hl.TabLine = { fg = c.fg_gutter, bg = c.bg_statusline }
        hl.TabLineFill = { bg = c.bg_statusline }
        hl.TabLineSel = { fg = c.fg, bg = c.bg_highlight, bold = true }

        -- Popup menu
        hl.Pmenu = { fg = c.fg, bg = c.bg_popup }
        hl.PmenuSel = { fg = c.fg, bg = c.bg_highlight, bold = true }
        hl.PmenuSbar = { bg = c.bg_highlight }
        hl.PmenuThumb = { bg = c.fg_gutter }

        -- Folding
        hl.Folded = { fg = c.comment, bg = c.bg_highlight }
        hl.FoldColumn = { fg = c.comment, bg = c.bg }

        -- Diff
        hl.DiffAdd = { bg = "#152515" }
        hl.DiffChange = { bg = "#252015" }
        hl.DiffDelete = { bg = "#251515" }
        hl.DiffText = { bg = "#2a2515" }

        -- Diagnostics
        hl.DiagnosticError = { fg = c.red }
        hl.DiagnosticWarn = { fg = c.yellow }
        hl.DiagnosticInfo = { fg = c.blue }
        hl.DiagnosticHint = { fg = c.comment }
        hl.DiagnosticVirtualTextError = { fg = c.red, bg = "#1a1010" }
        hl.DiagnosticVirtualTextWarn = { fg = c.yellow, bg = "#1a1a10" }
        hl.DiagnosticVirtualTextInfo = { fg = c.blue, bg = "#10151a" }
        hl.DiagnosticVirtualTextHint = { fg = c.comment, bg = "#101a1a" }
        hl.DiagnosticUnderlineError = { undercurl = true, sp = c.red }
        hl.DiagnosticUnderlineWarn = { undercurl = true, sp = c.yellow }
        hl.DiagnosticUnderlineInfo = { undercurl = true, sp = c.blue }
        hl.DiagnosticUnderlineHint = { undercurl = true, sp = c.comment }

        -- LSP
        hl.LspReferenceText = { bg = c.bg_highlight }
        hl.LspReferenceRead = { bg = c.bg_highlight }
        hl.LspReferenceWrite = { bg = c.bg_highlight }
        hl.LspCodeLens = { fg = c.comment }
        hl.LspCodeLensSeparator = { fg = c.comment }

        -- Treesitter
        hl.TreesitterContext = { bg = c.bg_highlight }
        hl.TreesitterContextLineNumber = { fg = c.fg, bg = c.bg_highlight, bold = true }

        -- Telescope
        hl.TelescopeNormal = { fg = c.fg, bg = c.bg_float }
        hl.TelescopeBorder = { fg = c.border, bg = c.bg_float }
        hl.TelescopePromptNormal = { fg = c.fg, bg = c.bg_highlight }
        hl.TelescopePromptBorder = { fg = c.border, bg = c.bg_highlight }
        hl.TelescopePromptTitle = { fg = c.fg, bg = c.bg_highlight, bold = true }
        hl.TelescopeResultsTitle = { fg = c.comment, bg = c.bg_float }
        hl.TelescopePreviewTitle = { fg = c.comment, bg = c.bg_float }
        hl.TelescopeSelection = { fg = c.fg, bg = c.bg_highlight, bold = true }
        hl.TelescopeMatching = { fg = c.blue, bold = true }

        -- Neo-tree
        hl.NeoTreeNormal = { fg = c.fg, bg = c.bg_sidebar }
        hl.NeoTreeNormalNC = { fg = c.fg_dark, bg = c.bg_sidebar }
        hl.NeoTreeDirectoryName = { fg = c.blue }
        hl.NeoTreeDirectoryIcon = { fg = c.blue }
        hl.NeoTreeFileName = { fg = c.fg }
        hl.NeoTreeFileIcon = { fg = c.fg_dark }
        hl.NeoTreeGitAdded = { fg = c.git.add }
        hl.NeoTreeGitModified = { fg = c.git.change }
        hl.NeoTreeGitDeleted = { fg = c.git.delete }
        hl.NeoTreeRootName = { fg = c.fg, bold = true }

        -- Bufferline
        hl.BufferLineFill = { bg = c.bg_statusline }
        hl.BufferLineBackground = { fg = c.fg_gutter, bg = c.bg_statusline }
        hl.BufferLineBufferVisible = { fg = c.fg_dark, bg = c.bg_statusline }
        hl.BufferLineBufferSelected = { fg = c.fg, bg = c.bg_highlight, bold = true }
        hl.BufferLineSeparator = { fg = c.border, bg = c.bg_statusline }
        hl.BufferLineSeparatorSelected = { fg = c.border, bg = c.bg_highlight }
        hl.BufferLineIndicatorSelected = { fg = c.blue, bg = c.bg_highlight }
        hl.BufferLineModified = { fg = c.yellow, bg = c.bg_statusline }
        hl.BufferLineModifiedSelected = { fg = c.yellow, bg = c.bg_highlight }
        hl.BufferLineModifiedVisible = { fg = c.yellow, bg = c.bg_statusline }
        hl.BufferLineDevIconLuaSelected = { fg = c.blue, bg = c.bg_highlight }

        -- Git signs
        hl.GitSignsAdd = { fg = c.git.add }
        hl.GitSignsChange = { fg = c.git.change }
        hl.GitSignsDelete = { fg = c.git.delete }

        -- Which-key
        hl.WhichKeyFloat = { bg = c.bg_float }
        hl.WhichKeyBorder = { fg = c.border, bg = c.bg_float }

        -- Lazy
        hl.LazyNormal = { fg = c.fg, bg = c.bg_float }
        hl.LazyBorder = { fg = c.border, bg = c.bg_float }

        -- Mason
        hl.MasonNormal = { fg = c.fg, bg = c.bg_float }
        hl.MasonBorder = { fg = c.border, bg = c.bg_float }

        -- Noice
        hl.NoicePopup = { fg = c.fg, bg = c.bg_float }
        hl.NoicePopupBorder = { fg = c.border, bg = c.bg_float }

        -- Notify
        hl.NotifyBackground = { bg = c.bg }
        hl.NotifyERRORBorder = { fg = c.red, bg = c.bg }
        hl.NotifyWARNBorder = { fg = c.yellow, bg = c.bg }
        hl.NotifyINFOBorder = { fg = c.blue, bg = c.bg }
        hl.NotifyDEBUGBorder = { fg = c.comment, bg = c.bg }
        hl.NotifyTRACEBorder = { fg = c.purple, bg = c.bg }

        -- Blink/CMP
        hl.BlinkCmpMenu = { fg = c.fg, bg = c.bg_float }
        hl.BlinkCmpMenuBorder = { fg = c.border, bg = c.bg_float }
        hl.BlinkCmpMenuSelection = { fg = c.fg, bg = c.bg_highlight }
        hl.BlinkCmpScrollBarGutter = { bg = c.bg_highlight }
        hl.BlinkCmpScrollBarThumb = { bg = c.fg_gutter }
        hl.BlinkCmpLabel = { fg = c.fg_dark }
        hl.BlinkCmpLabelDeprecated = { fg = c.comment, strikethrough = true }
        hl.BlinkCmpLabelMatch = { fg = c.blue, bold = true }
        hl.BlinkCmpKind = { fg = c.comment }
        hl.BlinkCmpSource = { fg = c.comment }

        -- Snacks
        hl.SnacksPicker = { fg = c.fg, bg = c.bg_float }
        hl.SnacksPickerBorder = { fg = c.border, bg = c.bg_float }
        hl.SnacksPickerTitle = { fg = c.fg, bg = c.bg_highlight, bold = true }

        -- Flash
        hl.FlashMatch = { bg = c.bg_search, fg = c.fg }
        hl.FlashCurrent = { bg = c.orange, fg = c.bg, bold = true }
        hl.FlashLabel = { bg = c.orange, fg = c.bg, bold = true }

        -- Mini
        hl.MiniIndentscopeSymbol = { fg = c.comment }
        hl.MiniIndentscopePrefix = { nocombine = true }
        hl.MiniStatuslineModeNormal = { fg = c.bg, bg = c.blue, bold = true }
        hl.MiniStatuslineModeInsert = { fg = c.bg, bg = c.green, bold = true }
        hl.MiniStatuslineModeVisual = { fg = c.bg, bg = c.magenta, bold = true }
        hl.MiniStatuslineModeReplace = { fg = c.bg, bg = c.red, bold = true }
        hl.MiniStatuslineModeCommand = { fg = c.bg, bg = c.yellow, bold = true }
        hl.MiniStatuslineDevinfo = { fg = c.fg_dark, bg = c.bg_highlight }
        hl.MiniStatuslineFileinfo = { fg = c.fg_dark, bg = c.bg_highlight }
        hl.MiniStatuslineFilename = { fg = c.fg, bg = c.bg_statusline }
        hl.MiniStatuslineInactive = { fg = c.fg_gutter, bg = c.bg_statusline }

        -- Dropbar
        hl.DropBarCurrentContext = { fg = c.fg, bg = c.bg_highlight, bold = true }
        hl.DropBarHover = { fg = c.blue, underline = true }

        -- Gitsigns
        hl.GitSignsCurrentLineBlame = { fg = c.comment, italic = true }
      end,
    },
  },
}