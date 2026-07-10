vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.hlsearch = false
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.colorcolumn = "100"
vim.opt.cursorline = true

-- New options
vim.opt.undofile = true
vim.opt.inccommand = "split"
vim.opt.confirm = true
vim.opt.exrc = true
vim.opt.secure = true

local runtime_path = vim.api.nvim_list_runtime_paths()
vim.opt.path = vim.opt.path + runtime_path