local gears = require 'gears'
local naughty = require 'naughty'
local awful = require 'awful'

local widgett = require 'widgets'

gears.timer {
	timeout = 40,
	autostart = true,
	call_now = true,
	callback = function()
		awful.spawn.easy_async_with_shell(
			"upower -i $(upower -e | grep BAT) | grep --color=never -E 'state|to full|time to empty|percentage'",
			function(stdout, stderr, reason, exit_code)
				widgett.batteryText.text = tonumber(string.sub(stdout, -5, -3)) .. "%"
				-- naughty.notify{text=stdout}
				if tonumber(string.sub(stdout, -5, -3)) < 20 then
					naughty.notify { text = "BATTERY IS BELOW 20%\nbetter plug it in fast" }
					if tonumber(string.sub(stdout, -5, -3)) < 11 then
						awful.spawn.with_shell("systemctl hibernate")
					end
				end
			end)
	end
}
