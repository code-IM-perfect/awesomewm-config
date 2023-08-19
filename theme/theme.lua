---------------------------
-- Default awesome theme --
---------------------------

local theme_assets        = require("beautiful.theme_assets")
local xresources          = require("beautiful.xresources")
local rnotification       = require("ruled.notification")
local dpi                 = xresources.apply_dpi

local gfs                 = require("gears.filesystem")
local gears               = require("gears")
local themes_path         = gfs.get_themes_dir()
-- local config              = gfs.get_configuration_dir()
local config              = '/home/harshit/.config/awesome/'

local theme               = {}

theme.catpuccin           = require("colors.catpuccin")

theme.themeColor          = theme.catpuccin.sapphire

-- local tokyoNight = require("colors.tokyoNight")
-- local brightColors = require("colors.tokyoNightColors")

-- theme.font                = "Source Sans Pro 11"
theme.font                = "Sans 11"

theme.bg_normal           = theme.catpuccin.base
theme.bg_focus            = theme.themeColor
theme.bg_urgent           = theme.catpuccin.red
theme.bg_minimize         = "#444444"
theme.bg_systray          = theme.catpuccin.surface0

theme.fg_normal           = theme.catpuccin.text
theme.fg_focus            = "#ffffff"
theme.fg_urgent           = "#ffffff"
theme.fg_minimize         = "#ffffff"

theme.useless_gap         = dpi(3)
theme.border_width        = dpi(3)
theme.border_color_normal = "#000000"
theme.border_color_active = theme.themeColor
theme.border_color_marked = "#91231c"

theme.taglist_fg_focus    = theme.catpuccin.crust
theme.taglist_fg_occupied    = theme.catpuccin.crust
-- theme.taglist_bg_occupied    = theme.catpuccin.surface0
theme.taglist_bg_occupied    = theme.catpuccin.yellow
theme.taglist_bg_empty    = theme.catpuccin.surface0
theme.taglist_bg_urgent    = theme.bg_urgent
theme.taglist_bg_focus    = theme.catpuccin.sapphire

theme.tasklist_fg_focus    = theme.catpuccin.crust
theme.tasklist_bg_minimize    = theme.catpuccin.surface0
theme.tasklist_bg_normal    = theme.catpuccin.surface0
theme.tasklist_bg_urgent    = theme.bg_urgent

theme.tasklist_shape_border_color = theme.themeColor
theme.tasklist_shape_border_width = 3
theme.tasklist_shape_border_color_minimized = nil
theme.tasklist_shape_border_width_minimized = 0

-- theme. = theme.catpuccin.
-- theme. = theme.catpuccin.
-- theme. = theme.catpuccin.
-- theme. = theme.catpuccin.
-- theme. = theme.catpuccin.
theme.taglist_shape_border_width = 6
theme.taglist_shape_border_width_empty = 5
theme.taglist_shape_border_width_focus = 3
theme.taglist_shape_border_color = theme.bg_normal


theme.tasklist_fg_focus = theme.catpuccin.crust


-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- -- Generate taglist squares:
-- local taglist_square_size   = dpi(4)
-- theme.taglist_squares_sel   = theme_assets.taglist_squares_sel(
-- 	taglist_square_size, theme.fg_normal
-- )
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
-- 	taglist_square_size, theme.fg_normal
-- )

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon     = themes_path .. "default/submenu.png"
theme.menu_height           = dpi(15)
theme.menu_width            = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"


theme.wallpaper  = "/home/harshit/.config/awesome/theme/arch-black-4k.png"
-- theme.wallpaper                                 = themes_path .. "default/background.png"
-- theme.wallpaper                                 = "~/.config/awesome/theme/Windows crash error [1920x1080].png"

-- -- Generate Awesome icon:
-- theme.awesome_icon                              = theme_assets.awesome_icon(
--     theme.menu_height, theme.bg_focus, theme.fg_focus
-- )

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
	rnotification.append_rule {
		rule       = { urgency = 'critical' },
		properties = { bg = '#ff0000', fg = '#ffffff' }
	}
end)






---------------------------------------------------------------------------

theme.wibar_height = dpi(35)










theme.icon = {
	mutedCat = config .. "icons/vol/1.svg",
	volCat2 = config .. "icons/vol/2.svg",
	volCat3 = config .. "icons/vol/3.svg",
	volCat4 = config .. "icons/vol/4.svg",
	volCat5 = config .. "icons/vol/5.svg",
	volCat6 = config .. "icons/vol/6.svg",
}





-- {{ You can use your own layout icons like this:
theme.layout_fairh       = gears.color.recolor_image(themes_path .. "default/layouts/fairhw.png",theme.fg_normal)
theme.layout_fairv       = gears.color.recolor_image(themes_path .. "default/layouts/fairvw.png",theme.fg_normal)
theme.layout_floating    = gears.color.recolor_image(themes_path .. "default/layouts/floatingw.png", theme.fg_normal)
theme.layout_magnifier   = gears.color.recolor_image(themes_path .. "default/layouts/magnifierw.png", theme.fg_normal)
theme.layout_max         = gears.color.recolor_image(themes_path .. "default/layouts/maxw.png",	theme.fg_normal)
theme.layout_fullscreen  = gears.color.recolor_image(themes_path .. "default/layouts/fullscreenw.png", theme.fg_normal)
theme.layout_tilebottom  = gears.color.recolor_image(themes_path .. "default/layouts/tilebottomw.png", theme.fg_normal)
theme.layout_tileleft    = gears.color.recolor_image(themes_path .. "default/layouts/tileleftw.png", theme.fg_normal)
theme.layout_tile        = gears.color.recolor_image(themes_path .. "default/layouts/tilew.png",theme.fg_normal)
theme.layout_tiletop     = gears.color.recolor_image(themes_path .. "default/layouts/tiletopw.png", theme.fg_normal)
theme.layout_spiral      = gears.color.recolor_image(themes_path .. "default/layouts/spiralw.png",	theme.fg_normal)
theme.layout_dwindle     = gears.color.recolor_image(themes_path .. "default/layouts/dwindlew.png", theme.fg_normal)
theme.layout_cornernw    = gears.color.recolor_image(themes_path .. "default/layouts/cornernww.png", theme.fg_normal)
theme.layout_cornerne    = gears.color.recolor_image(themes_path .. "default/layouts/cornernew.png", theme.fg_normal)
theme.layout_cornersw    = gears.color.recolor_image(themes_path .. "default/layouts/cornersww.png", theme.fg_normal)
theme.layout_cornerse    = gears.color.recolor_image(themes_path .. "default/layouts/cornersew.png", theme.fg_normal)
-- }}

-- {{ Define the image to load
theme.titlebar_close_button_normal              = themes_path .. "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = themes_path .. "default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal           = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive     = themes_path .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = themes_path .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = themes_path .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = themes_path .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive    = themes_path .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = themes_path .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = themes_path .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = themes_path .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive  = themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = themes_path .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = themes_path .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = themes_path .. "default/titlebar/maximized_focus_active.png"
-- }}



return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
