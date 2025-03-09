-- awesome_mode: api-level=4:screen=on

-- load luarocks if installed
pcall(require, 'luarocks.loader')

-- load theme
local beautiful = require 'beautiful'
local gears = require 'gears'
-- local awful = require 'awful'
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

-- load key and mouse bindings
require 'bindings'

-- load rules
require 'rules'

-- load signals
require 'signals'

require 'timers'

local modify = require 'cool.modify'
-- require 'naughty'.notify { text = require 'gears'.filesystem.get_configuration_dir() }
modify.changeWallpaper("current")

modify.updateVolume()

require 'autostart'



-- turn titlebar on when client is floating
-------------------------------------------------------------------------------
-- client.connect_signal("property::floating", function(c)
-- 	if c.floating and not c.requests_no_titlebar and c.class ~= "firefox" then
-- 		awful.titlebar.show(c)
-- 	else
-- 		awful.titlebar.hide(c)
-- 	end
-- end)
-- turn tilebars on when layout is floating
-------------------------------------------------------------------------------


-- Not so good tries

-- client.connect_signal("property::floating", function(c)
--     if c.floating then
-- 		awful.titlebar.show(c)
--     else
-- 		awful.titlebar.show(c)
--     end
-- end)

--   awful.tag.attached_connect_signal(nil, "property::layout", function (t)
-- 	local float = t.layout.name == "floating"
-- 	for _,c in pairs(t:clients()) do
-- 	  c.floating = float
-- 	end
--   end)
