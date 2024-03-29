-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local freedesktop = require("freedesktop")
local lain  = require("lain")

local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require(".tmuxHelp")
require(".zshHelp")
require(".vimHelp")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, there were errors during startup!",
			text = awesome.startup_errors
		})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function (err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true

		naughty.notify({ preset = naughty.config.presets.critical,
				title = "Oops, an error happened!",
			text = tostring(err) })
		in_error = false
	end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
chosen_theme = "xresources"
-- chosen_theme = "cesious"
-- chosen_theme = "blackburn"
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.floating,
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier,
	awful.layout.suit.corner.nw,
	-- awful.layout.suit.corner.ne,
	-- awful.layout.suit.corner.sw,
	-- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
	local instance = nil
	return function ()
		if instance and instance.wibox.visible then
			instance:hide()
			instance = nil
		else
			instance = awful.menu.clients({ theme = { width = 250 } })
		end
	end
end

local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end
-- }}}

-- {{{ Quit menu
local confirmQuitmenu = awful.menu({
	items = {
		{"Exit AwesomeWM?", function () do end end},
		{"NO", function () do end end},
		{"YES", function() awesome.quit() end}
	}
})

-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", string.format("%s %s", editor, awesome.conffile) },
    { "edit theme", string.format("%s %s", editor, ".config/awesome/themes/cesious/theme.lua") },
    { "restart", awesome.restart }
}

local myexitmenu = {
    { "Lock",      "i3lock -c 000000", "/usr/share/icons/gnome/24x24/actions/reload.png" },
    { "Exit",      function() awesome.quit() end, "/usr/share/icons/gnome/24x24/actions/reload.png" },
    { "Suspend",   "systemctl suspend", "/usr/share/icons/gnome/24x24/actions/reload.png" },
    { "Hibernate", "systemctl hibernate", "/usr/share/icons/gnome/24x24/actions/reload.png" },
    { "Reboot",    "systemctl reboot", "/usr/share/icons/gnome/24x24/actions/reload.png" },
    { "Shutdown",  "systemctl poweroff", "/usr/share/icons/gnome/24x24/actions/reload.png" }
}

local mymainmenu = freedesktop.menu.build({
    before = {
        { "Terminal", terminal, "/usr/share/icons/gnome/24x24/actions/reload.png" },
        { "Browser", browser, "/usr/share/icons/gnome/24x24/actions/reload.png" },
        { "Files", filemanager, "/usr/share/icons/gnome/24x24/actions/reload.png" },
        -- other triads can be put here
    },
    after = {
        { "Awesome", myawesomemenu, "/usr/share/awesome/icons/awesome16.png" },
        { "Exit", myexitmenu, "/usr/share/icons/gnome/24x24/actions/reload.png" },
        -- other triads can be put here
    }
})

local mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar
local taglist_buttons = gears.table.join(
	awful.button({ }, 1, function(t) t:view_only() end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({ }, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
	awful.button({ }, 1, function (c)
		if c == client.focus then
			c.minimized = true
		else
			-- Without this, the following
			-- :isvisible() makes no sense
			c.minimized = false
			if not c:isvisible() and c.first_tag then
				c.first_tag:view_only()
			end
			-- This will also un-minimize
			-- the client, if needed
			client.focus = c
			c:raise()
		end
	end),
	awful.button({ }, 3, client_menu_toggle_fn()),
	awful.button({ }, 4, function ()
		awful.client.focus.byidx(1)
	end),
	awful.button({ }, 5, function ()
		awful.client.focus.byidx(-1)
	end)
)

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
local mytextclock = wibox.widget.textclock(" %H:%M ", 60)
mytextclock.font = beautiful.font
local mytextdate = wibox.widget.textclock(" %d.%m.%Y ", 21600)
mytextdate.font = beautiful.font

-- Calendar
local cal = lain.widget.cal({
   attach_to = { mytextdate },
   notification_preset = {
      font = beautiful.font,
      fg   = beautiful.fg_normal,
      bg   = beautiful.bg_normal
   }
})

-- RAM widget
-- local ramwidget = require("../../widgets/ramwidget")

-- CPU widget
-- local cpuwidget = require("../../widgets/cpuwidget")

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)
	-- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])
	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
			awful.button({ }, 1, function () awful.layout.inc( 1) end),
			awful.button({ }, 3, function () awful.layout.inc(-1) end),
			awful.button({ }, 4, function () awful.layout.inc( 1) end),
			awful.button({ }, 5, function () awful.layout.inc(-1) end))
	)
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)
	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist{
		screen = s, 
		filter = awful.widget.tasklist.filter.currenttags, 
		buttons = tasklist_buttons,
	}
	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s })
	-- Add widgets to the wibox
	-- beautiful.initBar(s, {mylauncher, s.mytaglist, s.mypromptbox}, {s.mytasklist}, {wibox.widget.systray(), mytextclock, mytextdate, s.mylayoutbox})
	s.mywibox:setup {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
         layout = wibox.layout.fixed.horizontal,
			mylauncher, 
			s.mytaglist, 
			s.mypromptbox,
      },
      s.mytasklist,
      { -- Right widgets
         layout = wibox.layout.fixed.horizontal,
			wibox.widget.systray(), 
			mykeyboardlayout,
			mytextclock, 
			mytextdate,
			s.mylayoutbox,
      },
   }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
	awful.button({ }, 3, function () mymainmenu:toggle() end),
	awful.button({ }, 4, awful.tag.viewnext),
	awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

