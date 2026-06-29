vim.g.mapleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- File operations
map("n", "<leader>w", "<cmd>w<CR>", opts)
map("n", "<leader>q", "<cmd>q<CR>", opts)
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
map("n", "<leader>pv", vim.cmd.Ex, { desc = "File explorer (netrw)" })

-- Window navigation (default: <C-w>h/j/k/l)
-- Window resizing
map("n", "<C-Up>", "<cmd>resize +2<CR>", opts)
map("n", "<C-Down>", "<cmd>resize -2<CR>", opts)
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Buffer navigation (default: :bnext, :bprev, :bd)
map("n", "<leader>bl", "<cmd>Telescope buffers<CR>", { desc = "List buffers" })

-- Tab navigation (default: gt, gT, :tabnew, :tabclose)
map("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>td", "<cmd>tabclose<CR>", { desc = "Close tab" })

-- Undotree
map("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })

-- Search
map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- Zen mode
map("n", "<leader>z", "<cmd>ZenMode<CR>", { desc = "Toggle zen mode" })

-- LSP (defined in lsp.lua on LspAttach)

-- DAP (defined in dap.lua)

-- Database (defined in database.lua)

-- Telescope (defined in plugins.lua)

-- Git
map("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git status" })
map("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Git commit" })
map("n", "<leader>gp", "<cmd>Git push<CR>", { desc = "Git push" })
map("n", "<leader>gl", "<cmd>Git log --oneline -20<CR>", { desc = "Git log" })

-- Terminal
map("n", "<leader>tt", "<cmd>terminal<CR>", { desc = "Open terminal" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Markdown preview
map("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { desc = "Markdown preview" })
map("n", "<leader>ms", "<cmd>MarkdownPreviewStop<CR>", { desc = "Stop markdown preview" })

-- Python
map("n", "<leader>vs", "<cmd>VenvSelect<CR>", { desc = "Select Python venv" })
map("n", "<leader>tt", function() require("neotest").run.run() end, { desc = "Run nearest test" })
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