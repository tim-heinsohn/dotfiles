local wezterm = require 'wezterm'
local config = {
    -- launch Zsh with login option for rvm
    default_prog = { '/bin/zsh', '-l' },

    -- font
    font_size = 10.0,

    -- tab bar
    tab_bar_at_bottom = false,
    hide_tab_bar_if_only_one_tab = true,

    keys = {
        {
            key = 'Enter',
            mods = 'SHIFT',
            action = wezterm.action.SendString('\n'),
        },
    },
}

return config
