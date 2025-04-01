return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      -- Default configuration
      size = 15,
      open_mapping = [[<C-\>]],
      direction = "horizontal",
      shell = vim.o.shell, -- Use the default shell
      auto_scroll = true,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
    end,
  },
}
