return {
    "Julian/lean.nvim",
    event = { "BufReadPre *.lean", "BufNewFile *.lean" },

    init = function()
        ---@type lean.Config
        vim.g.lean_config = { mappings = true }
    end,
}
