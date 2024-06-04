local awful = require 'awful'
local naughty = require 'naughty'
local beautiful = require 'beautiful'
local mod = require 'bindings.mod'
local modify = require 'cool.modify'
-- local widgets = require 'widgets'

local wall_src = {
	all = require 'wallpaperSources.all',
	astro = require 'wallpaperSources.astro',
	calvin = require 'wallpaperSources.calvin',
	cats = require 'wallpaperSources.cats',
	cool = require 'wallpaperSources.cool',
	find = require 'wallpaperSources.find',
	gard = require 'wallpaperSources.gard',
	redd = require 'wallpaperSources.redd',
	windoze = require 'wallpaperSources.windoze',
}

local terminal = require 'config.apps'.terminal


-- launch apps
awful.keyboard.append_global_keybindings {

	awful.key {
		modifiers   = { mod.super, mod.ctrl },
		key         = 'f',
		description = 'Open Firefox',
		group       = 'applications',
		on_press    = function() awful.spawn("firefox") end,
	},

	awful.key {
		modifiers   = { mod.super, mod.shift },
		key         = 'f',
		description = 'Open Firefox Dev Edition',
		group       = 'applications',
		on_press    = function() awful.spawn("firefox -P nooooo") end,
	},

	awful.key {
		modifiers   = { mod.super, mod.shift, mod.ctrl },
		key         = 'f',
		description = 'Open Firefox Dev Edition Private Window',
		group       = 'applications',
		on_press    = function() awful.spawn("firefox -P nooooo --private-window") end,
	},

	awful.key {
		modifiers   = { mod.super, mod.alt },
		key         = 'f',
		description = 'Open Firefox Private Window',
		group       = 'applications',
		on_press    = function() awful.spawn("firefox --private-window") end,
	},

	-- awful.key {
	-- 	modifiers   = { mod.super, mod.shift },
	-- 	key         = 'p',
	-- 	description = 'Open Firefox Dev Edititon',
	-- 	group       = 'applications',
	-- 	on_press    = function() awful.spawn("firefox-developer-edition -P dev-ed-no --private-window") end,
	-- },

	awful.key {
		modifiers   = { mod.super },
		key         = 'e',
		description = 'Open Dolphin',
		group       = 'applications',
		on_press    = function() awful.spawn.with_shell("dolphin") end,
	},

	awful.key {
		modifiers   = { mod.super },
		key         = 'y',
		description = 'Open yazi',
		group       = 'applications',
		on_press    = function() awful.spawn.with_shell("yazi") end,
	},

	awful.key {
		modifiers   = { mod.super, mod.ctrl },
		key         = 'k',
		description = 'Open Kronometer',
		group       = 'applications',
		on_press    = function() awful.spawn("kronometer") end,
	},

	awful.key { --- need command
		modifiers   = { mod.super, mod.ctrl },
		key         = 's',
		description = 'Open Spotify',
		group       = 'applications',
		-- on_press    = function() awful.spawn("flatpak run com.spotify.Client") end,
		on_press    = function() awful.spawn("spotify") end,
	},

	awful.key {
		modifiers   = { mod.super, mod.ctrl },
		key         = 'v',
		description = 'Open VLC',
		group       = 'applications',
		on_press    = function() awful.spawn("vlc") end,
	},

	awful.key {
		modifiers   = { mod.super, mod.ctrl },
		key         = 'c',
		description = 'Open Qalc',
		group       = 'applications',
		on_press    = function() awful.spawn.with_shell(terminal .. " -e qalc") end,
	},

	awful.key {
		modifiers   = { mod.super, mod.ctrl },
		key         = 'Escape',
		description = 'Open htop',
		group       = 'applications',
		on_press    = function() awful.spawn.with_shell(terminal .. " -e htop") end,
	},

	awful.key {
		modifiers   = { mod.super, mod.ctrl },
		key         = '/',
		description = 'Open VsCode',
		group       = 'applications',
		on_press    = function() awful.spawn("code") end,
	},

	awful.key {
		modifiers   = { mod.super, mod.ctrl },
		key         = 'b',
		description = 'Open Bluetooth Settings',
		group       = 'applications',
		on_press    = function() awful.spawn("kcmshell6 kcm_bluetooth") end,
	},

	awful.key {
		modifiers   = { mod.super, mod.ctrl },
		key         = 'w',
		description = 'Open Network Settings',
		group       = 'applications',
		on_press    = function() awful.spawn("kcmshell6 kcm_networkmanagement") end,
	},

	awful.key {
		modifiers   = { mod.super, mod.ctrl },
		key         = 'o',
		description = 'Open Okular',
		group       = 'applications',
		on_press    = function() awful.spawn("Okular") end,
	},

	awful.key {
		modifiers   = { mod.super, mod.alt },
		key         = '0',
		description = 'Save Posts',
		group       = 'applications',
		on_press    = function()
			awful.spawn.with_shell(terminal .. " -e python '/home/harshit/Harshit_Work/Funny_Stuff/Save_Posts.py'") --- gotta change this
		end,
	},
}

