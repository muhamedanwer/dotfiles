-- 1. Set leader keys FIRST (must be before any plugin loads)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 2. Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("Installing lazy.nvim...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_err_writeln("Failed to clone lazy.nvim. Check your internet connection and try again.")
    return
  end
end
vim.opt.rtp:prepend(lazypath)

-- 3. Load plugins from the 'plugins' folder (all *.lua files in lua/plugins/)
--    Use a pcall to catch any errors during setup
local ok, lazy = pcall(require, "lazy")
if not ok then
  vim.api.nvim_err_writeln("Failed to require lazy.nvim: " .. tostring(lazy))
  return
end

-- Setup lazy with your plugin specs
lazy.setup("plugins", {
  defaults = { lazy = true },
  install = { colorscheme = { "carbonfox" } },
  -- Optional: enable debug logging if you run into issues
  -- debug = true,
})

-- 4. Load user options (colorscheme, tabs, etc.)
--    Use pcall to prevent errors from breaking the whole config
local options_ok, err = pcall(require, "user.options")
if not options_ok then
  vim.api.nvim_err_writeln("Failed to load user.options: " .. tostring(err))
end
