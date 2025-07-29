awful = require("awful")

awful.spawn.with_shell("autorandr -c")
-- awful.spawn.with_shell(
-- 	"bash -c \"stdbuf -oL libinput debug-events | grep --line-buffered -E '^ event[0-9]+\\s+SWITCH_TOGGLE\\s' | while read line; do autorandr --change --default default; done\""
-- )
awful.spawn.with_shell("klipper")
awful.spawn.with_shell("playerctld daemon")
-- awful.spawn.single_instance("picom -b --experimental-backends")
awful.spawn.single_instance("picom -b")
awful.spawn.with_shell("xset s 600 15")
awful.spawn.once("xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock")
awful.spawn.with_shell("/usr/lib/polkit-kde-authentication-agent-1")
awful.spawn.once("greenclip daemon")
awful.spawn.once("keepassxc")
