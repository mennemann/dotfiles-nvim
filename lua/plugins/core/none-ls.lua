return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.register({
            method = null_ls.methods.FORMATTING,
            filetypes = { "bib" },
            generator = null_ls.formatter({
                command = "bibtex-tidy",
                args = {
                    "$FILENAME",
                    "--v2",
                    "--blank-lines",
                }
            }),
        })

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettier,
            },
        })
        vim.keymap.set("n", "<leader>qq", vim.lsp.buf.format, {})
    end,
}
