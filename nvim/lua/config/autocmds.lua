local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup

-- ── Python ────────────────────────────────────────────────────
au("FileType", {
  group   = ag("Python", { clear = true }),
  pattern = "python",
  callback = function()
    vim.opt_local.colorcolumn = "88"  -- Black formatter
    vim.opt_local.shiftwidth  = 4
  end,
})

-- ── SQL ───────────────────────────────────────────────────────
au("FileType", {
  group   = ag("SQL", { clear = true }),
  pattern = { "sql", "mysql", "plsql" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    -- Trigger dadbod completion
    require("cmp").setup.buffer({
      sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
      },
    })
  end,
})

-- ── Jupyter (.ipynb open as python) ───────────────────────────
au("BufRead", {
  group   = ag("Jupyter", { clear = true }),
  pattern = "*.ipynb",
  callback = function()
    vim.cmd("MoltenInit")   -- auto-init kernel for notebooks
  end,
})

-- ── Markdown ──────────────────────────────────────────────────
au("FileType", {
  group   = ag("Markdown", { clear = true }),
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap       = true
    vim.opt_local.linebreak  = true
    vim.opt_local.spell      = true
    vim.opt_local.spelllang  = "en_us"
  end,
})

-- ── LaTeX ─────────────────────────────────────────────────────
au("FileType", {
  group   = ag("LaTeX", { clear = true }),
  pattern = { "tex", "latex" },
  callback = function()
    vim.opt_local.wrap      = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell     = true
  end,
})

-- ── Highlight on yank ─────────────────────────────────────────
au("TextYankPost", {
  group    = ag("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ highlight = "IncSearch", timeout = 300 })
  end,
})

-- ── Trim trailing whitespace on save ─────────────────────────
au("BufWritePre", {
  group    = ag("TrimWhitespace", { clear = true }),
  pattern  = "*",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

-- ── Auto-resize splits on window resize ──────────────────────
au("VimResized", {
  group    = ag("ResizeSplits", { clear = true }),
  callback = function() vim.cmd("tabdo wincmd =") end,
})
