local _M          = {}

local awful       = require 'awful'
-- local hotkeys_popup = require 'awful.hotkeys_popup'
local beautiful   = require 'beautiful'
local wibox       = require 'wibox'
local gears       = require 'gears'

local apps        = require 'config.apps'
local mod         = require 'bindings.mod'

local cool        = require("cool")

-- _M.awesomemenu = {
--    {'hotkeys', function() hotkeys_popup.show_help(nil, awful.screen.focused()) end},
--    {'manual', apps.manual_cmd},
--    {'edit config', apps.editor_cmd .. ' ' .. awesome.conffile},
--    {'restart', awesome.restart},
--    {'quit', function() awesome.quit() end},
-- }

-- _M.mainmenu = awful.menu{
--    items = {
--       {'awesome', _M.awesomemenu, beautiful.awesome_icon},
--       {'open terminal', apps.terminal}
--    }
-- }

-- _M.launcher = awful.widget.launcher{
--    image = beautiful.awesome_icon,
--    menu = _M.mainmenu
-- }

_M.keyboardlayout = awful.widget.keyboardlayout()
_M.textclock      = wibox.widget.textclock()




_M.batteryText = wibox.widget.textbox("69%")
_M.batteryIcon = wibox.widget.imagebox()
_M.batteryContainer = wibox.container.background({
   _M.batteryIcon,
   _M.batteryText,
})

_M.volume_text = wibox.widget.textbox("69%")
_M.volume_icon = wibox.widget.imagebox(gears.surface.load_uncached(beautiful.icon.mutedCat))
_M.volumeBox = wibox.container.background({
   {
      _M.volume_icon,
      widget = wibox.container.margin,
      margins = 4,
   },
   _M.volume_text,
   layout = wibox.layout.fixed.horizontal,
})



function _M.create_promptbox() return awful.widget.prompt() end

function _M.create_layoutbox(s)
   return awful.widget.layoutbox {
      screen = s,
      buttons = {
         awful.button {
            modifiers = {},
            button    = 1,
            on_press  = function() awful.layout.inc(1) end,
         },
         awful.button {
            modifiers = {},
            button    = 3,
            on_press  = function() awful.layout.inc(-1) end,
         },
         awful.button {
            modifiers = {},
            button    = 4,
            on_press  = function() awful.layout.inc(-1) end,
         },
         awful.button {
            modifiers = {},
            button    = 5,
            on_press  = function() awful.layout.inc(1) end,
         },
      }
   }
end

function _M.create_taglist(s)
   return awful.widget.taglist {
      screen = s,
      filter = awful.widget.taglist.filter.all,
      buttons = {
         awful.button {
            modifiers = {},
            button    = 1,
            on_press  = function(t) t:view_only() end,
         },
         awful.button {
            modifiers = { mod.super },
            button    = 1,
            on_press  = function(t)
               if client.focus then
                  client.focus:move_to_tag(t)
               end
            end,
         },
         awful.button {
            modifiers = {},
            button    = 3,
            on_press  = awful.tag.viewtoggle,
         },
         awful.button {
            modifiers = { mod.super },
            button    = 3,
            on_press  = function(t)
               if client.focus then
                  client.focus:toggle_tag(t)
               end
            end
         },
         awful.button {
            modifiers = {},
            button    = 4,
            on_press  = function(t) awful.tag.viewprev(t.screen) end,
         },
         awful.button {
            modifiers = {},
            button    = 5,
            on_press  = function(t) awful.tag.viewnext(t.screen) end,
         },
      }
   }
end

function _M.create_tasklist(s)
   return awful.widget.tasklist {
      screen = s,
      filter = awful.widget.tasklist.filter.currenttags,
      buttons = {
         awful.button {
            modifiers = {},
            button    = 1,
            on_press  = function(c)
               c:activate { context = 'tasklist', action = 'toggle_minimization' }
            end,
         },
         awful.button {
            modifiers = {},
            button    = 3,
            on_press  = function() awful.menu.client_list { theme = { width = 250 } } end
         },
         awful.button {
            modifiers = {},
            button    = 4,
            on_press  = function() awful.client.focus.byidx(-1) end
         },
         awful.button {
            modifiers = {},
            button    = 5,
            on_press  = function() awful.client.focus.byidx(1) end
         },
      }
   }
end

function _M.create_wibox(s)
   return awful.wibar {
      screen = s,
      position = 'top',
      widget = {
         layout = wibox.layout.align.horizontal,
         -- left widgets
         {
            layout = wibox.layout.fixed.horizontal,
            -- _M.launcher,
            s.taglist,
            s.promptbox,
         },
         -- middle widgets
         s.tasklist,
         -- right widgets
         {
            layout = wibox.layout.fixed.horizontal,
            -- _M.keyboardlayout,
            wibox.widget.systray(),
            _M.volumeBox,
            {
               {
                  _M.batteryIcon,
                  cool.widgetSpacer(5),
                  _M.batteryText,
                  layout = wibox.layout.fixed.horizontal,
               },
               widget = wibox.container.background,
               -- bg="#ffffff",
               -- fg="#000000"
            },
            _M.textclock,
            s.layoutbox,
         }
      }
   }
end

return _M
