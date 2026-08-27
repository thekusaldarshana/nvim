-- Four themes installed side by side. Switch anytime with <leader>uc (Telescope colorscheme picker
-- with live preview), or set vim.g.colorscheme below to change the startup default.
--
-- On the raw Linux console (no GUI/pty in between — see config/lazy.lua for the detection
-- rule) true 24-bit color is a kernel-level impossibility, so these truecolor-only plugins
-- are skipped there in favor of mini.base16 (see tty-theme.lua), which renders correctly in
-- a 16-color terminal. Keep this file's palette hexes in sync with ~/.config/tty-theme/*.sh
-- and tty-theme.lua if you ever change a theme's flavour/style.

-- vim.g.is_console is set in config/options.lua, before any plugin file loads.
-- On the console, follow whatever `tty-theme <name>` last set (so the ANSI palette applied to
-- the raw terminal and Neovim's mini.base16 palette always match). Elsewhere, pick your mood
-- here — or switch anytime with <leader>uc.
vim.g.colorscheme = "catppuccin" -- one of: catppuccin | onedark | kanagawa | bamboo | gruvbox
if vim.g.is_console then
  local state = vim.fn.expand("~/.config/tty-theme/current")
  if vim.fn.filereadable(state) == 1 then
    local saved = vim.trim(table.concat(vim.fn.readfile(state)))
    if saved ~= "" then
      vim.g.colorscheme = saved
    end
  end
end

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = vim.g.is_console or vim.g.colorscheme ~= "catppuccin",
    cond = not vim.g.is_console,
    priority = 1000,
    opts = {
      flavour = "mocha",
      integrations = {
        cmp = true,
        gitsigns = true,
        neotree = true,
        telescope = true,
        treesitter = true,
        which_key = true,
        native_lsp = { enabled = true },
        dap = true,
        dap_ui = true,
        indent_blankline = { enabled = true },
        mason = true,
        noice = true,
        notify = true,
      },
    },
  },
  {
    "navarasu/onedark.nvim",
    lazy = vim.g.is_console or vim.g.colorscheme ~= "onedark",
    cond = not vim.g.is_console,
    priority = 1000,
    opts = { style = "dark" },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = vim.g.is_console or vim.g.colorscheme ~= "kanagawa",
    cond = not vim.g.is_console,
    priority = 1000,
    opts = {},
  },
  {
    "ribru17/bamboo.nvim",
    lazy = vim.g.is_console or vim.g.colorscheme ~= "bamboo",
    cond = not vim.g.is_console,
    priority = 1000,
    opts = {},
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = vim.g.is_console or vim.g.colorscheme ~= "gruvbox",
    cond = not vim.g.is_console,
    priority = 1000,
    opts = { contrast = "hard" },
  },
}
