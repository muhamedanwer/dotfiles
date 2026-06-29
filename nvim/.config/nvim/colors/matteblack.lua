local bg = "#0a0a0a"
local bg2 = "#121212"
local fg = "#d4d4d4"
local gray = "#555555"
local blue = "#569cd6"
local green = "#6a9955"
local red = "#f44747"
local yellow = "#dcdcaa"
local orange = "#ce9178"

local function hg(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hg("Normal", { bg = bg, fg = fg })
hg("NormalFloat", { bg = bg })
hg("FloatBorder", { bg = bg, fg = gray })
hg("LineNr", { bg = bg, fg = gray })
hg("CursorLineNr", { bg = bg, fg = fg })
hg("SignColumn", { bg = bg })
hg("FoldColumn", { bg = bg })
hg("EndOfBuffer", { bg = bg, fg = bg })

hg("CursorLine", { bg = bg2 })
hg("ColorColumn", { bg = bg2 })
hg("Visual", { bg = "#264f78" })
hg("Search", { bg = yellow, fg = bg })
hg("IncSearch", { bg = yellow, fg = bg })

hg("StatusLine", { bg = bg2, fg = fg })
hg("StatusLineNC", { bg = bg2, fg = gray })
hg("TabLine", { bg = bg2, fg = gray })
hg("TabLineSel", { bg = bg, fg = fg })
hg("TabLineFill", { bg = bg2 })

hg("Pmenu", { bg = bg2, fg = fg })
hg("PmenuSel", { bg = blue, fg = bg })
hg("PmenuSbar", { bg = bg2 })
hg("PmenuThumb", { bg = gray })

hg("Comment", { fg = "#6a9955", italic = true })
hg("String", { fg = orange })
hg("Number", { fg = green })
hg("Keyword", { fg = blue })
hg("Function", { fg = yellow })
hg("Type", { fg = blue })
hg("Statement", { fg = blue })
hg("Identifier", { fg = fg })
hg("PreProc", { fg = blue })
hg("Constant", { fg = green })
hg("Special", { fg = orange })
hg("Todo", { bg = yellow, fg = bg })

hg("DiffAdd", { bg = "#1e3a1e", fg = green })
hg("DiffChange", { bg = "#1e2a3a", fg = blue })
hg("DiffDelete", { bg = "#3a1e1e", fg = red })

hg("Whitespace", { fg = "#1e1e1e" })
hg("NonText", { fg = "#1e1e1e" })

hg("Directory", { fg = blue })

hg("Error", { fg = red })
hg("ErrorMsg", { fg = red, bg = bg })
hg("WarningMsg", { fg = yellow, bg = bg })
hg("ModeMsg", { fg = fg })
hg("MoreMsg", { fg = blue })

hg("MatchParen", { bg = "#264f78", fg = fg })
hg("SpellBad", { undercurl = true, fg = red })
hg("SpellCap", { undercurl = true, fg = yellow })
