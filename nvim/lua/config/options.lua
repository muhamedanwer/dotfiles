local o                 = vim.opt

-- UI
o.number                = true
o.relativenumber        = true
o.signcolumn            = "yes"
o.cursorline            = true
o.termguicolors         = true
o.showmode              = false -- shown by lualine
o.laststatus            = 3     -- global statusline
o.cmdheight             = 1
o.pumheight             = 12    -- completion popup max items
o.pumblend              = 8     -- completion popup slight transparency
o.winblend              = 8
o.scrolloff             = 8
o.sidescrolloff         = 8
o.colorcolumn           = "88" -- PEP8 line length guide

-- Editor behaviour
o.expandtab             = true
o.shiftwidth            = 4
o.tabstop               = 4
o.softtabstop           = 4
o.smartindent           = true
o.wrap                  = false
o.breakindent           = true
o.linebreak             = true

-- Search
o.ignorecase            = true
o.smartcase             = true
o.hlsearch              = false
o.incsearch             = true

-- Files
o.undofile              = true
o.undolevels            = 10000
o.swapfile              = false
o.updatetime            = 200

-- Split behaviour
o.splitbelow            = true
o.splitright            = true

-- Conceal (needed for LaTeX & markdown rendering)
o.conceallevel          = 2

-- Clipboard (system)
o.clipboard             = "unnamedplus"

-- Fold (using treesitter)
o.foldmethod            = "expr"
o.foldexpr              = "v:lua.vim.treesitter.foldexpr()"
o.foldenable            = false -- open files unfolded

-- Leader
vim.g.mapleader         = " "
vim.g.maplocalleader    = "\\"

-- Providers
vim.g.python3_host_prog = "/usr/bin/python3"
