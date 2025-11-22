local colors = require("config.colors")
local settings = require("config.settings")
local icons = {
	plus = "",
	loading = "",
	apple = "",
	gear = "",
	cpu = "",
	clipboard = "Missing Icon",

	switch = {
		on = "󱨥",
		off = "󱨦",
	},
	volume = {
		_100 = "",
		_66 = "",
		_33 = "",
		_10 = "",
		_0 = "",
	},
	battery = {
		_100 = "",
		_75 = "",
		_50 = "",
		_25 = "",
		_0 = "",
		charging = "",
	},
	wifi = {
		upload = "",
		download = "",
		connected = "󰖩",
		disconnected = "󰖪",
		router = "Missing Icon",
	},
	media = {
		back = "",
		forward = "",
		play_pause = "",
	},
}

sbar.exec("killall cpu_load >/dev/null; $CONFIG_DIR/bridge/cpu_load/bin/cpu_load cpu_update 2.0")

local cpu = sbar.add("graph", "widgets.cpu", 42, {
	position = "right",
	graph = { color = colors.blue },
	background = {
		height = 22,
		color = { alpha = 0 },
		border_color = { alpha = 0 },
		drawing = true,
	},
	icon = { string = icons.cpu },
	label = {
		string = "cpu ??%",
     font = {
            family = settings.fonts.numbers,
            style = settings.fonts.styles.bold,
            size = 11.0,
        },
		align = "right",
		padding_right = 0,
		width = 0,
		y_offset = 4,
	},
	padding_right = 2,
})

cpu:subscribe("cpu_update", function(env)
	-- Also available: env.user_load, env.sys_load
	local load = tonumber(env.total_load)
	cpu:push({ load / 100. })

	local color = colors.blue
	if load > 30 then
		if load < 60 then
			color = colors.yellow
		elseif load < 80 then
			color = colors.orange
		else
			color = colors.red
		end
	end

	cpu:set({
		graph = { color = color },
		label = "cpu " .. env.total_load .. "%",
	})
end)

cpu:subscribe("mouse.clicked", function(env)
	sbar.exec("open -a 'Activity Monitor'")
end)

-- Background around the cpu item
sbar.add("bracket", "widgets.cpu.bracket", { cpu.name }, {
	background = { color = colors.transparent },
})
