local gears = require 'gears'
local modify = require 'cool.modify'


gears.timer {
	timeout = 31,
	autostart = true,
	call_now = true,
	callback = function ()
		modify.updateBattery()
	end
}

gears.timer {
	timeout = 10,
	autostart = true,
	call_now = false,
	callback = function ()
		modify.updateVolume()
	end
}
