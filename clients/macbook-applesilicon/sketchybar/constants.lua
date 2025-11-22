local events <const> = {
	AEROSPACE_WORKSPACE_CHANGED = "aerospace_workspace_change",
	AEROSPACE_WINDOW_MOVED = "aerospace_window_moved",
	AEROSPACE_SWITCH = "aerospace_switch",
	SWAP_MENU_AND_SPACES = "swap_menu_and_spaces",
	FRONT_APP_SWITCHED = "front_app_switched",
	UPDATE_WINDOWS = "update_windows",
	SEND_MESSAGE = "send_message",
	HIDE_MESSAGE = "hide_message",
	AEROSPACE_SERVICE_ENTER = "aerospace_service_enter",
	AEROSPACE_SERVICE_EXIT = "aerospace_service_exit",
}

local items <const> = {
	SPACES = "workspaces",
	MENU = "menu",
	MENU_TOGGLE = "menu_toggle",
	FRONT_APPS = "front_apps",
	MESSAGE = "message",
	VOLUME = "widgets.volume",
	WIFI = "widgets.wifi",
	BATTERY = "widgets.battery",
	CALENDAR = "widgets.calendar",
	WORLD_CLOCKS = "widgets.world_clocks",
}

local aerospace <const> = {
	GET_CURRENT_WORKSPACE = "aerospace list-workspaces --focused",
	LIST_ALL_WORKSPACES = "aerospace list-workspaces --all",
	LIST_WINDOWS = "aerospace list-windows --all --format 'id=%{window-id} name=%{app-name} workspace=%{workspace}'",
	GET_CURRENT_WINDOW = "aerospace list-windows --focused --format '%{app-name}'",
	GET_WORKSPACE_APPS = "aerospace list-windows --workspace %s --format %%{app-name}",
	LIST_ALL_WINDOWS = 'aerospace list-windows --all --format "workspace=%{workspace}, name=%{app-name}"',
	CHECK_RESIZE_MODE = "aerospace list-modes | grep -q resize && echo 'true' || echo 'false'",
}

return {
	items = items,
	events = events,
	aerospace = aerospace,
}
