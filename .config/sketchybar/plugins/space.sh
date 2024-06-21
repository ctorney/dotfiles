#!/bin/bash

update() {

  if [ "$SELECTED" = "true" ]; then
    sketchybar --set $NAME background.color=0xffa7c080 icon.color=0xcc01010A background.border_color=0xffa7c080
  else

      apps=$(yabai -m query --windows --space $SID | jq -r ".[].app")
      if [ "$apps" != "" ]; then
        sketchybar --set $NAME background.color=0xcc01010A icon.color=0xffd3c6aa background.border_color=0xffd3c6aa
      else
        sketchybar --set $NAME background.color=0xcc01010A icon.color=0xff414b50 background.border_color=0xff414b50
      fi

  fi

}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    yabai -m space --destroy $SID
    sketchybar --trigger space_change --trigger windows_on_spaces
  else
    yabai -m space --focus $SID 2>/dev/null
  fi
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *) update
  ;;
esac
