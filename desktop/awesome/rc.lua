-- ==================================== --
-- Awesome Window Manager Configuration --
-- ==================================== --

pcall(require, "luarocks.loader")

---------------
-- Variables --
---------------

-- Standard libraries
gears = require("gears")
awful = require("awful")
wibox = require("wibox")
beautiful = require("beautiful")
naughty = require("naughty")
ruled = require("ruled")
menubar = require("menubar")
hotpop = require("awful.hotkeys_popup")

require("awful.autofocus")
require("awful.hotkeys_popup.keys")

-- External libraries

-- Directories
DIR_CONFIG = gears.filesystem.get_configuration_dir()
DIR_THEMES = gears.filesystem.get_themes_dir()

-- File directories
file_keys_config = "/keys.lua"

terminal = "kitty"
editor = "emacs"
editor_cmd = editor

window_taglist = {"1", "2", "3", "4", "5"}



--------------------
-- Error Handling --
--------------------
naughty.connect_signal("request::display_error",
	function(message, startup)
		naughty.notification {
			urgency = "critical",
			title = "An error has occurred" .. (" during startup!" or "!"),
			message = message
		}
	end
)



-------------
-- Desktop --
-------------

-- Window layout
tag.connect_signal("request::default_layouts",
	function()
		awful.layout.append_default_layouts(
			{
              awful.layout.suit.tile
			}
		)
	end
)

-- Wallpaper
screen.connect_signal("request::wallpaper",
	function(s)
		if beautiful.wallpaper then
			local wallpaper = beautiful.wallpaper
			-- If wallpaper is function, call it with the screen
			if type(wallpaper) == "function" then
				wallpaper = wallpaper(s)
			end
			gears.wallpaper.maximized(wallpaper, s, true)
		end
	end
)

-- Wibars and widgets
local widget_battery = require("awesome-wm-widgets.batteryarc-widget.batteryarc")

-- Create and apply widgets to the wibar
screen.connect_signal("request::desktop_decoration",
	function(s)
		-- Create tags for each screen
		awful.tag(window_taglist, s, awful.layout.layouts[1])
		s.taglist = awful.widget.taglist {
			screen = s,
			filter = awful.widget.taglist.filter.all,
			buttons = {
				awful.button({}, 1, function(t) t:view_only(); end),
				awful.button({key_mod}, 1,
					function(t)
						if client.focus then
							client.focus:move_to_tag(t)
						end
					end
				),
				awful.button({}, 3, awful.tag.viewtoggle),
				awful.button({key_mod}, 3,
					function(t)
						if client.focus then
							client.focus:toggle_tag(3)
						end
					end
				),
				awful.button({}, 5, function(t) awful.tag.viewnext(t.screen); end),
				awful.button({}, 4, function(t) awful.tag.viewprev(t.screen); end)
			}
		}

		-- Promptbox
		s.promptbox = awful.widget.prompt()

		-- Layout indicator
		s.layoutbox = awful.widget.layoutbox {
			screen = s,
			buttons = {
				awful.button({}, 1, function() awful.layout.inc(1); end),
				awful.button({}, 3, function() awful.layout.inc(-1); end),
				awful.button({}, 5, function() awful.layout.inc(1); end),
				awful.button({}, 4, function() awful.layout.inc(-1); end)
			}
		}

		-- Tasklist
		s.tasklist = awful.widget.tasklist {
			screen = s,
			filter = awful.widget.tasklist.filter.currenttags,
			buttons = {
				awful.button({}, 1,
					function(c)
						c:activate {
							context = "tasklist",
							action = "toggle_minimization"
						}
					end
				),
				awful.button({}, 3,
					function()
						awful.menu.client_list {
							theme = {width = 200}
						}
					end
				),
				awful.button({}, 5, function() awful.menu.focus.byidx(1); end),
				awful.button({}, 4, function() awful.menu.focus.byidx(-1); end)
			}
		}

		-- Wibox and widgets
        s.wibox = awful.wibar(
          {
            position = "top",
            screen = s
          }
        )
        s.wibox.widget = {
			layout = wibox.layout.align.horizontal,
			-- Left
			{
				layout = wibox.layout.fixed.horizontal,
				s.taglist,
				s.promptbox
			},
			-- Centre
			{
				layout = wibox.layout.fixed.horizontal,
				s.tasklist
			},
			-- Right
			{
              layout = wibox.layout.fixed.horizontal,
              widget_battery(
                {
                  show_current_level = true,
                  arc_thickness = 2
                }
              ),
				wibox.widget.systray(),
				s.layoutbox
			}
		}
	end
)

-- Load keybinds
dofile(DIR_CONFIG .. file_keys_config)
