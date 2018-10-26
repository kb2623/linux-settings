--[[
    Cesious Awesome WM theme
    Created by Culinax
--]]

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local dpi = xresources.apply_dpi
local fs = require("gears.filesystem")

theme = {}
theme.dir = fs.get_xdg_config_home() .. "/awesome/themes/cesious"

theme.font          = "sans 11"

theme.bg_normal     = xrdb.color0
theme.bg_focus      = xrdb.color12
theme.bg_urgent     = xrdb.color9
theme.bg_minimize   = xrdb.color8
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = xrdb.foreground
theme.fg_focus      = theme.bg_normal
theme.fg_urgent     = theme.bg_normal
theme.fg_minimize   = theme.bg_normal

theme.border_normal = "#000000"
theme.border_focus  = "#16A085"
theme.border_marked = "#16A085"

theme.useless_gap   = dpi(3)
theme.border_width  = dpi(2)
theme.border_normal = xrdb.color8
theme.border_focus  = theme.bg_focus
theme.border_marked = xrdb.color10

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = theme.dir .. "/taglist/squarefw.png"
theme.taglist_squares_unsel = theme.dir .. "/taglist/squarew.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme.dir .. "/icons/submenu.png"
theme.menu_height = 25
theme.menu_width  = 200

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal              = theme.dir .. "/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.dir .. "/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/titlebar/maximized_focus_active.png"

-- Try to determine if we are running light or dark colorscheme:
local bg_numberic_value = 0;
for s in theme.bg_normal:gmatch("[a-fA-F0-9][a-fA-F0-9]") do
    bg_numberic_value = bg_numberic_value + tonumber("0x"..s);
end
local is_dark_bg = (bg_numberic_value < 383)

-- Generate wallpaper:
local wallpaper_bg = xrdb.color0
local wallpaper_fg = xrdb.color7
local wallpaper_alt_fg = xrdb.color12
if not is_dark_bg then
    wallpaper_bg, wallpaper_fg = wallpaper_fg, wallpaper_bg
end
theme.wallpaper = function(s)
    return theme_assets.wallpaper(wallpaper_bg, wallpaper_fg, wallpaper_alt_fg, s)
end

-- theme.wallpaper = "/usr/share/backgrounds/awesome-scrabble3.png"

-- You can use your own layout icons like this:
theme.layout_fairh      = theme.dir .. "/layouts/fairh.png"
theme.layout_fairv      = theme.dir .. "/layouts/fairv.png"
theme.layout_floating   = theme.dir .. "/layouts/floating.png"
theme.layout_magnifier  = theme.dir .. "/layouts/magnifier.png"
theme.layout_max        = theme.dir .. "/layouts/max.png"
theme.layout_fullscreen = theme.dir .. "/layouts/fullscreen.png"
theme.layout_tilebottom = theme.dir .. "/layouts/tilebottom.png"
theme.layout_tileleft   = theme.dir .. "/layouts/tileleft.png"
theme.layout_tile       = theme.dir .. "/layouts/tile.png"
theme.layout_tiletop    = theme.dir .. "/layouts/tiletop.png"
theme.layout_spiral     = theme.dir .. "/layouts/spiral.png"
theme.layout_dwindle    = theme.dir .. "/layouts/dwindle.png"

theme.awesome_icon = theme.dir .. "/icons/manjaro64.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "Arc-Maia"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
