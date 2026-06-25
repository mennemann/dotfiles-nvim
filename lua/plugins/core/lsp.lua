return {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        vim.lsp.config("*", {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "stylua", "ruff", "pyright", "clangd", "ltex", "ts_ls", "rust_analyzer" },
        })

        vim.lsp.config("ruff", {
            init_options = {
                settings = {
                    configurationPreference = "filesystemFirst",
                    lineLength = 320,
                    lint = {
                        select = { "ALL" },
                        ignore = {
                            "D",
                            "CPY",
                            "F401",
                            "E501",
                            "S101",
                            "PLR2004",
                            "ANN",
                            "C901",
                            "T20",
                            "FA",
                            "PLR0911",
                            "PLR0912",
                            "E303",
                            "E225",
                            "E226",
                            "E227",
                            "E228",
                            "E231",
                            "FBT",
                            "ERA",
                            "S311",
                            "ARG",
                        },
                    },
                    format = {
                        preview = true,
                    },
                },
            },
        })

        vim.lsp.config("stylua", {
            cmd = { "stylua", "--lsp", "--indent-type", "Spaces" },
        })

        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP signature help" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP rename" })
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
        vim.keymap.set({ "n", "v" }, "<leader>qq", vim.lsp.buf.format, { desc = "Format buffer" })
    end,
}
