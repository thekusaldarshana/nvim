-- Core editor settings. Read top to bottom; every line here is a deliberate choice, not a default.

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- True 24-bit color is a kernel-level impossibility on the raw Linux console (no GUI
-- terminal/pty in between) — see lua/plugins/colorscheme.lua and lua/plugins/tty-theme.lua.
-- XDG_SESSION_TYPE=tty is set once at login and survives into tmux/nested shells, unlike
-- $TERM (which tmux overrides to tmux-256color). Set here (before any plugin loads) so every
-- plugin file can rely on it regardless of lua/plugins/*.lua load order.
vim.g.is_console = vim.env.XDG_SESSION_TYPE == "tty"

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = not vim.g.is_console
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.pumheight = 12 -- max items in completion popup
opt.showmode = false -- statusline plugin shows mode instead
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.laststatus = 3 -- one global statusline

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- Files / undo
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("state") .. "/undo"
opt.updatetime = 250
opt.timeoutlen = 400

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }

-- Clipboard: share with system clipboard (needs xclip on X11 / wl-clipboard on Wayland)
opt.clipboard = "unnamedplus"

-- Mouse (VS Code habits die hard — click to place cursor, drag to select)
opt.mouse = "a"

-- Better diff
opt.diffopt:append("linematch:60")

vim.g.have_nerd_font = true
