-- awesome_mode: api-level=4:screen=on

-- load luarocks if installed
pcall(require, 'luarocks.loader')

-- load theme
local beautiful = require 'beautiful'
local gears = require 'gears'
local awful = require 'awful'
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

-- load key and mouse bindings
require 'bindings'

-- load rules
require 'rules'

-- load signals
require 'signals'

require 'timers'

-- require 'naughty'.notify { text = require 'gears'.filesystem.get_configuration_dir() }

require 'cool.modify'.updateVolume()

-- {{	Autostart
awful.spawn.with_shell("klipper")
awful.spawn.with_shell("playerctld daemon")
awful.spawn.with_shell("/usr/lib/polkit-1/polkit-agent-helper-1")
-- }}