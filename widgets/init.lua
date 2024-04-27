local _M           = {}

local awful        = require 'awful'
-- local hotkeys_popup = require 'awful.hotkeys_popup'
local beautiful    = require 'beautiful'
local wibox        = require 'wibox'
local gears        = require 'gears'

local apps         = require 'config.apps'
local mod          = require 'bindings.mod'

local create       = require("cool.create")

-- _M.awesomemenu = {
--    {'hotkeys', function() hotkeys_popup.show_help(nil, awful.screen.focused()) end},
--    {'manual', apps.manual_cmd},
--    {'edit config', apps.editor_cmd .. ' ' .. awesome.conffile},
--    {'restart', awesome.restart},
--    {'quit', function() awesome.quit() end},
-- }

-- _M.mainmenu = awful.menu{
--    items = {
--       {'awesome', _M.awesomemenu, beautiful.awesome_icon},
--       {'open terminal', apps.terminal}
--    }
-- }

-- _M.launcher = awful.widget.launcher{
--    image = beautiful.awesome_icon,
--    menu = _M.mainmenu
-- }

_M.textTime        = wibox.container.place({
	widget = wibox.widget.textclock,
	format = "%l:%M %P",
})

_M.textDate        = wibox.container.place({
	widget = wibox.widget.textclock,
	format = "%e %b %Y",
	font = "Sans 8"
})

_M.keyboardlayout  = awful.widget.keyboardlayout()
-- _M.textclock      = wibox.widget.background(wibox.container.margin(wibox.widget.textclock("%a | %e %b %Y |%l:%M %P"),7,7))
_M.textclock       = {
	widget = wibox.widget.background,

	wibox.container.margin({
		layout = wibox.layout.align.vertical,
		_M.textTime,
		_M.textDate,
	}, 7, 7),

	-- buttons = {
	-- 	awful.button {
	-- 		modifiers = {},
	-- 		button    = 1,
	-- 		on_press  = function() _M.textDate.visible = not(_M.textDate.visible) end,
	-- 	},
	-- }
}
_M.textclock.bg    = beautiful.themeColor
_M.textclock.fg    = beautiful.catpuccin.crust
_M.textclock.shape = function(cr, width, height, _)
	gears.shape.rounded_rect(cr, width, height, height / 4)
end


local batteryInternalMargins = 6
_M.batteryText = wibox.widget.textbox("69%")
_M.batteryInnerBar = wibox.container.background()
_M.batteryInnerBar.forced_width = 16
_M.batteryInnerBar.forced_height = 21.5

_M.batteryCase = wibox.container.background({
	_M.batteryInnerBar,
	widget = wibox.container.place,
	valign = "bottom"
})

_M.batteryCase.border_width = 1
_M.batteryCase.border_color = beautiful.fg_normal
_M.batteryCase.forced_height = 23

_M.batteryCap = wibox.widget.background()

_M.batteryCap.bg = beautiful.fg_normal
_M.batteryCap.forced_height = 3


_M.batteryContainer = wibox.container.background({
	{
		{
			{
				{
					_M.batteryCap,
					widget = wibox.container.margin,
					right = 4,
					left = 4,
					top = 0,
				},
				_M.batteryCase,
				layout = wibox.layout.fixed.vertical,
			},
			widget = wibox.container.margin,
			margins = 4
		},
		_M.batteryText,
		layout = wibox.layout.fixed.horizontal
	},
	widget = wibox.container.margin,
	right = batteryInternalMargins,
	left = batteryInternalMargins
})

-- _M.batteryContainer.bg = create.twoSolidColors(0,0,0,35,0.5,beautiful.catpuccin.red,beautiful.catpuccin.green)
_M.batteryContainer.bg = beautiful.catpuccin.surface0
_M.batteryContainer.shape = function(cr, width, height, _)
	gears.shape.rounded_rect(cr, width, height, height / 4)
end

_M.batteryInnerBar.border_width = 3
_M.batteryInnerBar.border_color = _M.batteryContainer.bg

_M.batteryInnerBar.bg = create.twoSolidColors(0, 22, 0, 0, 1, beautiful.fg_normal, beautiful.catpuccin.surface0)
-- _M.batteryInnerBar.bg = gears.color.create_linear_pattern("0,0:0,21.5:")


_M.volume_text = wibox.widget.textbox("69%")
_M.volume_icon = wibox.widget.imagebox(gears.surface.load_uncached(beautiful.icon.mutedCat))
local volboxInternalMargin = 5
_M.volumeBox = wibox.container.background(
	{
		{
			{
				_M.volume_icon,
				widget = wibox.container.margin,
				margins = 4,
			},
			create.widgetSpacer(2),
			_M.volume_text,
			layout = wibox.layout.fixed.horizontal,
		},
		widget = wibox.container.margin,
		left = volboxInternalMargin,
		right = volboxInternalMargin,
	}
)

_M.volumeBox.bg = beautiful.catpuccin.surface0
_M.volumeBox.shape = function(cr, width, height, _)
	gears.shape.rounded_rect(cr, width, height, height / 4)
end

--- all mouse buttons are at cool/modify



---------- B L U E T O O T H ------------
_M.bluetoothTray = wibox.layout.fixed.horizontal()
_M.bluetoothIcon = wibox.widget.imagebox(gears.surface.load_uncached(beautiful.icon.bluetoothActive))
_M.bt_tray_separator = wibox.widget.textbox(" | ")
_M.bt_tray_separator.visible = false