local wmAwesomeG = "WM: awesome"
local wmClientG = "WM: client"
local wmTagG = "WM: tag"
local wmScreenG = "WM: screen"
local wmLauncherG = "WM: launcher"
local wmLayoutG = "WM: layout"
-- {{{ Key bindings
globalkeys = gears.table.join(
	awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
		{description="show help", group=wmAwesomeG}),
	awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
		{description = "view previous", group = wmTagG}),
	awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
		{description = "view next", group = wmTagG}),
	awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
		{description = "go back", group = wmTagG}),

	awful.key({ modkey,           }, "j",
		function ()
			awful.client.focus.byidx( 1)
		end,
		{description = "focus next by index", group = wmClientG}
	),
	awful.key({ modkey,           }, "k",
		function ()
			awful.client.focus.byidx(-1)
		end,
		{description = "focus previous by index", group = wmClientG}
	),
	awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
		{description = "show main menu", group = wmAwesomeG}),

	-- Layout manipulation
	awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
		{description = "swap with next client by index", group = wmClientG}),
	awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
		{description = "swap with previous client by index", group = wmClientG}),
	awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
		{description = "focus the next screen", group = wmScreenG}),
	awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
		{description = "focus the previous screen", group = wmScreenG}),
	awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
		{description = "jump to urgent client", group = wmClientG}),
	awful.key({ modkey,           }, "Tab",
		function ()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end,
		{description = "go back", group = wmClientG}),

	-- Standard program
	awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
		{description = "open a terminal", group = wmLauncherG}),
	awful.key({ modkey, "Control" }, "r", awesome.restart,
		{description = "reload awesome", group = wmAwesomeG}),
	awful.key({ modkey, "Shift"   }, "q", function () confirmQuitmenu:show() end,
		{description = "Confirm Awesome wm exit", group = wmAwesomeG}),

	awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
		{description = "increase master width factor", group = wmLayoutG}),
	awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
		{description = "decrease master width factor", group = wmLayoutG}),
	awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
		{description = "increase the number of master clients", group = wmLayoutG}),
	awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
		{description = "decrease the number of master clients", group = wmLayoutG}),
	awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
		{description = "increase the number of columns", group = wmLayoutG}),
	awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
		{description = "decrease the number of columns", group = wmLayoutG}),
	awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
		{description = "select next", group = wmLayoutG}),
	awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
		{description = "select previous", group = wmLayoutG}),

	awful.key({ modkey, "Control" }, "n",
		function ()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
				client.focus = c
				c:raise()
			end
		end,
		{description = "restore minimized", group = wmClientG}),

	-- Prompt
	awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
		{description = "run prompt", group = wmLauncherG}),

	awful.key({ modkey }, "x",
		function ()
			awful.prompt.run {
				prompt       = "Run Lua code: ",
				textbox      = awful.screen.focused().mypromptbox.widget,
				exe_callback = awful.util.eval,
				history_path = awful.util.get_cache_dir() .. "/history_eval"
			}
		end,
		{description = "lua execute prompt", group = wmAwesomeG}),
	-- Menubar
	awful.key({ modkey }, "p", function () menubar.show() end,
		{description = "show the menubar", group = wmLauncherG})
)

