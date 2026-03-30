return {
  {
    "numToStr/Comment.nvim",
    opts = {},
    config = function()
      require("Comment").setup()
      -- Keep your existing keymaps: gcc/gc already work
    end,
  },
}
