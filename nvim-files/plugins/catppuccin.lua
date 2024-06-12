return { 
    "catppuccin/nvim", 
    name = "catppuccin", 
    priority = 1000,
    config = function()
        -- Colour scheme setup
        vim.cmd.colorscheme "catppuccin"
    end
}
