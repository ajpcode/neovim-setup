return {
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = { "lua_ls", "zls", "clangd" }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require('lspconfig')
            lspconfig.lua_ls.setup({})
            lspconfig.clangd.setup({})
            lspconfig.cmake.setup({})
            lspconfig.zls.setup({})

            vim.keymap.set('n', '<Leader>h', vim.lsp.buf.hover, {})
        end
    },
}
