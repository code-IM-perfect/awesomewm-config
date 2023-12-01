local tables={
	dofile("/home/harshit/.config/awesome/wallpaperSources/astro.lua"),
	dofile("/home/harshit/.config/awesome/wallpaperSources/calvin.lua"),
	dofile("/home/harshit/.config/awesome/wallpaperSources/cats.lua"),
	dofile("/home/harshit/.config/awesome/wallpaperSources/cool.lua"),
	dofile("/home/harshit/.config/awesome/wallpaperSources/find.lua"),
	dofile("/home/harshit/.config/awesome/wallpaperSources/gard.lua"),
	dofile("/home/harshit/.config/awesome/wallpaperSources/redd.lua"),
	dofile("/home/harshit/.config/awesome/wallpaperSources/windoze.lua"),
}

local output = {}

for _,t in ipairs(tables) do
	for _, v in ipairs(t) do
		table.insert(output,v)
	end
end

return output