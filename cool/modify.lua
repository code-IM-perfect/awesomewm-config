------------------------------------ Widget Manipulating Functions ------------------------------
local Cool = {}

local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

local widgets = require("widgets")

Cool.updateVolume = function()
	awful.spawn.easy_async("wpctl get-volume @DEFAULT_AUDIO_SINK@",
		function(stdout, _, _, _)
			local vol_float = string.sub(stdout, 9, 12)
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

Cool.updateBattery = function()
    awful.spawn.easy_async_with_shell(
        "upower -i $(upower -e | grep BAT) | grep --color=never -E 'state|to full|time to empty|percentage'",
        function(stdout, _, _, _)
            widgets.batteryText.text = tonumber(string.sub(stdout, -5, -3)) .. "%"
            -- naughty.notify{text=stdout}
            if tonumber(string.sub(stdout, -5, -3)) < 30 then
                naughty.notify { title="BATTERY IS BELOW 30%", text = "better plug it in fast"}
                naughty.notify { title="BATTERY IS BELOW 30%", text = "better plug it in fast"}
                naughty.notify { title="BATTERY IS BELOW 30%", text = "better plug it in fast"}
                naughty.notify { title="BATTERY IS BELOW 30%", text = "better plug it in fast"}
                naughty.notify { title="BATTERY IS BELOW 30%", text = "better plug it in fast"}
                if tonumber(string.sub(stdout, -5, -3)) < 11 then
                    awful.spawn.with_shell("systemctl hibernate")
                end
            end
        end)
end

Cool.brightness = function (val)
	awful.spawn.easy_async_with_shell(("brightnessctl s "..val),function (stdout, _, _, _)
		local currentB = stdout:match("%(([^%)]+)%)")
		naughty.notify{title="Brightness changed" ,text = currentB}
	end)
		-- naughty.notify { text = ("brightnessctl s "..val) }
	-- naughty.notify{text="yo"}
end

widgets.volumeBox.buttons = gears.table.join(
	awful.button({}, 1, function() Cool.toggle_mute() end),
	awful.button({}, 4, function() Cool.change_vol("2%+") end),
	awful.button({}, 5, function() Cool.change_vol("2%-") end))

return Cool