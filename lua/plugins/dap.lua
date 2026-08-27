-- Python is fully wired via debugpy. JS/TS debugging comes from mason's prebuilt
-- js-debug-adapter (no local npm/gulp/Chromium build needed) — mason-nvim-dap wires its
-- adapters and default launch configs automatically once it's installed.
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
      "mfussenegger/nvim-dap-python",
    },
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Continue" },
      { "<F1>", function() require("dap").step_into() end, desc = "Debug: Step into" },
      { "<F2>", function() require("dap").step_over() end, desc = "Debug: Step over" },
      { "<F3>", function() require("dap").step_out() end, desc = "Debug: Step out" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Conditional breakpoint",
      },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "Open REPL" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle debug UI" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("mason-nvim-dap").setup({
        ensure_installed = { "python", "js" },
        automatic_installation = true,
        handlers = {}, -- use mason-nvim-dap's default handler for every installed adapter
      })

      dapui.setup()
      require("nvim-dap-virtual-text").setup()
      require("dap-python").setup(vim.fn.exepath("python3"))

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticSignWarn" })
    end,
  },
}