-- Brightness
awful.keyboard.append_client_keybindings {
	awful.key {
		modifiers   = { mod.ctrl },
		key         = 'XF86MonBrightnessUp',
		description = 'Increase Brightness',
		group       = 'system',
		on_press    = function()
			modify.brightness("+5%")
			-- naughty.notify{text="yo"}
		end,
	},
	awful.key {
		modifiers   = { mod.ctrl },
		key         = 'XF86MonBrightnessDown',
		description = 'Decrease Brightness',
		group       = 'system',
		on_press    = function()
			modify.brightness("5%-")
		end,
	},
	awful.key {
		modifiers   = {},
		key         = 'XF86MonBrightnessUp',
		description = 'Increase Brightness 1%',
		group       = 'system',
		on_press    = function()
			modify.brightness("+1%")
		end,
	},
	awful.key {
		modifiers   = {},
		key         = 'XF86MonBrightnessDown',
		description = 'Decrease Brightness 1%',
		group       = 'system',
		on_press    = function()
			modify.brightness("1%-")
		end,
	},
}


-- Media Control
awful.keyboard.append_global_keybindings {
	awful.key({}, "XF86AudioPlay", function() awful.spawn("playerctl -i Gwenview -p playerctld play-pause", false) end),
	awful.key({ mod.shift }, "XF86AudioPlay", function()
		awful.spawn.with_shell(
			"playerctl -i Gwenview -p spotify,playerctld play-pause")
	end),
	awful.key({}, "XF86AudioPause", function() awful.spawn("playerctl -i Gwenview -p playerctld play-pause", false) end),
	awful.key({}, "XF86AudioNext", function() awful.spawn("playerctl -i Gwenview -p playerctld next", false) end),
	awful.key({}, "XF86AudioPrev", function() awful.spawn("playerctl -i Gwenview -p playerctld previous", false) end),

	awful.key({}, "XF86AudioMute", function()
			modify.toggle_mute()
		end,
		{ description = "Toggle Mute", group = "Media" }),

	awful.key({}, "XF86AudioRaiseVolume", function()
			modify.change_vol("1%+")
			modify.updateVolume()
		end, -- Num+up
		{ description = "Increase Volume(1%)", group = "Media" }),

	awful.key({}, "XF86AudioLowerVolume", function()
			modify.change_vol("1%-")
		end, -- Num+down
		{ description = "Decrease Volume(1%)", group = "Media" }),


}



