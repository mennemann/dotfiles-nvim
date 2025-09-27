return {
    "uga-rosa/ccc.nvim",
    config = function()
        local ccc = require("ccc")
        ccc.setup({

            highlighter = {
                auto_enable = true,
                lsp = true,
            },
            inputs = {
                ccc.input.rgb,
                ccc.input.hsl,
                --				ccc.input.hwb,
                --				ccc.input.lab,
                --				ccc.input.lch,
                --				ccc.input.oklab,
                --				ccc.input.oklch,
                ccc.input.cmyk,
                --				ccc.input.hsluv,
                --				ccc.input.okhsl,
                ccc.input.hsv,
                --				ccc.input.okhsv,
                --				ccc.input.xyz,
            },
        })
        vim.keymap.set("n", "<leader>cc", ":CccPick<CR>", {})
    end,
}
