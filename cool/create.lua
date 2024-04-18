------------------------- Widget Making Functons ---------------------------------------------
local Cool = {}
local wibox = require("wibox")
local gears = require("gears")
-- local naughty = require("naughty")

Cool.widgetSpacer = function(width)
	local hh = {
		widget = wibox.container.background,
		forced_width = width,
	}

	return hh
end

Cool.bluetoothTrayIcon = function(icon_input, marg)
	local widg = wibox.container.margin(wibox.widget.imagebox(icon_input), marg, marg, marg, marg)
	return widg
end

Cool.twoSolidColors = function (x0,y0,x1,y1,ratio,color1,color2)
	-- return gears.color.create_linear_pattern("0,0:0,35:0,#FF0000:0.4999,#FF0000:0.5,#0000FF")
	return gears.color.create_linear_pattern(string.format("%d,%d:%d,%d:%f,%s:%f,%s", x0, y0, x1, y1, ratio-0.0001, color1 ,ratio, color2))
	-- naughty.notify{text=string.format("%d,%d:%d,%d:%f,%s:%f,%s", x0, y0, x1, y1, ratio-0.0001, color1 ,ratio, color2), timeout=0}
end

return Cool