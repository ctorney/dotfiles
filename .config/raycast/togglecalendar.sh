#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Calendar
# @raycast.mode silent
# @raycast.packageName Navigation

# Optional parameters:
# @raycast.icon 󰸘  

# Documentation:
# @raycast.description Opens the Calendar space

# get the current workspace
current_space=$(flashspace get-workspace)


if [ "$current_space" == "CALENDAR" ]; then
    # If we are already in the Calendar space, go back to the previous space
    flashspace workspace --recent
else
    # Otherwise, switch to the Calendar space
    flashspace workspace --name CALENDAR
fi
