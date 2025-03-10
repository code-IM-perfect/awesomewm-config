local awful = require 'awful'
local ruled = require 'ruled'

ruled.client.connect_signal('request::rules', function()
   -- All clients will match this rule.
   ruled.client.append_rule {
      id         = 'global',
      rule       = {},
      properties = {
         focus     = awful.client.focus.filter,
         raise     = true,
         screen    = awful.screen.preferred,
         placement = awful.placement.no_overlap + awful.placement.no_offscreen
      }
   }

   -- Floating clients.
   ruled.client.append_rule {
      id = 'floating',
      rule_any = {
         instance = { 'copyq', 'pinentry' },
         class = {
            'Arandr',
            'Blueman-manager',
            'Gpick',
            'Kruler',
            'Sxiv',
            -- 'Tor Browser', -- Needs a fixed window size to avoid fingerprinting by screen size.
            'Wpa_gui',
            'veromix',
            'xtightvncviewer',
            "MEGAsync",
            "zoom",
         },
         -- Note that the name property shown in xprop might be set slightly after creation of the client
         -- and the name shown there might not match defined rules here.
         name = {
            'Event Tester', -- xev.
         },
         role = {
            'AlarmWindow',   -- Thunderbird's calendar.
            'ConfigManager', -- Thunderbird's about:config.
            'pop-up',        -- e.g. Firfox's (detached) Developer Tools.
         }
      },
      properties = { floating = true }
   }

   -- Add titlebars to normal clients and dialogs
   ruled.client.append_rule {
      id         = 'titlebars',
      rule_any   = { type = { 'normal', 'dialog' } },
      properties = { titlebars_enabled = false },
   }

   -- ruled.client.append_rule {
   --    id         = 'titlebarrr',
   --    rule_any   = { floating = true },
   --    properties = { titlebars_enabled = true },
   -- }

   -- Set Firefox to always map on the tag named '2' on screen 1.
   -- ruled.client.append_rule {
   --    rule       = {class = 'Firefox'},
   --    properties = {screen = 1, tag = '2'}
   -- }
   ruled.client.append_rule {
      rule       = {class = 'MEGAsync'},
      properties = {placement = awful.placement.top_right}
   }
   ruled.client.append_rule {
      rule_any    = {
         instance = {
            'Devtools',
         },
         class = {
            'Emulator',
            'com.github.Aylur.ags',
            'Com.github.Aylur.ags',
         }
      },
      properties  = {floating=true, ontop = true}
   }
end)