local blueboxInternalMargin = 5
_M.bluetoothBox = wibox.container.background({
	{
		{
			_M.bluetoothIcon,
			widget = wibox.container.margin,
			margins = 5,
		},
		_M.bt_tray_separator,
		_M.bluetoothTray,
		layout = wibox.layout.fixed.horizontal,
	},
	widget = wibox.container.margin,
	left = blueboxInternalMargin,
	right = blueboxInternalMargin,
})
_M.bluetoothBox.bg = beautiful.catpuccin.surface0
_M.bluetoothBox.shape = function(cr, width, height, _)
	gears.shape.rounded_rect(cr, width, height, height / 4)
end


function _M.create_promptbox() return awful.widget.prompt() end

function _M.create_layoutbox(s)
	return awful.widget.layoutbox {
		screen = s,
		buttons = {
			awful.button {
				modifiers = {},
				button    = 1,
				on_press  = function() awful.layout.inc(1) end,
			},
			awful.button {
				modifiers = {},
				button    = 3,
				on_press  = function() awful.layout.inc(-1) end,
			},
			awful.button {
				modifiers = {},
				button    = 4,
				on_press  = function() awful.layout.inc(-1) end,
			},
			awful.button {
				modifiers = {},
				button    = 5,
				on_press  = function() awful.layout.inc(1) end,
			},
		}
	}
end

function _M.create_taglist(s)
	return awful.widget.taglist {
		screen          = s,
		filter          = awful.widget.taglist.filter.all,
		buttons         = {
			awful.button {
				modifiers = {},
				button    = 1,
				on_press  = function(t) t:view_only() end,
			},
			awful.button {
				modifiers = { mod.super },
				button    = 1,
				on_press  = function(t)
					if client.focus then
						client.focus:move_to_tag(t)
					end
				end,
			},
			awful.button {
				modifiers = {},
				button    = 3,
				on_press  = awful.tag.viewtoggle,
			},
			awful.button {
				modifiers = { mod.super },
				button    = 3,
				on_press  = function(t)
					if client.focus then
						client.focus:toggle_tag(t)
					end
				end
			},
			-- awful.button {
			-- 	modifiers = {},
			-- 	button    = 4,
			-- 	on_press  = function(t) awful.tag.viewprev(t.screen) end,
			-- },
			-- awful.button {
			-- 	modifiers = {},
			-- 	button    = 5,
			-- 	on_press  = function(t) awful.tag.viewnext(t.screen) end,
			-- },
		},
		style           = {
			shape = gears.shape.rounded_rect,
		},
		widget_template = {
			{
				{
					{
						id     = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left   = 13,
				right  = 13,
				widget = wibox.container.margin
			},
			id     = "background_role",
			widget = wibox.container.background,
		},
	}
end

function _M.create_tasklist(s)
	return awful.widget.tasklist {
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = {
			awful.button {
				modifiers = {},
				button    = 1,
				on_press  = function(c)
					c:activate { context = 'tasklist', action = 'toggle_minimization' }
				end,
			},
			awful.button {
				modifiers = {},
				button    = 3,
				on_press  = function() awful.menu.client_list { theme = { width = 250 } } end
			},
			awful.button {
				modifiers = {},
				button    = 4,
				on_press  = function() awful.client.focus.byidx(-1) end
			},
			awful.button {
				modifiers = {},
				button    = 5,
				on_press  = function() awful.client.focus.byidx(1) end
			},
		},
		widget_template = {
			{
				{
					{
						{
							id     = "icon_role",
							widget = wibox.widget.imagebox,
						},
						margins = 6,
						right   = 10,
						widget  = wibox.container.margin,
					},
					{
						id     = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				widget = wibox.container.place,
			},
			id            = "background_role",
			widget        = wibox.container.background,
			forced_height = beautiful.wibar_height,
		},
		style = {
			shape = function(cr, width, height, _)
				gears.shape.rounded_rect(cr, width, height, height / 4)
			end,
		},
	}
end

function _M.create_wibox(s)
	return awful.wibar {
		screen = s,
		position = 'top',
		widget = {
			layout = wibox.layout.align.horizontal,
			-- left widgets
			{
				layout = wibox.layout.fixed.horizontal,
				-- _M.launcher,
				{
					s.taglist,
					widget = wibox.container.background,
					bg = beautiful.catpuccin.base,
					shape = function(cr, width, height, _)
						gears.shape.rounded_rect(cr, width, height, height / 4)
					end
				},
				s.promptbox,
				create.widgetSpacer(10),
			},
			-- middle widgets
			s.tasklist,
			-- right widgets
			{
				layout = wibox.layout.fixed.horizontal,
				-- _M.keyboardlayout,
				create.widgetSpacer(10),
				{
					{
						wibox.widget.systray(),
						widget = wibox.container.margin,
						left = 6,
						right = 6,
					},
					widget = wibox.container.background,
					bg = beautiful.catpuccin.surface0,
					shape = function(cr, width, height, _)
						gears.shape.rounded_rect(cr, width, height, height / 4)
					end
				},
				create.widgetSpacer(6),
				_M.bluetoothBox,
				create.widgetSpacer(6),
				_M.volumeBox,
				create.widgetSpacer(6),
				_M.batteryContainer,
				create.widgetSpacer(6),
				_M.textclock,
				create.widgetSpacer(6),
				{ {
					s.layoutbox,
					widget = wibox.container.margin,
					margins = 5,

				},
					widget = wibox.container.background,
					-- bg = beautiful.catpuccin.surface0,
					bg = beautiful.themeColor,
					shape = function(cr, width, height, _)
						gears.shape.rounded_rect(cr, width, height, height / 4)
					end
				}
			}
		}
	}
end

return _M
