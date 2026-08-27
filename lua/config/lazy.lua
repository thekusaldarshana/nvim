-- Bootstraps lazy.nvim (installs it on first run) and loads every spec under lua/plugins/.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = true, notify = false }, -- silently check for plugin updates
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- On the raw console, mini.base16 (lua/plugins/tty-theme.lua) applies colors itself on setup;
-- there's no :colorscheme command to invoke and no truecolor picker preview to offer there.
if not vim.g.is_console then
  vim.cmd.colorscheme(vim.g.colorscheme)
  vim.keymap.set(
    "n",
    "<leader>uc",
    "<cmd>Telescope colorscheme enable_preview=true<CR>",
    { desc = "Pick colorscheme" }
  )
end
