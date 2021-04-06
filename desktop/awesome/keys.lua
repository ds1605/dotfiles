-- =============================== --
-- Awesome Window Manager Keybinds --
-- =============================== --

-- Table reference
-- Each keybind sections contains a table, with the following entries:
-- type(table): modifier keys
-- type(string): input key
-- type(function): execute function
-- type(table): contains description, and function group

---------------
-- Variables --
---------------

-- Mod4 for logo key, Mod1 for alt key
key_mod = "Mod4"

-- Group names
group_awesome = "Awesome"
group_launcher = "Launcher"
group_layout = "Layout"
group_tags = "Tags"

-- Prompts
prompt_lua = "Run Lua code"

-----------
-- Mouse --
-----------
local binds_mouse = {
  {
    {nil}, 3, function()
      return nil
    end,
    {
      description = "Launcher",
      group = "Launcher"
    }
  },
  {
    {nil}, 4, awful.tag.viewprev,
    {
      description = "View previous tag",
      group = group_tags
    }
  },
  {
    {nil}, 5, awful.tag.viewnext,
    {
      description = "View next tag",
      group = group_tags
    }
  }
}

local binds_mouse_client = {
  -- Focus window by mouse
  {
    {}, "1", function(c)
      c:activate {context = "mouse_click"}
    end,
    {
      description = "Focus window by mouse",
      group = group_layout
    }
  },

  -- Move window by mouse
  {
    {key_mod}, "1", function(c)
      c:activate {context = "mouse_click", action = "mouse_move"}
    end,
    {
      description = "Move window by mouse",
      group = group_layout
    }
  },

  -- Resize window by mouse
  {
    {key_mod}, "3", function(c)
      c:activate {context = "mouse_click", action = "mouse_resize"}
    end,
    {
      description = "Resize window by mouse",
      group = group_layout
    }
  }
}

--------------
-- Keyboard --
--------------
binds_keys = {
  -- Quit awesome
  {
    {key_mod, "Control"}, "e", awesome.quit,
    {
      description = "Quit Awesome",
      group = group_awesome
    }
  },

  -- Restart Awesome
  {
    {key_mod, "Control"}, "r", awesome.restart,
    {
      decsription = "Restart Awesome",
      group = group_awesome
    }
  },

  -- Show Awesome help popup
  {
    {key_mod, "Control"}, "s", function()
      hotpop.show_help()
    end,
    {
      description = "Show help",
      group = group_awesome
    }
  },

  -- Spawn launcher
  {
    {key_mod}, "d", function()
      awful.spawn(DIR_CONFIG .. "scripts/rofi.sh")
    end,
    {
      description = "Spawn launcher",
      group = group_launcher
    }
  },

  -- Spawn terminal
  {
    {key_mod}, "Return", function()
      awful.spawn(terminal)
    end,
    {
      description = "Spawn terminal",
      group = group_awesome
    }
  },

  -- Spawn editor
  {
		{key_mod}, "e", function()
			awful.spawn(editor_cmd)
		end,
		{
			description = "Spawn editor",
			group = group_awesome
		}
  },

  -- Lua prompt
  {
    {key_mod, "Control"}, "l", function()
      awful.propmt.run {
        prompt = prompt_lua,
      }
    end,
    {
      description = "Run Lua code",
      group = "Awesome"
    }
  },

  -- View next tag
  {
    {key_mod}, "Left", awful.tag.viewprev,
    {
      description = "View previous tag",
      group = group_tags
    }
  },

  -- View next tag
  {
    {key_mod}, "Right", awful.tag.viewnext,
    {
      description = "View next tag",
      group = group_tags
    }
  },

  -- View last tag
  {
    {key_mod}, "Escape", awful.tag.history.restore,
    {
      description = "View last tag",
      group = group_tags
    }
  },

  -- Focus next window
  {
    {key_mod}, "j",
    function()
      awful.client.focus.byidx(-1)
    end,
    {
      description = "Focus next window (index)",
      group = group_layout
    }
  },

  -- Focus previous window
  {
    {key_mod}, "k",
    function()
      awful.client.focus.byidx(1)
    end,
    {
      description = "Focus previous window (index)",
      group = group_layout
    }
  },

  -- Focus last window
  {
    {key_mod}, "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end,
    {
      description = "Focus last window",
      group = group_layout
    }
  }
}

binds_keys_client = {
  -- Kill selected window
  {
    {key_mod, "Shift"}, "q", function(c)
      c:kill()
    end,
    {
      description = "Close selected window",
      group = group_layout
    }
  },

  -- Fullscreen selected window
  {
    {key_mod}, "f", function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {
      description = "Fullscreen selected window",
      group = group_layout
    }
  },

  -- Maximise selected window
  {
    {key_mod}, "m", function(c)
      c.maximize = not c.maximize
      c:maximize()
    end,
    {
      description = "Maximize selected window",
      group = group_layout
    }
  }
}

-- Number row binds
awful.keyboard.append_global_keybindings(
  {
    -- Focus tag by number
    awful.key {
      modifiers = {key_mod},
      keygroup = "numrow",
      description = "Focus tag by number",
      group = group_tags,
      on_press = function(i)
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end
    },

    -- Toggle tag by number
    awful.key {
      modifiers = {key_mod, "Control"},
      keygroup = "numrow",
      description = "Toggle tag by number",
      group = group_tags,
      on_press = function(i)
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end
    },

    -- Move focused window to tag
    awful.key {
      modifiers = {key_mod, "Shift"},
      keygroup = "numrow",
      decscription = "Move focused window to tag",
      group = group_tags,
      on_press = function(i)
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end
    },

    -- Toggle client on tag
    awful.key {
      modifiers = {key_mod, "Control", "Shift"},
      keygroup = "numrow",
      description = "Toggle focused window on tag",
      group = group_tags,
      on_press = function(i)
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end
    }
  }
)

for k,v in pairs(binds_mouse) do
  awful.mouse.append_global_mousebindings(
    {
      awful.button(v[1], v[2], v[3], v[4])
    }
  )
end

for k,v in pairs(binds_mouse_client) do
  client.connect_signal(
    "request::default_mousebindings",
    function()
      awful.mouse.append_client_mousebindings(
        {
          awful.button(v[1], v[2], v[3], v[4])
        }
      )
    end
  )
end

for k,v in pairs(binds_keys) do
  awful.keyboard.append_global_keybindings(
    {
      awful.key(v[1], v[2], v[3], v[4])
    }
  )
end

for k,v in pairs(binds_keys_client) do
  client.connect_signal(
    "request::default_keybindings",
    function()
      awful.keyboard.append_client_keybindings(
        {
          awful.key(v[1], v[2], v[3], v[4])
        }
      )
    end
  )
end
