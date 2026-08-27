-- Note: lazy.nvim merges this spec with the toggleterm entry in git.lua (same plugin name),
-- so LazyGit's floating terminal and this general-purpose one share one plugin instance.
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<C-\\>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal", mode = { "n", "t" } },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Terminal (float)" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Terminal (horizontal)" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<CR>", desc = "Terminal (vertical)" },
  },
  opts = {
    size = 15,
    open_mapping = [[<C-\>]],
    shading_factor = 2,
    direction = "float",
    float_opts = { border = "curved" },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
    -- Escape terminal mode with the usual Esc, plus window-nav from inside a terminal
    local function set_terminal_keymaps()
      local mopt = { buffer = 0 }
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], mopt)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], mopt)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], mopt)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], mopt)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], mopt)
    end
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*toggleterm#*",
      callback = set_terminal_keymaps,
    })
  end,
}
