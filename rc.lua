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

local modify = require'cool.modify'
-- require 'naughty'.notify { text = require 'gears'.filesystem.get_configuration_dir() }
modify.changeWallpaper("current")

modify.updateVolume()

require 'autostart'