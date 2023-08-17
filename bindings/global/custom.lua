local awful = require 'awful'
local naughty = require 'naughty'
local beautiful = require 'beautiful'
local mod = require 'bindings.mod'
local modify = require 'cool.modify'

local terminal = require'config.apps'.terminal


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
		on_press    = function() awful.spawn("firefox-developer-edition") end,
	},

	awful.key {
		modifiers   = { mod.super, mod.alt },
		key         = 'f',
		description = 'Open Firefox Private Window',
		group       = 'applications',
		on_press    = function() awful.spawn("firefox --private-window") end,
	},

	awful.key {
		modifiers   = { mod.super, mod.shift },
		key         = 'p',
		description = 'Open Firefox Dev Edititon',
		group       = 'applications',
		on_press    = function() awful.spawn("firefox-developer-edition -P dev-ed-no --private-window") end,
	},

	awful.key {
		modifiers   = { mod.super },
		key         = 'e',
		description = 'Open Dolphin',
		group       = 'applications',
		on_press    = function() awful.spawn("dolphin") end,
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
		on_press    = function() awful.spawn("flatpak run com.spotify.Client") end,
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
			awful.spawn.with_shell(terminal.." -e python '/home/harshit/Harshit_Work/Funny_Stuff/Save_Posts.py'") --- gotta change this
		end,
	},
}

-- Brightness
awful.keyboard.append_client_keybindings{
	awful.key {
		modifiers   = {},
		key         = 'XF86MonBrightnessUp',
		description = 'Increase Brightness',
		group       = 'system',
		on_press    = function()
			modify.brightness("+5%")
		end,
	},
	awful.key {
		modifiers   = {},
		key         = 'XF86MonBrightnessDown',
		description = 'Decrease Brightness',
		group       = 'system',
		on_press    = function()
			modify.brightness("5%-")
		end,
	},
}


-- Media Control
awful.keyboard.append_global_keybindings {
	awful.key({}, "KP_Begin", function() awful.spawn("playerctl -i Gwenview -p playerctld play-pause", false) end,
		{ description = "Play/Pause", group = "Media" }),
	awful.key({ "Shift" }, "KP_Begin", function() awful.spawn("playerctl -p spotify play-pause", false) end,
		{ description = "Play/Pause", group = "Media" }),

	awful.key({}, "XF86AudioPlay", function() awful.spawn("playerctl -i Gwenview -p playerctld play-pause", false) end),
	awful.key({}, "XF86AudioPause", function() awful.spawn("playerctl -i Gwenview -p playerctld play-pause", false) end),
	awful.key({}, "XF86AudioNext", function() awful.spawn("playerctl -i Gwenview -p playerctld next", false) end),
	awful.key({}, "XF86AudioPrev", function() awful.spawn("playerctl -i Gwenview -p playerctld previous", false) end),
	awful.key({ "Control" }, "KP_Right", function() awful.spawn("playerctl -i Gwenview -p playerctld next", false) end,
		{ description = "Next", group = "Media" }),
	awful.key({ "Control" }, "KP_Left", function() awful.spawn("playerctl -i Gwenview -p playerctld previous", false) end,
		{ description = "Previous", group = "Media" }),


	awful.key({ "Control" }, "KP_Begin", function()
			modify.toggle_mute()
		end,
		{ description = "Toggle Mute", group = "Media" }),

	awful.key({}, "XF86AudioMute", function()
			modify.toggle_mute()
		end,
		{ description = "Toggle Mute", group = "Media" }),

	awful.key({}, "KP_Up", function()
			modify.change_vol("1%+")
			modify.updateVolume()
		end, -- Num+up
		{ description = "Increase Volume(1%)", group = "Media" }),

	awful.key({}, "XF86AudioRaiseVolume", function()
			modify.change_vol("1%+")
			modify.updateVolume()
		end, -- Num+up
		{ description = "Increase Volume(1%)", group = "Media" }),

	awful.key({ "Control" }, "KP_Up", function()
			modify.change_vol("5%+")
		end, -- Num+up
		{ description = "Increase Volume(5%)", group = "Media" }),

	awful.key({}, "KP_Down", function()
			modify.change_vol("1%-")
		end, -- Num+down
		{ description = "Decrease Volume(1%)", group = "Media" }),
	awful.key({}, "XF86AudioLowerVolume", function()
			modify.change_vol("1%-")
		end, -- Num+down
		{ description = "Decrease Volume(1%)", group = "Media" }),

	awful.key({ "Control" }, "KP_Down", function()
			modify.change_vol("5%-")
		end,
		{ description = "Decrease Volume(5%)", group = "Media" })

}

-- Rofi
awful.keyboard.append_global_keybindings {

	awful.key {
		modifiers   = { mod.super },
		key         = 'r',
		description = 'Rofi Launcher',
		group       = 'launcher',
		on_press    = function() awful.spawn("rofi -show drun -theme ~/.config/rofi/launchers/type-1/style-6.rasi") end,
	},

	awful.key {
		modifiers   = { mod.super, mod.shift },
		key         = 'r',
		description = 'Rofi Runner',
		group       = 'launcher',
		on_press    = function() awful.spawn("rofi -show run -theme ~/.config/rofi/launchers/type-1/style-6.rasi") end,
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
		description = 'Decrease Client Gap',
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
	-- 		naughty.notify({ text = "test" })
	-- 	end,
	-- },

}
