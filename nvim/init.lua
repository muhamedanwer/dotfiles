-- 1. Set leader key FIRST (before lazy loads any plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 2. Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 3. Load plugins (all files in lua/plugins/*.lua)
require("lazy").setup("plugins", {
  defaults = { lazy = true },
  install = { colorscheme = { "carbonfox" } },
})

-- 4. Load remaining user options (colorscheme, tabs, etc.)
--    Note: options.lua should NOT redefine mapleader
require("user.options")
