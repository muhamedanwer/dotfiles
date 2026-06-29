require("codecompanion").setup({
  strategies = {
    chat = { adapter = "copilot" },
    inline = { adapter = "copilot" },
  },
  adapters = {
    copilot = function()
      return require("codecompanion.adapters").extend("copilot", {})
    end,
  },
})

vim.keymap.set("n", "<leader>ac", require("codecompanion").chat, { desc = "AI chat" })
vim.keymap.set("n", "<leader>ai", require("codecompanion").inline, { desc = "AI inline" })
vim.keymap.set("v", "<leader>ai", require("codecompanion").inline, { desc = "AI inline (visual)" })
