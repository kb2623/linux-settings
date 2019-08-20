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

theme.font          = "IBM 3270 Narrow 12"

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

-- Display the taglist squares
theme.taglist_squares_sel   = theme.dir .. "/taglist/squarefw.png"
theme.taglist_squares_unsel = theme.dir .. "/taglist/squarew.png"

-- Variables set for theming the menu:
theme.menu_submenu_icon = theme.dir .. "/icons/submenu.png"
theme.menu_height = dpi(16)
theme.menu_width  = dpi(130)

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

-- Keyboard map indicator and switcher
theme.mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
theme.mytextclock = wibox.widget.textclock("%H:%M - %d.%m.%Y")
theme.mytextclock.font = theme.font

function theme.initBar(s)
   s.mywibox:setup {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
         layout = wibox.layout.fixed.horizontal,
         s.mylauncher,
         s.mytaglist,
         s.mypromptbox,
      },
      s.mytasklist, -- Middle widget
      { -- Right widgets
         layout = wibox.layout.fixed.horizontal,
         wibox.container.background(wibox.container.margin(wibox.widget { theme.mykeyboardlayout, layout = wibox.layout.align.horizontal }, 3, 6), theme.bg_normal),
         wibox.widget.systray(),
         wibox.container.background(wibox.container.margin(wibox.widget { theme.mytextclock, layout = wibox.layout.align.horizontal }, 3, 6), theme.bg_normal),
         s.mylayoutbox,
      },
   }
end

return theme
-- vim: filetype=lua:expandtab:shiftwidth=3:tabstop=6:softtabstop=3:textwidth=80
