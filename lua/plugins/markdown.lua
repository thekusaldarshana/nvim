return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" }, -- .mdx is mapped to the markdown filetype in config/autocmds.lua
  build = function() vim.fn["mkdp#util#install"]() end,
  keys = {
    { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", desc = "Markdown preview" },
  },
}
