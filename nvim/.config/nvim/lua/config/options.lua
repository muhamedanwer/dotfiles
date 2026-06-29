-- LazyVim Matte Black Configuration
-- ~/.config/nvim/lua/config/options.lua

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes:1"
opt.cursorline = true
opt.cursorlineopt = "number"
opt.colorcolumn = "100"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.linebreak = true
opt.showbreak = "↪ "
opt.fillchars = {
  fold = " ",
  foldopen = "▾",
  foldclose = "▸",
  foldsep = "│",
  diff = "╱",
  eob = " ",
}

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.breakindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Files
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.autoread = true

-- Completion
opt.completeopt = "menu,menuone,noselect,preview"
opt.pumheight = 10
opt.pumblend = 10

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Mouse
opt.mouse = "a"
opt.mousemoveevent = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Performance
opt.updatetime = 200
opt.timeoutlen = 300
opt.ttimeoutlen = 0
opt.redrawtime = 1500

-- Folding
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Terminal
opt.termguicolors = true

-- Disable providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0