-- ============================================================
--  AI & Data Engineering — Neovim Config
--  Python | SQL | Jupyter | Markdown | LaTeX | PDF | AI
--  Theme: VSCode Dark+ (matte-black feel)
-- ============================================================

require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  defaults = { lazy = true },
  install  = { colorscheme = { "vscode" } },
  ui = {
    border = "rounded",
    title  = "  Plugins ",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip","matchit","matchparen","netrwPlugin",
        "tarPlugin","tohtml","tutor","zipPlugin",
      },
    },
  },
  checker = { enabled = true, notify = false },
})
