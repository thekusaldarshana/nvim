return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "auto",
      globalstatus = true,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_c = { { "filename", path = 1 } }, -- relative path instead of just filename
      lualine_x = { "diagnostics", "encoding", "filetype" },
    },
  },
}
