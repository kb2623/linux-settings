--[[

        Blackburn Awesome WM theme 3.0
        github.com/lcpz

--]]

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/blackburn"
theme.font                                      = "IBM 3270 Narrow Bold 12"
theme.taglist_font                              = theme.font
theme.notification_font                         = theme.font
theme.hotkeys_font                              = theme.font
theme.hotkeys_description_font                  = theme.font
theme.keyboardlayout_font                       = theme.font

theme.bg_normal                                 = xrdb.color0
theme.bg_systray                                = theme.bg_normal
theme.fg_normal                                 = "#D7D7D7"
theme.fg_focus                                  = "#F6784F"
theme.bg_focus                                  = "#091F2E"
theme.fg_urgent                                 = "#CC9393"
theme.bg_urgent                                 = "#2A1F1E"

theme.useless_gap                               = dpi(2)
theme.border_width                              = dpi(1)
theme.border_normal                             = "#000000"
theme.border_marked                             = "#16A085"
theme.border_normal                             = theme.bg_focus
theme.border_focus                              = xrdb.color5
theme.border_marked                             = xrdb.color10

theme.menu_height                               = dpi(16)
theme.menu_width                                = dpi(130)

theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.awesome_icon                              = theme.dir .."/icons/awesome.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

-- Icon theme
theme.icon_theme = "Arc-Maia"

-- Taglist names
awful.util.tagnames   = { "ƀ", "Ƅ", "Ɗ", "ƈ", "ƙ" }

-- Wallpaper
local wallpaper_bg = xrdb.color0
local wallpaper_fg = xrdb.color7
local wallpaper_alt_fg = xrdb.color12
theme.wallpaper = function(s)
   return theme_assets.wallpaper(wallpaper_bg, wallpaper_fg, wallpaper_alt_fg, s)
end

-- Keyboard map indicator and switcher
theme.mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
theme.mytextclock = wibox.widget.textclock("%H:%M")
theme.mytextclock.font = theme.font
theme.mytextdate = wibox.widget.textclock("%d.%m.%Y")
theme.mytextdate.font = theme.font

-- Separators
local markup = lain.util.markup
local separators = lain.util.separators
local arrowl = separators.arrow_left
local arrowr = separators.arrow_right

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
         arrowl(theme.bg_normal, "#343434"),
         wibox.container.background(wibox.container.margin(wibox.widget { theme.mykeyboardlayout, layout = wibox.layout.align.horizontal }, 3, 6), "#343434"),
         arrowl("#343434", theme.bg_normal),
         wibox.widget.systray(),
         arrowl(theme.bg_normal, "#343434"),
         wibox.container.background(wibox.container.margin(wibox.widget { theme.mytextclock, layout = wibox.layout.align.horizontal }, 6, 3), "#343434"),
         arrowl("#343434", theme.bg_normal),
         wibox.container.background(wibox.container.margin(wibox.widget { theme.mytextdate, layout = wibox.layout.align.horizontal }, 6, 3), theme.bg_normal),
         s.mylayoutbox,
      },
   }
end

return theme
-- vim: filetype=lua:expandtab:shiftwidth=3:tabstop=6:softtabstop=3:textwidth=80
