#!/bin/bash

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "0" )

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))

  padding_left=$((i==0 ? 12 : 4))
  padding_right=$((i==9 ? 12 : 4))

  # # if i is 1 or 10 then change the left or right padding
  # if [ $i -eq 0 ]; then
  #   padding_left=10
  # elif [ $i -eq 9 ]; then
  #   padding_right=10
  # fi

  space=(
    associated_space=$sid
    icon=${SPACE_ICONS[i]}
    icon.padding_left=8
    icon.width=20
    icon.align=center
    icon.padding_right=8
    icon.color=$FG
    background.padding_left=$padding_left
    background.padding_right=$padding_right
    icon.font="Roboto:Bold:11.0"
    label.drawing=off
    script="$PLUGIN_DIR/space.sh"
    background.border_color=0xffffd3c6aa
    background.border_width=2
    background.drawing=on
    background.corner_radius=10
    background.height=20
  )

  sketchybar --add space space.$sid left    \
             --set space.$sid "${space[@]}" \
             --subscribe space.$sid mouse.clicked
done

spaces=(
  background.color=0xffcc01010A
  background.border_color=0xffffd3c6aa
  background.border_width=2
  background.drawing=on
)

separator=(
  icon="|"
  icon.font="Roboto:Bold:16.0"
  icon.color=0xff414b50
  icon.drawing=on
  icon.padding_left=8
  icon.padding_right=8
  background.padding_left=4
  background.padding_right=4
  background.border_color=0x00000000
  background.border_width=0
  background.drawing=on
  background.corner_radius=10
  background.height=20
)

sketchybar --add item separator1 left \
            --set separator1 "${separator[@]}"


FRONT_APP_SCRIPT='sketchybar --set $NAME label="$INFO"'

front_app=(
  script="$FRONT_APP_SCRIPT"
  icon.drawing=off
  padding_left=0
  width=120
  label.color=0xffd3c6aa
  label.align=center
  align=center
  label.font="Roboto:Regular:14.0"
  associated_display=active
)

sketchybar --add item front_app left           \
           --set front_app "${front_app[@]}"   \
           --subscribe front_app front_app_switched

sketchybar --add item separator2 left \
            --set separator2 "${separator[@]}"

sketchybar --add event window_focus \
	--add event title_change



title=(
  script="$HOME/.config/sketchybar/plugins/window_title.sh"
  icon.drawing=off
  padding_left=0
  width=285
  label.color=0xffd3c6aa
  label.align=center
  align=left
  label.font="Roboto:Regular:14.0"
  associated_display=active
)

sketchybar --add item title left \
	--set title "${title[@]}" \
	--subscribe title window_focus front_app_switched space_change title_change

sketchybar --add bracket spaces '/space\..*/' \
            separator1 \
            front_app \
            separator2 \
            title \
           --set spaces "${spaces[@]}"        
