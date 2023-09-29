awful = require("awful")

awful.spawn.with_shell("klipper")
awful.spawn.with_shell("playerctld daemon")
-- awful.spawn.single_instance("picom -b --experimental-backends")
awful.spawn.single_instance("picom -b")
awful.spawn.with_shell("/usr/lib/polkit-1/polkit-agent-helper-1")