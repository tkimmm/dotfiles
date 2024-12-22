#!/bin/bash

CONFIG_FILE="$HOME/.config/aerospace/aerospace.toml"

set_gap() {
  local gap_value=$1
  sed -i '' "s/^outer\.top = .*/outer.top = $gap_value/" "$CONFIG_FILE"
  # sed -i '' "s/^outer\.bottom = .*/outer.bottom = $gap_value/" "$CONFIG_FILE"
  # sed -i '' "s/^outer\.left = .*/outer.left = $gap_value/" "$CONFIG_FILE"
  # sed -i '' "s/^outer\.right = .*/outer.right = $gap_value/" "$CONFIG_FILE"
}

# Get the number of monitors
monitor_count=$(aerospace list-monitors | wc -l)

if [ "$monitor_count" -gt 1 ]; then
  # Multiple displays
  set_gap 50
else
  # Single display
  set_gap 10
fi

# Reload Aerospace configuration
aerospace reload-config
