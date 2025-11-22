local constants = require("constants")
local settings = require("config.settings")

local spaces = {}

local swapWatcher = sbar.add("item", {
	drawing = false,
	updates = true,
})

local currentWorkspaceWatcher = sbar.add("item", {
	drawing = false,
	updates = true,
})

local spaceConfigs = {
	["1"] = { icon = "1 ", name = "shell" },
	["2"] = { icon = "2 ", name = "browse" },
	["3"] = { icon = "3 ", name = "chat" },
	["4"] = { icon = "4 ", name = "collab" },
	["5"] = { icon = "5 ", name = "slack" },
	["6"] = { icon = "6 ", name = "mail" },
	["7"] = { icon = "7 ", name = "yea" },
	["8"] = { icon = "8 ", name = "extra" },
	["9"] = { icon = "9 ", name = "extra2" },
	["10"] = { icon = "10 ", name = "extra3" },
}

local function selectCurrentWorkspace(focusedWorkspaceName)
	for sid, item in pairs(spaces) do
		if item ~= nil then
			local isSelected = sid == constants.items.SPACES .. "." .. focusedWorkspaceName
			item:set({
				icon = { color = isSelected and settings.colors.bg1 or settings.colors.white },
				label = { color = isSelected and settings.colors.bg1 or settings.colors.white },
				background = { color = isSelected and settings.colors.blue or settings.colors.bg1 },
			})
		end
	end
end

local function findAndSelectCurrentWorkspace()
	sbar.exec(constants.aerospace.GET_CURRENT_WORKSPACE, function(focusedWorkspaceOutput)
		local focusedWorkspaceName = focusedWorkspaceOutput:match("[^\r\n]+")
		selectCurrentWorkspace(focusedWorkspaceName)
	end)
end

local function updateSpaceWindows()
	sbar.exec("aerospace list-windows --all --format '%{app-name}|%{workspace}'", function(windowsOutput)
		local workspaceApps = {}

		-- Initialize empty arrays for all workspaces
		for i = 1, 10 do
			workspaceApps[tostring(i)] = {}
		end

		if windowsOutput and windowsOutput ~= "" then
			for window in string.gmatch(windowsOutput, "[^\n]+") do
				local appName, workspaceId = window:match("([^|]+)|(%d+)")
				if appName and workspaceId then
					local icon = settings.icons.apps[appName] or settings.icons.apps["default"]
					table.insert(workspaceApps[workspaceId], icon)
				end
			end
		end

		-- Update workspace labels - remove change detection for instant updates
		for workspaceId = 1, 10 do
			local spaceName = constants.items.SPACES .. "." .. workspaceId
			if spaces[spaceName] then
				local iconString = table.concat(workspaceApps[tostring(workspaceId)], " ")

				spaces[spaceName]:set({
					label = {
						string = iconString,
						width = iconString ~= "" and "dynamic" or 0,
						padding_left = iconString ~= "" and 4 or 0,
						font = settings.fonts.icons(),
					},
				})
			end
		end
	end)
end

local function addWorkspaceItem(workspaceName)
	local spaceName = constants.items.SPACES .. "." .. workspaceName
	local spaceConfig = spaceConfigs[workspaceName]

	spaces[spaceName] = sbar.add("item", spaceName, {
		label = {
			width = 0,
			padding_left = 0,
			string = "",
			color = settings.colors.white,
			font = settings.fonts.icons(),
		},
		icon = {
			string = spaceConfig.icon or settings.icons.apps["default"],
			color = settings.colors.white,
			font = {
				family = settings.fonts.numbers,
				style = settings.fonts.styles.bold,
				size = 14.0,
			},
		},
		background = {
			color = settings.colors.bg2,
		},
		click_script = "aerospace workspace " .. workspaceName,
	})

	sbar.add("item", spaceName .. ".padding", {
		width = settings.dimens.padding.label,
	})
end

local function createWorkspaces()
	sbar.exec(constants.aerospace.LIST_ALL_WORKSPACES, function(workspacesOutput)
		for workspaceName in workspacesOutput:gmatch("[^\r\n]+") do
			addWorkspaceItem(workspaceName)
		end

		-- Add service mode indicator
		local serviceModeWatcher = sbar.add("item", "service_mode", {
			drawing = false,
			updates = true,
			position = "left",
			icon = {
				string = "S",
				color = settings.colors.blue,
			},
			-- label = {
			-- 	color = settings.colors.blue,
			-- 	font = {
			-- 		style = settings.fonts.styles.semibold,
			-- 		size = 12.0,
			-- 	},
			-- },
			background = {
				color = settings.colors.bg1,
				border_color = settings.colors.blue,
				border_width = 2,
				corner_radius = 6,
			},
			padding_left = 0,
			padding_right = 0,
		})

		serviceModeWatcher:subscribe("aerospace_service_enter", function()
			serviceModeWatcher:set({ drawing = true })
		end)

		serviceModeWatcher:subscribe("aerospace_service_exit", function()
			serviceModeWatcher:set({ drawing = false })
		end)

		sbar.add("item", "service_mode.padding", {
			width = settings.dimens.padding.label,
		})

		findAndSelectCurrentWorkspace()
		updateSpaceWindows()
	end)
end

-- Add aerospace event watcher for immediate updates
local aerospaceWatcher = sbar.add("item", {
	drawing = false,
	updates = true,
})

-- Window watcher for other events
local windowWatcher = sbar.add("item", {
	drawing = false,
	updates = true,
})

-- Subscribe to aerospace window moved events (triggered by your aerospace config)
aerospaceWatcher:subscribe("aerospace_window_moved", function()
	updateSpaceWindows()
end)

windowWatcher:subscribe(constants.events.UPDATE_WINDOWS, function()
	updateSpaceWindows()
end)

windowWatcher:subscribe(constants.events.FRONT_APP_SWITCHED, function()
	updateSpaceWindows()
end)

swapWatcher:subscribe(constants.events.SWAP_MENU_AND_SPACES, function(env)
	local isShowingSpaces = env.isShowingMenu == "off" and true or false
	sbar.set("/" .. constants.items.SPACES .. "\\..*/", { drawing = isShowingSpaces })
end)

currentWorkspaceWatcher:subscribe(constants.events.AEROSPACE_WORKSPACE_CHANGED, function(env)
	selectCurrentWorkspace(env.FOCUSED_WORKSPACE)
end)

createWorkspaces()
