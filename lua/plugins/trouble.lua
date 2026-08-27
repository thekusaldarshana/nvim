return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Problems panel)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Location list" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix list" },
    { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<CR>", desc = "Symbols" },
  },
  opts = {},
}
