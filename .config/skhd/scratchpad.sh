#!/bin/sh

open_cmd="open -a Calendar"


scratchpad_id=$(yabai -m query --windows | jq -c '[.[] | select(.app=="Calendar").id][0]')

if [[ "$scratchpad_id" -lt 1 ]]; then
  $open_cmd 
else
  osascript -e 'quit app "Calendar"'
fi
