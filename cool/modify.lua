------------------------------------ Widget Manipulating Functions ------------------------------
local Cool                   = {}

local beautiful              = require("beautiful")
local gears                  = require("gears")
local awful                  = require("awful")
local naughty                = require("naughty")
local create                 = require("cool.create")

local widgets                = require("widgets")

Cool.updateVolume            = function()
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

Cool.change_vol              = function(c)
	awful.spawn.easy_async_with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. c, function()
		Cool.updateVolume()
	end)
end

Cool.toggle_mute             = function()
	awful.spawn.easy_async_with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", function() Cool.updateVolume() end)
end

local batteryBarColor        = nil

local batteryWarning         = 15
local batteryWarningCritical = 10
local batteryAlmostFull      = 97

local BatWarning             = {}

Cool.updateBattery           = function()
	awful.spawn.easy_async_with_shell(
		"upower -i $(upower -e | grep BAT) | grep --color=never -E 'state|to full|time to empty|percentage'",
		function(stdout, _, _, _)
			widgets.batteryText.text = tonumber(string.sub(stdout, -5, -3)) .. "%"
			-- widgets.batteryIcon.forced_height = tonumber(string.sub(stdout, -5, -3)) * 0.215
			-- naughty.notify{text=stdout}
			if (tonumber(string.sub(stdout, -5, -3)) <= batteryWarningCritical) and (string.find(stdout, "discharging")) then
				BatWarning = naughty.notify {
					title = "BATTERY IS JUST " .. widgets.batteryText.text,
					text = "better plug it in fast",
					preset = naughty.config.presets.critical,
					timeout = 0,
					replaces_id = BatWarning.id,
				}
				widgets.batteryInnerBar.bg = create.twoSolidColors(0, 22, 0, 0,
					(tonumber(string.sub(stdout, -5, -3)) / 100), beautiful.catpuccin.red, beautiful.catpuccin.surface0)
				widgets.batteryCap.bg = beautiful.catpuccin.red
				widgets.batteryCase.border_color = beautiful.catpuccin.red
			elseif (tonumber(string.sub(stdout, -5, -3)) <= batteryWarning) and (string.find(stdout, "discharging")) then
				BatWarning = naughty.notify {
					title = "BATTERY IS JUST " .. widgets.batteryText.text,
					text = "better plug it in",
					timeout = 20,
					replaces_id = BatWarning.id,
				}
				widgets.batteryInnerBar.bg = create.twoSolidColors(0, 22, 0, 0,
					(tonumber(string.sub(stdout, -5, -3)) / 100), beautiful.catpuccin.yellow,
					beautiful.catpuccin.surface0)
				widgets.batteryCap.bg = beautiful.catpuccin.yellow
				widgets.batteryCase.border_color = beautiful.catpuccin.yellow
			elseif string.find(stdout, "discharging") then
				widgets.batteryInnerBar.bg = create.twoSolidColors(0, 22, 0, 0,
					(tonumber(string.sub(stdout, -5, -3)) / 100), beautiful.fg_normal, beautiful.catpuccin.surface0)
				widgets.batteryCap.bg = beautiful.fg_normal
				widgets.batteryCase.border_color = beautiful.fg_normal
			else
				widgets.batteryInnerBar.bg = create.twoSolidColors(0, 22, 0, 0,
					(tonumber(string.sub(stdout, -5, -3)) / 100), beautiful.catpuccin.green, beautiful.catpuccin
					.surface0)
				widgets.batteryCap.bg = beautiful.catpuccin.green
				widgets.batteryCase.border_color = beautiful.catpuccin.green
				if (tonumber(string.sub(stdout, -5, -3)) >= batteryAlmostFull) then
					BatWarning = naughty.notify {
						title = "Battery is almost full (" .. widgets.batteryText.text .. ")",
						replaces_id = BatWarning.id,
						timeout = 40
					}
				end
			end
			-- if tonumber(string.sub(stdout, -5, -3)) < 11 then
			--     awful.spawn.with_shell("systemctl hibernate")
			-- end
		end)
end

local bilkul                 = {}

