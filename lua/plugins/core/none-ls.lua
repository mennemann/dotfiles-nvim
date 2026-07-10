return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local null_ls = require("null-ls")

        null_ls.register({
            method = null_ls.methods.FORMATTING,
            filetypes = { "bib" },
            generator = null_ls.formatter({
                command = "bibtex-tidy",
                to_stdin = true,
                args = {
                    "--v2",
                    "--blank-lines",
                },
            }),
        })

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.prettier.with({
                    extra_args = { "--tab-width", "4", "--print-width", "150" },
                }),
            },
        })
    end,
}
