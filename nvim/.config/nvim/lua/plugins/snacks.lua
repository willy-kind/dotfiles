return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    vim.keymap.set("n", "<leader>sv", function()
      local specific_file = vim.fn.expand("~/repos/second-brain/3-resources/Neovim/vim-motions.md")
      -- Use live_grep with the paths parameter
      require("snacks").picker.grep({
        search = "",
        cwd = vim.fn.expand("~/repos/second-brain/3-resources/Neovim/"),
        paths = { "vim-motions.md" },
      })
    end, { desc = "Search in test.md" })
  end,
}
