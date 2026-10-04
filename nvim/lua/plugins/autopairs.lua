-- For https://github.com/windwp/nvim-autopairs
require('nvim-autopairs').setup({
    break_undo = false, -- switch for basic rule break undo sequence
    disable_in_macro = true,
    disable_in_replace_mode = true,
    disable_in_visualblock = false,
    enable_afterquote = true, -- add bracket pairs after quote
    enable_check_bracket_line = true, --- check bracket in same line
})