clientkeys = gears.table.join(
	awful.key({ modkey,           }, "f",
		function (c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
		{description = "toggle fullscreen", group = wmClientG}),
	awful.key({ modkey, "Shift"   }, "c", function (c) c:kill() end,
		{description = "close", group = wmClientG}),
	awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
		{description = "toggle floating", group = wmClientG}),
	awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
		{description = "move to master", group = wmClientG}),
	awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
		{description = "move to other screen", group = wmScreenG}),
	awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
		{description = "toggle keep on top", group = wmClientG}),
	awful.key({ modkey,           }, "n",
		function (c)
			-- The client currently has the input focus, so it cannot be
			-- minimized, since minimized clients can't have the focus.
			c.minimized = true
		end ,
		{description = "minimize", group = wmClientG}),
	awful.key({ modkey,           }, "m",
		function (c)
			c.maximized = not c.maximized
			c:raise()
		end ,
		{description = "(un)maximize", group = wmClientG}),
	awful.key({ modkey, "Control" }, "m",
		function (c)
			c.maximized_vertical = not c.maximized_vertical
			c:raise()
		end ,
		{description = "(un)maximize vertically", group = wmClientG}),
	awful.key({ modkey, "Shift"   }, "m",
		function (c)
			c.maximized_horizontal = not c.maximized_horizontal
			c:raise()
		end ,
		{description = "(un)maximize horizontally", group = wmClientG})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = gears.table.join(globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9,
			function ()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					tag:view_only()
				end
			end,
			{description = "view tag #"..i, group = wmTagG}),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9,
			function ()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end,
			{description = "toggle tag #" .. i, group = wmTagG}),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9,
			function ()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
				end
			end,
			{description = "move focused client to tag #"..i, group = wmTagG}),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
			function ()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:toggle_tag(tag)
					end
				end
			end,
			{description = "toggle focused client on tag #" .. i, group = wmTagG})
	)
end

clientbuttons = gears.table.join(
	awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
	awful.button({ modkey }, 1, awful.mouse.client.move),
	awful.button({ modkey }, 3, awful.mouse.client.resize)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
		-- All clients will match this rule.
		{ rule = { },
			properties = { border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap+awful.placement.no_offscreen
		}
	},

	-- Floating clients.
	{ rule_any = {
		instance = {
			"DTA",  -- Firefox addon DownThemAll.
			"copyq",  -- Includes session name in class.
		},
		class = {
			"Arandr",
			"Gpick",
			"Kruler",
			"MessageWin",  -- kalarm.
			"Sxiv",
			"Wpa_gui",
			"pinentry",
			"veromix",
			"xtightvncviewer"
		},
		name = {
			"Event Tester",  -- xev.
		},
		role = {
			"AlarmWindow",  -- Thunderbird's calendar.
			"pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
		}
	}, properties = { floating = true }},

	-- Add titlebars to normal clients and dialogs
	{ rule_any = {type = { "normal", "dialog" }
		}, properties = { titlebars_enabled = false }
	},

	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- { rule = { class = "Firefox" },
	--   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and
		not c.size_hints.user_position
		and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({ }, 1, function()
			client.focus = c
			c:raise()
			awful.mouse.client.move(c)
		end),
		awful.button({ }, 3, function()
			client.focus = c
			c:raise()
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c) : setup {
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout  = wibox.layout.fixed.horizontal
		},
		{ -- Middle
			{ -- Title
				align  = "center",
				widget = awful.titlebar.widget.titlewidget(c)
			},
			buttons = buttons,
			layout  = wibox.layout.flex.horizontal
		},
		{ -- Right
			awful.titlebar.widget.floatingbutton (c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton   (c),
			awful.titlebar.widget.ontopbutton    (c),
			awful.titlebar.widget.closebutton    (c),
			layout = wibox.layout.fixed.horizontal()
		},
		layout = wibox.layout.align.horizontal
	}
end)

	-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
		and awful.client.focus.filter(c) then
		client.focus = c
	end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

awful.spawn.with_shell("~/.config/awesome/autorun.sh")


-- vim: tabstop=3 noexpandtab shiftwidth=3 softtabstop=3