Cool.brightness              = function(val)
	-- awful.spawn.with_shell("brightnessctl s "..val)
	awful.spawn.easy_async_with_shell(("brightnessctl s " .. val), function(stdout, _, _, _)
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

widgets.volumeBox.buttons    = gears.table.join(
	awful.button({}, 1, function() Cool.toggle_mute() end),                             -- Left Click
	awful.button({}, 4, function() Cool.change_vol("2%+") end),                         -- Scroll Up
	awful.button({}, 5, function() Cool.change_vol("2%-") end),                         -- Scroll Down
	awful.button({}, 2, function() Cool.updateVolume() end),                            -- Middle Click
	awful.button({}, 3, function() awful.spawn.with_shell("kcmshell6 kcm_pulseaudio") end) -- Right Click
)

widgets.bluetoothBox.buttons = gears.table.join(
	awful.button({}, 2, function()
		Cool.updateBluetooth()
		naughty.notify { title = "Updated Bluetooth Widget" }
	end),                                                                              -- Right Click
	awful.button({}, 3, function() awful.spawn.with_shell("kcmshell6 kcm_bluetooth") end) -- Middle Click
)

Cool.setWallpaper            = function(file, adjustment)
	if adjustment == "fill" then
		gears.wallpaper.maximized(file)
	else
		gears.wallpaper.fit(file)
	end
	Cool.wallpaperInfo()
end

local wallOffset             = 0
local k
-- local active_wallp
-- gears.wallpaper.fit(Cool.active_wallp)

-- Cool.active_wallp            = "/home/harshit/.config/awesome/theme/arch-black-4k.png"

Cool.changeWallpaper         = function(inputTable, fitMode)
	if fitMode == nil then
		Cool.WallpaperFit = true
		if inputTable == "prev" then
			wallOffset = wallOffset + 1
			k = dofile('/home/harshit/.config/awesome/wallpaperSources/fileget/history.lua')
			Cool.active_wallp = k[#k - wallOffset]
			Cool.setWallpaper(Cool.active_wallp)
		elseif inputTable == "current" then
			if (wallOffset == 0 and Cool.active_wallp ~= nil) then
				Cool.wallpaperInfo()
			else
				wallOffset = 0
				k = dofile('/home/harshit/.config/awesome/wallpaperSources/fileget/history.lua')
				Cool.active_wallp = k[#k]
				Cool.setWallpaper(Cool.active_wallp)
			end
		else
			if wallOffset == 0 then
				awful.spawn.easy_async_with_shell(
					"~/.config/awesome/wallpaperSources/fileget/fileget " .. table.concat(inputTable, " "),
					function(wallFile, _, _, _)
						Cool.active_wallp = wallFile:gsub("\n", "")
						Cool.setWallpaper(Cool.active_wallp)
					end)
			else
				wallOffset = wallOffset - 1
				k = dofile('/home/harshit/.config/awesome/wallpaperSources/fileget/history.lua')
				Cool.active_wallp = k[#k - wallOffset]
				Cool.setWallpaper(Cool.active_wallp)
			end
		end
	elseif fitMode == "toggleFitMode" then
		Cool.WallpaperFit = not (Cool.WallpaperFit)
		if Cool.WallpaperFit == true then
			Cool.setWallpaper(Cool.active_wallp)
		else
			Cool.setWallpaper(Cool.active_wallp, "fill")
		end
	else
		Cool.WallpaperFit = false
		if inputTable == "prev" then
			wallOffset = wallOffset + 1
			k = dofile('/home/harshit/.config/awesome/wallpaperSources/fileget/history.lua')
			Cool.active_wallp = k[#k - wallOffset]
			Cool.setWallpaper(Cool.active_wallp, "fill")
		elseif inputTable == "current" then
			if wallOffset == 0 then
				Cool.wallpaperInfo()
			else
				wallOffset = 0
				k = dofile('/home/harshit/.config/awesome/wallpaperSources/fileget/history.lua')
				Cool.active_wallp = k[#k]
				Cool.setWallpaper(Cool.active_wallp, "fill")
			end
		else
			if wallOffset == 0 then
				awful.spawn.easy_async_with_shell(
					"~/.config/awesome/wallpaperSources/fileget/fileget " .. table.concat(inputTable, " "),
					function(wallFile, _, _, _)
						Cool.active_wallp = wallFile:gsub("\n", "")
						Cool.setWallpaper(Cool.active_wallp, "fill")
					end)
			else
				wallOffset = wallOffset - 1
				k = dofile('/home/harshit/.config/awesome/wallpaperSources/fileget/history.lua')
				Cool.active_wallp = k[#k - wallOffset]
				Cool.setWallpaper(Cool.active_wallp, "fill")
			end
		end
	end
end

Cool.setAsCurrentWallpaper   = function()
	if wallOffset ~= 0 then
		wallOffset = 0
		awful.spawn.with_shell("~/.config/awesome/wallpaperSources/fileget/fileget --setFile '" .. Cool.active_wallp ..
			"'")
	end
	Cool.wallpaperInfo()
end

Cool.wallpaperInfo           = function()
	local file = Cool.active_wallp:gsub("/home/harshit/Harshit_Work/Funny_Stuff/", ""):gsub(
		"/home/harshit/Harshit_Work/", "")
	local sub = file:sub(1, file:find("/") - 1):gsub("z_", "r/")
	local post = file:sub(file:find("/") + 1, -5)
	bilkul = naughty.notify {
		title = sub,
		text = post,
		timeout = 10,
		hover_timeout = 30,
		position = "bottom_left",
		border_width = 3,
		border_color = beautiful.themeColor,
		bg = beautiful.catpuccin.mantle,
		fg = beautiful.catpuccin.text,
		font = "SF-Pro",
		margin = 15,
		replaces_id = bilkul.id,
		max_width = 500,
	}
end

local connected_devices
local prev_bt_output
local bt_dekhu

Cool.updateBluetooth         = function()
	awful.spawn.easy_async_with_shell("bluetoothctl devices Connected",
		function(stdout, _, _, _)
			if stdout ~= prev_bt_output then
				widgets.bluetoothTray:reset()
				local yo = gears.string.split(stdout, "\n")
				table.remove(yo) -- Remove empty string at the end
				connected_devices = {}
				for _, device_info in pairs(yo) do
					local device = {
						name = string.sub(device_info, 26),
						address = string.sub(device_info, 8, 24)
					}
					-- naughty.notify{
					-- 	text=device.name.." ("..device.address..")"
					-- }
					local img
					if string.find(device.name, "bud") or string.find(device.name, "Bud") then
						img = beautiful.icon.buds
					elseif string.find(device.name, "pod") or string.find(device.name, "Pod") then
						img = beautiful.icon.buds
					elseif string.find(device.name, "rockerz") or string.find(device.name, "Rockerz") then
						img = beautiful.icon.headphones
					elseif string.find(device.name, "WH-") or string.find(device.name, "wh-") then
						img = beautiful.icon.headphones
					elseif string.find(device.name, "JBL GO") then
						img = beautiful.icon.speaker
					else
						img = beautiful.icon.generalBluetooth
					end
					-- widgets.bluetoothTray:add(widgets.bluetoothTrayIcon(img))
					widgets.bluetoothTray:add(create.bluetoothTrayIcon(img, 5))
					table.insert(connected_devices, device)
				end
				if (#connected_devices > 0)
				then
					widgets.bluetoothIcon.image = gears.surface.load_uncached(beautiful.icon.bluetoothActive)
					widgets.bt_tray_separator.visible = true
					if bt_dekhu == false then
						bt_dekhu = true
						Cool.bluetoothUpdateTimer.timeout = 3
						Cool.bluetoothUpdateTimer:again()
					end
				else
					widgets.bluetoothIcon.image = gears.surface.load_uncached(beautiful.icon.bluetoothInactive)
					widgets.bt_tray_separator.visible = false
					if bt_dekhu == true then
						bt_dekhu = false
						Cool.bluetoothUpdateTimer.timeout = 30
						Cool.bluetoothUpdateTimer:again()
					end
				end
			end
			prev_bt_output = stdout
		end)
end

Cool.bluetoothUpdateTimer    = gears.timer {
	timeout = 30,
	autostart = true,
	call_now = true,
	callback = function()
		Cool.updateBluetooth()
	end
}

return Cool
