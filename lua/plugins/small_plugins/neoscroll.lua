return {
    "karb94/neoscroll.nvim",
    config = function()
        local neoscroll = require("neoscroll")
        neoscroll.setup({ mappings = {} })

        vim.keymap.set({ "n", "v", "x" }, "<S-Up>", function()
            neoscroll.ctrl_u({ duration = 250 })
        end, {})
        vim.keymap.set({ "n", "v", "x" }, "<S-Down>", function()
            neoscroll.ctrl_d({ duration = 250 })
        end, {})
    end,
}
