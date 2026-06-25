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

        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = false,
        })

        local do_auto_format = true
        local lsp_augroup = vim.api.nvim_create_augroup("user_lsp", { clear = true })

        local function can_format_buffer(bufnr)
            return vim.bo[bufnr].buftype == "" and vim.bo[bufnr].modifiable
        end

        vim.api.nvim_create_autocmd("BufWritePre", {
            group = lsp_augroup,
            pattern = "*",
            callback = function(event)
                if do_auto_format and can_format_buffer(event.buf) then
                    local ok, err = pcall(vim.lsp.buf.format, { bufnr = event.buf, timeout_ms = 3000 })
                    if not ok then
                        vim.notify("Autoformat failed: " .. err, vim.log.levels.WARN)
                    end

                    if not vim.tbl_contains({ "markdown", "tex" }, vim.bo[event.buf].filetype) then
                        local view = vim.fn.winsaveview()
                        vim.cmd([[keeppatterns %s/\s\+$//e]])
                        vim.fn.winrestview(view)
                    end
                end
            end,
        })

        vim.api.nvim_create_user_command("W", function()
            do_auto_format = false
            local ok, err = pcall(vim.cmd, "write")
            do_auto_format = true

            if not ok then
                error(err)
            end
        end, {})

        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP signature help" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP rename" })
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
        vim.keymap.set({ "n", "v" }, "<leader>qq", vim.lsp.buf.format, { desc = "Format buffer" })
        vim.keymap.set("n", "Q", function()
            vim.diagnostic.open_float(0, { scope = "line" })
        end, { desc = "Show diagnostic for current line" })
    end,
}
