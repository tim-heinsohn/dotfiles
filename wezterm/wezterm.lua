local wezterm = require 'wezterm'
local config = {
    -- launch Zsh with login option for rvm
    default_prog = { '/bin/zsh', '-l' },

    -- font
    font = wezterm.font_with_fallback {
        'JetBrainsMono Nerd Font Mono',
        'Noto Color Emoji',
    },
    font_size = 10.0,
    warn_about_missing_glyphs = false,

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