-- Rofi
awful.keyboard.append_global_keybindings {

	awful.key {
		modifiers   = { mod.super },
		key         = 'r',
		description = 'Rofi Launcher',
		group       = 'launcher',
		on_press    = function()
			awful.spawn.with_shell(
				"rofi -show drun -theme ~/.config/rofi/launchers/type-1/style-6.rasi")
		end,
	},

	awful.key {
		modifiers   = { mod.super, mod.shift },
		key         = 'r',
		description = 'Rofi Runner',
		group       = 'launcher',
		on_press    = function()
			awful.spawn.with_shell(
				"rofi -show run -theme ~/.config/rofi/launchers/type-1/style-6.rasi")
		end,
	},

	awful.key {
		modifiers   = { mod.super },
		key         = 'v',
		description = 'GreenClip (rofi clipboard manager)',
		group       = 'launcher',
		on_press    = function()
			awful.spawn.with_shell(
				"rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}'")
		end,
	},


	-- PowerButton

	awful.key {
		modifiers   = {},
		key         = 'XF86PowerOff',
		description = 'Rofi Powermenu',
		group       = 'launcher',
		on_press    = function() awful.spawn("/home/harshit/.config/rofi/scripts/powermenu_t1") end,
	},

	awful.key {
		modifiers   = { mod.shift },
		key         = 'XF86PowerOff',
		description = 'Turn off Screen',
		group       = 'launcher',
		on_press    = function() awful.spawn.with_shell("xset dpms force off; sleep 0.001; xset dpms force off") end,
	},

	awful.key {
		modifiers   = {},
		key         = 'Print',
		description = 'Take a Screenshot',
		group       = 'launcher',
		on_press    = function() awful.spawn("spectacle") end,
	},
}

-- WM
awful.keyboard.append_global_keybindings {

	awful.key {
		modifiers   = { mod.super, mod.shift },
		key         = 'Down',
		description = 'Increase Client Gap',
		group       = 'tag',
		on_press    = function() awful.tag.incgap(1) end,
	},

	awful.key {
		modifiers   = { mod.super, mod.shift },
		key         = 'Up',
		description = 'Decrease Client Gap',
		group       = 'tag',
		on_press    = function() awful.tag.incgap(-1) end,
	},

	awful.key {
		modifiers   = { mod.super, mod.shift },
		key         = 'KP_Begin',
		description = 'Reset Client Gap',
		group       = 'tag',
		on_press    = function()
			awful.screen.focused().selected_tag.gap = beautiful.useless_gap
			naughty.notify({ text = "Window Gaps Reset" })
		end,
	},
	-- awful.key {
	-- 	modifiers   = { mod.super, mod.alt },
	-- 	key         = '1',
	-- 	description = 'testttt',
	-- 	group       = 'testtt',
	-- 	on_press    = function()
	-- 		widgets.batteryInnerBar.forced_height = widgets.batteryInnerBar.forced_height - 0.5
	-- 		naughty.notify({ text = tostring(widgets.batteryInnerBar.forced_height) })
	-- 	end,
	-- },
	-- awful.key {
	-- 	modifiers   = { mod.super, mod.alt },
	-- 	key         = '2',
	-- 	description = 'testttt',
	-- 	group       = 'testtt',
	-- 	on_press    = function()
	-- 		widgets.batteryInnerBar.forced_height = widgets.batteryInnerBar.forced_height + 0.5
	-- 		naughty.notify({ text = tostring(widgets.batteryInnerBar.forced_height) })
	-- 	end,
	-- },

}

