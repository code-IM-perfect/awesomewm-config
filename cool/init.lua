local wibox = require("wibox")


---- MY CUSTOM FUNCTIONS -----
local Cool = {}


----------------------------------- General Functions --------------------------------------------

Cool.splitString = function(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end





------------------------------------ Widget Manipulating Functions ------------------------------







------------------------- Widget Making Functons ---------------------------------------------
Cool.widgetSpacer = function(width)
	local hh = {
		widget = wibox.container.background,
		forced_width = width,
	}

	return hh
end












return Cool
