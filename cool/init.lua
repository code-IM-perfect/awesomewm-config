local wibox = require("wibox")


---- MY CUSTOM FUNCTIONS -----
local Cool = {}

math.randomseed(os.clock() * os.time() * math.random(247598))

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

Cool.shuffleTable = function(t)
	for i = #t, 2, -1 do
		local j = math.random(i)
		t[i], t[j] = t[j], t[i]
	end
end







------------------------- Widget Making Functons ---------------------------------------------
Cool.widgetSpacer = function(width)
	local hh = {
		widget = wibox.container.background,
		forced_width = width,
	}

	return hh
end













------------------------------------ Widget Manipulating Functions ------------------------------





return Cool
