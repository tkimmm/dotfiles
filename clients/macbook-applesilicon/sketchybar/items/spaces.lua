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
	["1"] = { icon = "1 ", name = "shell" },
	["2"] = { icon = "2 ", name = "browse" },
	["3"] = { icon = "3 󰍫", name = "chat" },
	["4"] = { icon = "4 ", name = "collab" },
	["5"] = { icon = "5 ", name = "slack" },
	["6"] = { icon = "6 󰴢", name = "mail" },
	["7"] = { icon = "7 󱐋", name = "yea" },
	["8"] = { icon = "8 ", name = "extra" },
	["9"] = { icon = "9 󱐋", name = "extra2" },
	["10"] = { icon = "10 󱐋", name = "extra3" },
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

	sbar.trigger(constants.events.UPDATE_WINDOWS)
end

local function findAndSelectCurrentWorkspace()
	sbar.exec(constants.aerospace.GET_CURRENT_WORKSPACE, function(focusedWorkspaceOutput)
		local focusedWorkspaceName = focusedWorkspaceOutput:match("[^\r\n]+")
		selectCurrentWorkspace(focusedWorkspaceName)
	end)
end

local function addWorkspaceItem(workspaceName)
	local spaceName = constants.items.SPACES .. "." .. workspaceName
	local spaceConfig = spaceConfigs[workspaceName]

	spaces[spaceName] = sbar.add("item", spaceName, {
		label = {
			width = 0,
			padding_left = 0,
			string = spaceConfig.name,
		},
		icon = {
			string = spaceConfig.icon or settings.icons.apps["default"],
			color = settings.colors.white,
		},
		background = {
			color = settings.colors.bg2,
		},
		click_script = "aerospace workspace " .. workspaceName,
	})

	spaces[spaceName]:subscribe("mouse.entered", function(env)
		sbar.animate("tanh", 30, function()
			spaces[spaceName]:set({ label = { width = "dynamic" } })
		end)
	end)

	spaces[spaceName]:subscribe("mouse.exited", function(env)
		sbar.animate("tanh", 30, function()
			spaces[spaceName]:set({ label = { width = 0 } })
		end)
	end)

	sbar.add("item", spaceName .. ".padding", {
		width = settings.dimens.padding.label,
	})
end

local function createWorkspaces()
	sbar.exec(constants.aerospace.LIST_ALL_WORKSPACES, function(workspacesOutput)
		for workspaceName in workspacesOutput:gmatch("[^\r\n]+") do
			addWorkspaceItem(workspaceName)
		end

		serviceModeWatcher = sbar.add("item", "service_mode", {
			drawing = false,
			updates = true,
			position = "left",
			icon = {
				string = "⚙️",
				color = settings.colors.blue,
			},
			label = {
				string = "SERVICE",
				color = settings.colors.blue,
				font = {
					style = settings.fonts.styles.semibold,
					size = 12.0,
				},
			},
			background = {
				color = settings.colors.bg1,
				border_color = settings.colors.blue,
				border_width = 2,
				corner_radius = 6,
			},
			padding_left = 2,
			padding_right = 8,
		})

		-- Subscribe to events after creation
		serviceModeWatcher:subscribe("aerospace_service_enter", function(env)
			sbar.set("service_mode", { drawing = true })
		end)

		serviceModeWatcher:subscribe("aerospace_service_exit", function(env)
			sbar.set("service_mode", { drawing = false })
		end)

		sbar.add("item", "service_mode.padding", {
			width = settings.dimens.padding.label,
		})

		findAndSelectCurrentWorkspace()
	end)
end

swapWatcher:subscribe(constants.events.SWAP_MENU_AND_SPACES, function(env)
	local isShowingSpaces = env.isShowingMenu == "off" and true or false
	sbar.set("/" .. constants.items.SPACES .. "\\..*/", { drawing = isShowingSpaces })
end)

currentWorkspaceWatcher:subscribe(constants.events.AEROSPACE_WORKSPACE_CHANGED, function(env)
	selectCurrentWorkspace(env.FOCUSED_WORKSPACE)
	sbar.trigger(constants.events.UPDATE_WINDOWS)
end)

createWorkspaces()
