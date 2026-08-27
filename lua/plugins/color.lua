-- Inline color highlighting (like VS Code) + an actual interactive color picker.
-- Both need real RGB rendering, which the raw console can't do (see colorscheme.lua), so both
-- are disabled there.
if vim.g.is_console then
  return {}
end

return {
  {
    "catgoose/nvim-colorizer.lua", -- maintained fork of the original norcalli/nvim-colorizer.lua
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("colorizer").setup({
        "css", "scss", "html", "javascript", "typescript", "javascriptreact",
        "typescriptreact", "astro", "lua", "vim", "json", "yaml",
      }, {
        RGB = true, RRGGBB = true, RRGGBBAA = true, hsl_fn = true, rgb_fn = true, css = true,
      })
    end,
  },
  {
    "uga-rosa/ccc.nvim",
    cmd = { "CccPick", "CccConvert", "CccHighlighterToggle" },
    keys = {
      { "<leader>cp", "<cmd>CccPick<CR>", desc = "Color picker" },
    },
    opts = {
      highlighter = { auto_enable = false, lsp = true },
    },
  },
}
