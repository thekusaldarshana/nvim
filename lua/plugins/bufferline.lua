return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
    { "<Tab>", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
    { "<leader>bp", "<cmd>BufferLinePick<CR>", desc = "Pick buffer" },
    { "<leader>bc", "<cmd>BufferLineCloseOthers<CR>", desc = "Close other buffers" },
  },
  opts = {
    options = {
      mode = "buffers",
      separator_style = "thin",
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Explorer",
          highlight = "Directory",
          separator = true,
        },
      },
    },
  },
}
