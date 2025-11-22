local constants = require("constants")
local settings = require("config.settings")

local calendar = sbar.add("item", constants.items.CALENDAR, {
	position = "right",
	update_freq = 600,
	script = "~/.config/sketchybar/scripts/outlook_calendar.sh",
	icon = {
		string = settings.icons.text.calendar or "",
		font = {
			family = settings.fonts.text,
			style = settings.fonts.styles.regular,
			size = 14.0,
		},
	},
	label = {
		string = "Loading...",
		font = {
			family = settings.fonts.text,
			style = settings.fonts.styles.regular,
			size = 12.0,
		},
		padding_right = 8,
	},
	click_script = "open -a 'Microsoft Outlook'",
})

-- Optional: Add bracket if you want popup functionality later
local calendarBracket = sbar.add("bracket", constants.items.CALENDAR .. ".bracket", { calendar.name }, {
	popup = {
		align = "center",
	},
})
