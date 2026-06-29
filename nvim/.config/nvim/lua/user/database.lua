-- Database configuration (vim-dadbod)
-- Add your connections in ~/.vim/db_ui/connections.json or use :DBUIAddConnection

vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_show_database_icon = 1
vim.g.db_ui_force_echo_notifications = 1
vim.g.db_ui_win_position = "right"
vim.g.db_ui_winwidth = 40

-- Auto-completion for SQL
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "mysql", "plsql" },
  callback = function()
    require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" }, { name = "buffer" } } })
  end,
})

-- Keymaps
vim.keymap.set("n", "<leader>D", "<cmd>DBUIToggle<cr>", { desc = "Toggle DB UI" })
vim.keymap.set("n", "<leader>Da", "<cmd>DBUIAddConnection<cr>", { desc = "Add DB connection" })
vim.keymap.set("n", "<leader>Df", "<cmd>DBUIFindBuffer<cr>", { desc = "Find DB buffer" })
vim.keymap.set("n", "<leader>Dr", "<cmd>DBUIRenameBuffer<cr>", { desc = "Rename DB buffer" })

-- Example connections (add to ~/.vim/db_ui/connections.json):
-- {
--   "dev_postgres": {
--     "driver": "postgres",
--     "host": "localhost",
--     "port": 5432,
--     "database": "myapp_dev",
--     "user": "postgres",
--     "password": "password"
--   },
--   "dev_mysql": {
--     "driver": "mysql",
--     "host": "localhost",
--     "port": 3306,
--     "database": "myapp_dev",
--     "user": "root",
--     "password": "password"
--   },
--   "dev_sqlite": {
--     "driver": "sqlite",
--     "database": "./dev.db"
--   }
-- }