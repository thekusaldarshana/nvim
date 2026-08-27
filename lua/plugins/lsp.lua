-- LSP servers for every language you listed: html/css/tailwind/astro, js/ts (incl. React/Next),
-- python, bash, json, yaml, markdown/mdx, lua (config itself), and rust-analyzer for later.

return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "html",
        "cssls",
        "tailwindcss",
        "astro",
        "ts_ls",
        "pyright",
        "ruff",
        "bashls",
        "jsonls",
        "yamlls",
        "marksman",
        "lua_ls",
        "rust_analyzer",
      },
      automatic_installation = true,
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "prettier", -- js/ts/html/css/json/yaml/md formatter
        "prettierd",
        "stylua", -- lua formatter
        "black", -- python formatter
        "ruff", -- python lint/format
        "shfmt", -- bash formatter
        "eslint_d", -- js/ts linter
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Keymaps set only on buffers that actually have an LSP client attached.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
        callback = function(event)
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = desc })
          end
          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
          map("n", "gr", "<cmd>Telescope lsp_references<CR>", "References")
          map("n", "gI", vim.lsp.buf.implementation, "Go to implementation")
          map("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")
          map("n", "K", vim.lsp.buf.hover, "Hover docs")
          map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<CR>", "Document symbols")
          map("n", "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<CR>", "Workspace symbols")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
          end
        end,
      })

      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        severity_sort = true,
        float = { border = "rounded" },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
        },
      })

      local servers = {
        html = {},
        cssls = {},
        tailwindcss = {
          filetypes = { "html", "css", "javascriptreact", "typescriptreact", "astro" },
        },
        astro = {},
        ts_ls = {
          settings = {
            typescript = { inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionResultTypeHints = true,
            } },
          },
        },
        pyright = {
          settings = {
            python = { analysis = { typeCheckingMode = "basic" } },
          },
        },
        ruff = {},
        bashls = {},
        jsonls = {},
        yamlls = {},
        marksman = {},
        rust_analyzer = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              diagnostics = { globals = { "vim" } },
            },
          },
        },
      }

      for name, config in pairs(servers) do
        config.capabilities = capabilities
        vim.lsp.config(name, config)
        vim.lsp.enable(name)
      end
    end,
  },
}
