------------------------------------ Widget Manipulating Functions ------------------------------
local Cool = {}

local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local create  = require("cool.create")

local widgets = require("widgets")

Cool.updateVolume = function()
	awful.spawn.easy_async("wpctl get-volume @DEFAULT_AUDIO_SINK@",
		function(stdout, _, _, _)
			local vol_float = string.sub(stdout, 9, 12)
			-- local vol_float = 2                 -- Switch
			Cool.volume = math.floor(vol_float * 100)
			local cat = nil
			if string.find(stdout, "MUTED")
			then
				Cool.MuteStatus = true
				widgets.volume_text:set_markup_silently('<span strikethrough="true" strikethrough_color="' ..
					(beautiful.catpuccin.red) .. '">' .. Cool.volume .. '%' .. '</span>' .. ' ')
			else
				Cool.MuteStatus = false
				widgets.volume_text:set_markup_silently(' ' .. Cool.volume .. '%' .. ' ')
			end
			if (Cool.MuteStatus == false) then
				if (Cool.volume == 0) then
					cat = beautiful.icon.mutedCat
				elseif (Cool.volume > 0) and (Cool.volume < 20) then
					cat = beautiful.icon.volCat2
				elseif (Cool.volume > 20) and (Cool.volume <= 45) then
					cat = beautiful.icon.volCat3
				elseif (Cool.volume > 45) and (Cool.volume <= 70) then
					cat = beautiful.icon.volCat4
				elseif (Cool.volume > 70) and (Cool.volume <= 100) then
					cat = beautiful.icon.volCat5
				elseif (Cool.volume > 100) then
					cat = beautiful.icon.volCat6
				end
			else
				cat = beautiful.icon.mutedCat
			end
			widgets.volume_icon:set_image(gears.surface.load_uncached(cat))
		end)
end

Cool.change_vol = function(c)
	awful.spawn.easy_async_with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. c, function()
		Cool.updateVolume()
	end)
end

Cool.toggle_mute = function()
	awful.spawn.easy_async_with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", function() Cool.updateVolume() end)
end

local batteryBarColor = nil

local batteryWarning = 20
local batteryWarningCritical = 15
local batteryAlmostFull = 96

local BatWarning = {}

Cool.updateBattery = function()
    awful.spawn.easy_async_with_shell(
        "upower -i $(upower -e | grep BAT) | grep --color=never -E 'state|to full|time to empty|percentage'",
        function(stdout, _, _, _)
            widgets.batteryText.text = tonumber(string.sub(stdout, -5, -3)) .. "%"
			-- widgets.batteryIcon.forced_height = tonumber(string.sub(stdout, -5, -3)) * 0.215
            -- naughty.notify{text=stdout}
			if (tonumber(string.sub(stdout, -5, -3)) <= batteryWarningCritical) and (string.find(stdout,"discharging"))then
				BatWarning=naughty.notify { 
					title="BATTERY IS JUST "..widgets.batteryText.text,
					text = "better plug it in fast",
					preset = naughty.config.presets.critical,
					timeout=0,
					replaces_id = BatWarning.id,
				}
				widgets.batteryInnerBar.bg = create.twoSolidColors(0,22,0,0,(tonumber(string.sub(stdout, -5, -3))/100),beautiful.catpuccin.red,beautiful.catpuccin.surface0)
				widgets.batteryCap.bg=beautiful.catpuccin.red
				widgets.batteryCase.border_color=beautiful.catpuccin.red

			elseif (tonumber(string.sub(stdout, -5, -3)) <= batteryWarning) and (string.find(stdout,"discharging")) then
				BatWarning=naughty.notify {
					title="BATTERY IS JUST "..widgets.batteryText.text,
					text = "better plug it in",
					timeout=20,
					replaces_id = BatWarning.id,
				}
				widgets.batteryInnerBar.bg = create.twoSolidColors(0,22,0,0,(tonumber(string.sub(stdout, -5, -3))/100),beautiful.catpuccin.yellow,beautiful.catpuccin.surface0)
				widgets.batteryCap.bg=beautiful.catpuccin.yellow
				widgets.batteryCase.border_color=beautiful.catpuccin.yellow

			elseif string.find(stdout,"discharging") then
				widgets.batteryInnerBar.bg = create.twoSolidColors(0,22,0,0,(tonumber(string.sub(stdout, -5, -3))/100),beautiful.fg_normal,beautiful.catpuccin.surface0)
				widgets.batteryCap.bg=beautiful.fg_normal
				widgets.batteryCase.border_color=beautiful.fg_normal

			else
				widgets.batteryInnerBar.bg = create.twoSolidColors(0,22,0,0,(tonumber(string.sub(stdout, -5, -3))/100),beautiful.catpuccin.green,beautiful.catpuccin.surface0)
				widgets.batteryCap.bg=beautiful.catpuccin.green
				widgets.batteryCase.border_color=beautiful.catpuccin.green
				if (tonumber(string.sub(stdout, -5, -3)) >= batteryAlmostFull) then
					BatWarning=naughty.notify {
						title="Battery is almost full ("..widgets.batteryText.text..")",
						replaces_id = BatWarning.id,
						timeout=40
					}
				end
			end
               -- if tonumber(string.sub(stdout, -5, -3)) < 11 then
               --     awful.spawn.with_shell("systemctl hibernate")
               -- end
        end)
end

local bilkul = {}

Cool.brightness = function (val)
	-- awful.spawn.with_shell("brightnessctl s "..val)
	awful.spawn.easy_async_with_shell(("brightnessctl s "..val),function (stdout, _, _, _)
		local currentB = stdout:match("%(([^%)]+)%)")
		-- naughty.notify{title="Brightness changed" ,text = currentB}
		bilkul = naughty.notify({
			title = "Brightness changed",
			text = currentB,
			replaces_id = bilkul.id,
		})
	end)
		-- naughty.notify { text = ("brightnessctl s "..val) }
	-- naughty.notify{text="yo"}
end

widgets.volumeBox.buttons = gears.table.join(
	awful.button({}, 1, function() Cool.toggle_mute() end),
	awful.button({}, 4, function() Cool.change_vol("2%+") end),
	awful.button({}, 5, function() Cool.change_vol("2%-") end))

Cool.setWallpaper = function (file,adjustment)
	if adjustment=="fill" then
		gears.wallpaper.maximized(file)
	else
		gears.wallpaper.fit(file)
	end
	Cool.wallpaperInfo()
end
Cool.changeWallpaper = function (inputTable)
	if inputTable == "prev" then
		wallOffset=wallOffset+1
		Cool.active_wallp=dofile('/home/harshit/.config/awesome/wallpaperSources/fileget/history.lua')[#dofile('/home/harshit/.config/awesome/wallpaperSources/fileget/history.lua')-wallOffset]
		Cool.setWallpaper(Cool.active_wallp)
	else
		if wallOffset==0 then
	awful.spawn.easy_async_with_shell("~/.config/awesome/wallpaperSources/fileget/fileget "..table.concat(inputTable," "), function (wallFile, _, _, _)
				Cool.active_wallp = wallFile:gsub("\n","")
				Cool.setWallpaper(Cool.active_wallp)
			end)
		else
			wallOffset=wallOffset-1
			Cool.active_wallp = dofile('/home/harshit/.config/awesome/wallpaperSources/fileget/history.lua')[#dofile('/home/harshit/.config/awesome/wallpaperSources/fileget/history.lua')-wallOffset]
			Cool.setWallpaper(Cool.active_wallp)
		end
	end
end
end

return Cool