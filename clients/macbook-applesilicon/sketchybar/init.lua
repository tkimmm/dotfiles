require("install.sbar")
sbar = require("sketchybar")

sbar.exec("killall cpu_load network_load 2>/dev/null || true")

sbar.begin_config()
sbar.hotload(true)

require("constants")
require("config")
require("bar")
require("default")
require("items")

sbar.end_config()
sbar.event_loop()