-- Wallpaper Changing
awful.keyboard.append_global_keybindings {
	awful.key {
		modifiers = { mod.super, mod.ctrl },
		key = 'KP_Begin',
		description = "Set a wallpaper from all",
		group = "wallpaper",
		on_press = function()
			modify.changeWallpaper(wall_src.all)
		end
	},
	awful.key {
		modifiers = { mod.super, mod.ctrl },
		key = 'KP_Down',
		description = "Set previous wallpaper",
		group = "wallpaper",
		on_press = function()
			modify.changeWallpaper("prev")
		end
	},
	awful.key {
		modifiers = { mod.super, mod.ctrl },
		key = 'KP_Insert',
		description = "Set Current wallpaper",
		group = "wallpaper",
		on_press = function()
			modify.changeWallpaper("current")
		end
	},
	awful.key {
		modifiers = { mod.super, mod.ctrl },
		key = 'KP_Up',
		description = "Set a cat wallpaper",
		group = "wallpaper",
		on_press = function()
			modify.changeWallpaper(wall_src.cats)
		end
	},
	awful.key {
		modifiers = { mod.super, mod.ctrl },
		key = 'KP_Home',
		description = "Set an astro wallpaper",
		group = "wallpaper",
		on_press = function()
			modify.changeWallpaper(wall_src.astro)
		end
	},
	awful.key {
		modifiers = { mod.super, mod.ctrl },
		key = 'KP_Prior',
		description = "Set a Calvin&Hobbes wallpaper",
		group = "wallpaper",
		on_press = function()
			modify.changeWallpaper(wall_src.calvin)
		end
	},
	awful.key {
		modifiers = { mod.super, mod.ctrl },
		key = 'KP_Left',
		description = "Set a redd wallpaper",
		group = "wallpaper",
		on_press = function()
			modify.changeWallpaper(wall_src.redd)
		end
	},
	awful.key {
		modifiers = { mod.super, mod.ctrl },
		key = 'KP_Right',
		description = "Set a cool wallpaper",
		group = "wallpaper",
		on_press = function()
			modify.changeWallpaper(wall_src.cool, "fill")
		end
	},
	awful.key {
		modifiers = { mod.super, mod.ctrl },
		key = 'KP_End',
		description = "Set a windoze wallpaper",
		group = "wallpaper",
		on_press = function()
			modify.changeWallpaper(wall_src.windoze, "fill")
		end
	},
	awful.key {
		modifiers = { mod.super, mod.ctrl },
		key = 'KP_Next',
		description = "Set a Find wallpaper",
		group = "wallpaper",
		on_press = function()
			modify.changeWallpaper(wall_src.find)
		end
	},
	-- awful.key {
	-- 	modifiers = { mod.super, mod.ctrl },
	-- 	key = 'KP_End',
	-- 	description = "Set a windoze wallpaper",
	-- 	group = "wallpaper",
	-- 	on_press = function()
	-- 		modify.changeWallpaper(wall_src.windoze)
	-- 	end
	-- },
	awful.key {
		modifiers = { mod.super, mod.ctrl },
		key = 'KP_Enter',
		description = "Change wallpaper to fill",
		group = "wallpaper",
		on_press = function()
			modify.changeWallpaper(nil, "toggleFitMode")
		end
	},
	awful.key {
		modifiers = { mod.super, mod.alt },
		key = 'KP_Add',
		description = "Set as current wallpaper",
		group = "wallpaper",
		on_press = function()
			naughty.notify { text = "Set this as the current wallpaper" }
			modify.setAsCurrentWallpaper()
		end
	},
}






-- --- For Desktop
-- awful.keyboard.append_global_keybindings {

-- 	awful.key({ "Control" }, "KP_Right", function() awful.spawn("playerctl -i Gwenview -p playerctld next", false) end,
-- 	{ description = "Next", group = "Media" }),
-- awful.key({ "Control" }, "KP_Left", function() awful.spawn("playerctl -i Gwenview -p playerctld previous", false) end,
-- 	{ description = "Previous", group = "Media" }),


-- awful.key({ "Control" }, "KP_Begin", function()
-- 		modify.toggle_mute()
-- 	end,
-- 	{ description = "Toggle Mute", group = "Media" }),

-- 	awful.key({}, "KP_Begin", function() awful.spawn("playerctl -i Gwenview -p playerctld play-pause", false) end,
-- 		{ description = "Play/Pause", group = "Media" }),
-- 	awful.key({ "Shift" }, "KP_Begin", function() awful.spawn("playerctl -p spotify play-pause", false) end,
-- 		{ description = "Play/Pause", group = "Media" }),

-- 		awful.key({}, "KP_Up", function()
-- 			modify.change_vol("1%+")
-- 			modify.updateVolume()
-- 		end, -- Num+up
-- 		{ description = "Increase Volume(1%)", group = "Media" }),
-- 	awful.key({ "Control" }, "KP_Up", function()
-- 			modify.change_vol("5%+")
-- 		end, -- Num+up
-- 		{ description = "Increase Volume(5%)", group = "Media" }),
-- 	awful.key({}, "KP_Down", function()
-- 			modify.change_vol("1%-")
-- 		end, -- Num+down
-- 		{ description = "Decrease Volume(1%)", group = "Media" }),
-- 	awful.key({ "Control" }, "KP_Down", function()
-- 			modify.change_vol("5%-")
-- 		end,
-- 		{ description = "Decrease Volume(5%)", group = "Media" }),
-- }
