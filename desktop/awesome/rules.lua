-- ===== --
-- Rules --
-- ===== --

ruled.client.connect_signal(
  -- For all clients
  "request::rules",
  function()
    ruled.client.append_rule {
      id = "global",
      rule = {},
      properties = {
        focus = awful.client.focus.filter,
        raise = true,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap+awful.placement.no_offscreen
      }
    }
  end
)

-- Notifications
naughty.connect_signal(
  "request::display",
  function(n)
    naughty.layout.box {notification = n}
  end
)

-- Sloppy focus
client.connect_signal(
  "mouse::enter",
  function(c)
    c:activate {
      context = "mouse_enter",
      raise = false
    }
  end
)
