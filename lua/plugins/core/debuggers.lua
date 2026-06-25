return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "mfussenegger/nvim-dap-python",
    },
    config = function()
        vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#ff9e64" })
        vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98C379", bold = true })

        local breakpoint_icons = {
            DapBreakpoint = {
                text = "",
                texthl = "DapBreakpoint",
                linehl = "DapBreakpoint",
                numhl = "DapBreakpoint",
            },
            DapBreakpointCondition = {
                text = "",
                texthl = "DapBreakpointCondition",
                linehl = "DapBreakpointCondition",
                numhl = "DapBreakpointCondition",
            },
            DapLogPoint = { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" },
            DapStopped = { numhl = "DapStopped" },
        }

        for type, opts in pairs(breakpoint_icons) do
            vim.fn.sign_define(type, opts)
        end

        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()

        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: toggle breakpoint" })
        vim.keymap.set("n", "<leader>dB", function()
            require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { desc = "Debug: conditional breakpoint" })
        vim.keymap.set("n", "<leader>dl", function()
            require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end, { desc = "Debug: log point" })
        vim.keymap.set("n", "<leader>d<CR>", dap.continue, { desc = "Debug: continue" })
        vim.keymap.set("n", "<leader>dt", function()
            dapui.toggle({ reset = true })
        end, { desc = "Debug: toggle UI" })
        vim.keymap.set("n", "<leader>do", function()
            dapui.open({ reset = true })
        end, { desc = "Debug: open UI" })
        vim.keymap.set("n", "<leader>d<ESC>", function()
            dap.terminate()
            dapui.close()
        end, { desc = "Debug: terminate" })

        dap.listeners.before.attach.dapui_config = dapui.open
        dap.listeners.before.launch.dapui_config = dapui.open

        -- Debugger configs

        require("dap-python").setup("python3")

        dap.adapters.cppdbg = {
            id = "cppdbg",
            type = "executable",
            command = "OpenDebugAD7",
        }

        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "cppdbg",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = false,
                setupCommands = {
                    {
                        text = "-enable-pretty-printing",
                        description = "enable pretty printing",
                        ignoreFailures = false,
                    },
                },
            },
        }

        dap.configurations.c = dap.configurations.cpp
        dap.configurations.rust = dap.configurations.cpp
    end,
}
