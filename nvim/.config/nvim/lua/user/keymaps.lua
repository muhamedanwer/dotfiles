vim.g.mapleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- File operations
map("n", "<leader>w", "<cmd>w<CR>", opts)
map("n", "<leader>q", "<cmd>q<CR>", opts)
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
map("n", "<leader>pv", vim.cmd.Ex, { desc = "File explorer (netrw)" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window resizing
map("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
map("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Buffer navigation
map("n", "<leader>bl", "<cmd>Telescope buffers<CR>", { desc = "List buffers" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- Tab navigation
map("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>td", "<cmd>tabclose<CR>", { desc = "Close tab" })

-- Undotree
map("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })

-- Search
map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- Harpoon
map("n", "<leader>ha", function() require("harpoon"):list():add() end, { desc = "Harpoon add file" })
map("n", "<leader>hh", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, { desc = "Harpoon menu" })
map("n", "<leader>1", function() require("harpoon"):list():select(1) end, { desc = "Harpoon file 1" })
map("n", "<leader>2", function() require("harpoon"):list():select(2) end, { desc = "Harpoon file 2" })
map("n", "<leader>3", function() require("harpoon"):list():select(3) end, { desc = "Harpoon file 3" })
map("n", "<leader>4", function() require("harpoon"):list():select(4) end, { desc = "Harpoon file 4" })

-- Toggleterm
map("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Terminal left" })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Terminal down" })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Terminal up" })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Terminal right" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Git
map("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git status" })
map("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Git commit" })
map("n", "<leader>gp", "<cmd>Git push<CR>", { desc = "Git push" })
map("n", "<leader>gl", "<cmd>Git log --oneline -20<CR>", { desc = "Git log" })
map("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Git diffview" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory<CR>", { desc = "Git file history" })

-- Python
map("n", "<leader>vs", "<cmd>VenvSelect<CR>", { desc = "Select Python venv" })
map("n", "<leader>tr", function() require("neotest").run.run() end, { desc = "Run nearest test" })
map("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Run file tests" })
map("n", "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, { desc = "Debug nearest test" })
map("n", "<leader>to", function() require("neotest").output.open() end, { desc = "Test output" })
map("n", "<leader>ts", function() require("neotest").summary.toggle() end, { desc = "Test summary" })

-- Rust
map("n", "<leader>rr", "<cmd>RustLsp run<CR>", { desc = "Run Rust" })
map("n", "<leader>rd", "<cmd>RustLsp debug<CR>", { desc = "Debug Rust" })
map("n", "<leader>rt", "<cmd>RustLsp testables<CR>", { desc = "Run Rust tests" })
map("n", "<leader>rc", "<cmd>RustLsp openCargo<CR>", { desc = "Open Cargo.toml" })
map("n", "<leader>ra", "<cmd>RustLsp codeAction<CR>", { desc = "Rust code actions" })

-- Format
map("n", "<leader>fm", function() require("conform").format({ lsp_fallback = true }) end, { desc = "Format file" })

-- Trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Trouble diagnostics" })
map("n", "<leader>xw", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Trouble buffer diagnostics" })
map("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>", { desc = "Trouble loclist" })
map("n", "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", { desc = "Trouble quickfix" })

-- Database
map("n", "<leader>D", "<cmd>DBUIToggle<cr>", { desc = "Toggle DB UI" })
map("n", "<leader>Da", "<cmd>DBUIAddConnection<cr>", { desc = "Add DB connection" })
map("n", "<leader>Df", "<cmd>DBUIFindBuffer<cr>", { desc = "Find DB buffer" })
map("n", "<leader>Dr", "<cmd>DBUIRenameBuffer<cr>", { desc = "Rename DB buffer" })

-- AI
map("n", "<leader>ac", function() require("codecompanion").chat() end, { desc = "AI chat" })
map("n", "<leader>ai", function() require("codecompanion").inline() end, { desc = "AI inline" })
map("v", "<leader>ai", function() require("codecompanion").inline() end, { desc = "AI inline (visual)" })

-- Zen mode
map("n", "<leader>z", "<cmd>ZenMode<CR>", { desc = "Toggle zen mode" })