-- lua/plugins/jupyter.lua
return {
  {
    "GCBallesteros/jupytext.nvim",
    config = function()
      require("jupytext").setup({
        style = "markdown",
        output_format = "ipynb",
        force_output = true,
      })
    end,
  },
  {
    "jpalardy/vim-slime",
    config = function()
      vim.g.slime_target = "toggleterm"
      vim.g.slime_default_config = { direction = "horizontal" }
      vim.g.slime_python_ipython = 1
      vim.keymap.set("n", "<leader>sc", "<Plug>SlimeSendCell", { desc = "Send cell" })
      vim.keymap.set("n", "<leader>sl", "<Plug>SlimeSendLine", { desc = "Send line" })
      vim.keymap.set("v", "<leader>s", "<Plug>SlimeRegionSend", { desc = "Send visual selection" })
    end,
  },
}
