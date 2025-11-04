#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Browser
# @raycast.mode silent
# @raycast.packageName Navigation

# Optional parameters:
# @raycast.icon 󰖟 
# Documentation:
# @raycast.description Opens the Browser space

# get the current workspace
current_space=$(flashspace get-workspace)


if [ "$current_space" == "BROWSER" ]; then
    # If we are already in the Calendar space, go back to the previous space
    flashspace workspace --recent
else
    # Otherwise, switch to the Calendar space
    flashspace workspace --name BROWSER
fi
