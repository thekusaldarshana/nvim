return {
  "stevearc/aerial.nvim",
  cmd = "AerialToggle",
  keys = {
    { "<leader>o", "<cmd>AerialToggle<CR>", desc = "Toggle symbols outline" },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  opts = {
    backends = { "lsp", "treesitter", "markdown" },
    layout = { min_width = 28 },
  },
}
