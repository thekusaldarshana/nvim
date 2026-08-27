-- Note: nvim-treesitter's `main` branch (required for Neovim 0.11+) is a full rewrite —
-- it only installs parsers/queries now. Highlighting/indent/folds are enabled explicitly
-- below via Neovim's native vim.treesitter API, per the plugin's own README.

local ensure_installed = {
  "lua", "vim", "vimdoc", "query",
  "bash", "json", "yaml", "toml",
  "markdown", "markdown_inline",
  "html", "css", "scss",
  "javascript", "typescript", "tsx", "astro",
  "python", "rust",
  "regex", "gitignore", "diff", "git_config",
  -- "gitcommit" intentionally omitted: its parser build is unusually slow/flaky here.
  -- Add back anytime with :TSInstall gitcommit if you want commit-message highlighting.
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false, -- this plugin explicitly does not support lazy-loading
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install(ensure_installed)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function(ev)
        local ft = ev.match
        local lang = vim.treesitter.language.get_lang(ft) or ft
        -- language.add() only registers the mapping; it doesn't verify a parser actually
        -- exists, so the real failure (e.g. ft "alpha" from the dashboard, which has no
        -- parser) only surfaces inside start() itself. Guard that call too.
        if not pcall(vim.treesitter.language.add, lang) then
          return
        end
        if not pcall(vim.treesitter.start, ev.buf, lang) then
          return
        end
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0][0].foldmethod = "expr"
        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    vim.opt.foldenable = false -- don't collapse folds on open; toggle with zc/za as usual
  end,
}
