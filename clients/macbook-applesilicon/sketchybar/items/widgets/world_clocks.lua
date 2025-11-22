local constants = require("constants")
local settings = require("config.settings")

-- Main world clock item showing Vietnam, Sydney and German time with Taiwan on hover
local world_clocks = sbar.add("item", constants.items.WORLD_CLOCKS, {
	position = "right",
	update_freq = 1,
	icon = {
		-- string = "󰅐",
		padding_left = 0,
		padding_right = 0,
	},
	label = {
		font = {
			family = settings.fonts.numbers,
			style = settings.fonts.styles.bold,
			size = 13.0,
		},
		padding_right = 2,
	},
	popup = {
		align = "center",
		horizontal = false,
	},
})

-- Taiwan time popup item (only shown on hover)
local taiwan_popup = sbar.add("item", {
	position = "popup." .. world_clocks.name,
	icon = {
		string = "🇹🇼",
		padding_left = 2,
		padding_right = 2,
	},
	label = {
		font = {
			family = settings.fonts.numbers,
			style = settings.fonts.styles.bold,
			size = 12.0,
		},
		padding_right = 2,
	},
})

-- Function to update all world clock times
local function update_world_clocks()
	-- Taiwan time (Asia/Taipei - UTC+8)
	local taiwan_handle = io.popen("TZ='Asia/Taipei' date '+%H:%M'")
	local taiwan_time = taiwan_handle:read("*a"):gsub("\n", "")
	taiwan_handle:close()

	-- Vietnam time (Asia/Ho_Chi_Minh - UTC+7)
	local vietnam_handle = io.popen("TZ='Asia/Ho_Chi_Minh' date '+%H:%M'")
	local vietnam_time = vietnam_handle:read("*a"):gsub("\n", "")
	vietnam_handle:close()

	-- Sydney time (Australia/Sydney - UTC+10/+11 with DST)
	local sydney_handle = io.popen("TZ='Australia/Sydney' date '+%H:%M'")
	local sydney_time = sydney_handle:read("*a"):gsub("\n", "")
	sydney_handle:close()

	-- Local German time with date format (Fri 22 Aug HH:MM)
	local local_handle = io.popen("date '+%a %d %b %H:%M'")
	local local_time = local_handle:read("*a"):gsub("\n", "")
	local_handle:close()

	-- Update main widget with Vietnam, Sydney and Local German times (Taiwan in popup)
	world_clocks:set({
		label = "🇻🇳 " .. vietnam_time .. "  🇦🇺 " .. sydney_time .. "  " .. local_time,
	})

	-- Update popup item (Taiwan)
	taiwan_popup:set({
		label = taiwan_time,
	})
end

-- Subscribe to update events
world_clocks:subscribe({ "forced", "routine", "system_woke" }, update_world_clocks)

-- Show popup on hover
world_clocks:subscribe("mouse.entered", function(env)
	world_clocks:set({
		popup = { drawing = true },
	})
end)

-- Hide popup when mouse leaves
world_clocks:subscribe("mouse.exited", function(env)
	world_clocks:set({
		popup = { drawing = false },
	})
end)

-- Optional: Click to toggle popup (alternative to hover)
world_clocks:subscribe("mouse.clicked", function(env)
	world_clocks:set({
		popup = { drawing = "toggle" },
	})
end)
