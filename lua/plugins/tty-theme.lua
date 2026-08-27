-- Console-mode (raw Linux TTY) colorscheme. mini.base16 generates highlight groups from a
-- 16-hex base16 palette using cterm 0-15 (matching the retinted console palette applied by
-- ~/.config/tty-theme/*.sh), so this actually renders correctly with no truecolor available —
-- unlike catppuccin/onedark/kanagawa/bamboo, which are guifg-only and would look colorless here.
--
-- Palettes are base16 ports of the same themes/flavours used in colorscheme.lua:
--   catppuccin -> official Catppuccin Mocha base16
--   kanagawa   -> kanagawa.nvim's official "Kanagawa" (Wave) base16 export
--   onedark    -> derived from onedark.nvim's "dark" style palette
--   bamboo     -> derived from bamboo.nvim's default "vulgaris" style palette
--   gruvbox    -> the standard/well-known base16-gruvbox-dark-medium palette

local palettes = {
  catppuccin = {
    base00 = "#1e1e2e", base01 = "#181825", base02 = "#313244", base03 = "#45475a",
    base04 = "#585b70", base05 = "#cdd6f4", base06 = "#f5e0dc", base07 = "#b4befe",
    base08 = "#f38ba8", base09 = "#fab387", base0A = "#f9e2af", base0B = "#a6e3a1",
    base0C = "#94e2d5", base0D = "#89b4fa", base0E = "#cba6f7", base0F = "#f2cdcd",
  },
  kanagawa = {
    -- base00 darkened to #121212 to match colorscheme.lua's sumiInk3 override
    base00 = "#121212", base01 = "#2A2A37", base02 = "#223249", base03 = "#727169",
    base04 = "#C8C093", base05 = "#DCD7BA", base06 = "#938AA9", base07 = "#363646",
    base08 = "#C34043", base09 = "#FFA066", base0A = "#DCA561", base0B = "#98BB6C",
    base0C = "#7FB4CA", base0D = "#7E9CD8", base0E = "#957FB8", base0F = "#D27E99",
  },
  onedark = {
    base00 = "#282c34", base01 = "#31353f", base02 = "#393f4a", base03 = "#5c6370",
    base04 = "#848b98", base05 = "#abb2bf", base06 = "#b6bdca", base07 = "#c8ccd4",
    base08 = "#e86671", base09 = "#d19a66", base0A = "#e5c07b", base0B = "#98c379",
    base0C = "#56b6c2", base0D = "#61afef", base0E = "#c678dd", base0F = "#993939",
  },
  bamboo = {
    base00 = "#252623", base01 = "#2f312c", base02 = "#383b35", base03 = "#5b5e5a",
    base04 = "#838781", base05 = "#f1e9d2", base06 = "#e2c792", base07 = "#ffffff",
    base08 = "#e75a7c", base09 = "#ff9966", base0A = "#dbb651", base0B = "#8fb573",
    base0C = "#70c2be", base0D = "#57a5e5", base0E = "#aaaaff", base0F = "#f08080",
  },
  gruvbox = {
    base00 = "#282828", base01 = "#3c3836", base02 = "#504945", base03 = "#665c54",
    base04 = "#bdae93", base05 = "#d5c4a1", base06 = "#ebdbb2", base07 = "#fbf1c7",
    base08 = "#fb4934", base09 = "#fe8019", base0A = "#fabd2f", base0B = "#b8bb26",
    base0C = "#8ec07c", base0D = "#83a598", base0E = "#d3869b", base0F = "#d65d0e",
  },
}

-- The Linux console only ever controls indices 0-15 (see ~/.config/tty-theme/*.sh); mini.base16's
-- default use_cterm=true approximates from the full 256-color cube instead, which the console
-- can't render. Pin it to exactly the same 0-15 slots those scripts retint, standard base16->ANSI
-- convention (as used by base16-shell).
local cterm16 = {
  base00 = 0, base01 = 0, base02 = 8, base03 = 8,
  base04 = 7, base05 = 7, base06 = 15, base07 = 15,
  base08 = 1, base09 = 9, base0A = 3, base0B = 2,
  base0C = 6, base0D = 4, base0E = 5, base0F = 1,
}

return {
  "echasnovski/mini.base16",
  lazy = not vim.g.is_console,
  priority = 1000,
  config = function()
    require("mini.base16").setup({
      palette = palettes[vim.g.colorscheme] or palettes.catppuccin,
      use_cterm = cterm16,
    })
  end,
}
