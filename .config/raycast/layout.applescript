#!/usr/bin/osascript

# @raycast.schemaVersion 1
# @raycast.author Colin Torney
# @raycast.description Applies the window layout from the Window Layouts Raycast extension.
# @raycast.packageName Navigation
# @raycast.title Auto-Layout Windows
# @raycast.mode silent
# @raycast.icon 󰧨  


on run argv
  try
    tell application "System Events"
      set frontmostApplicationName to name of 1st process whose frontmost is true
    end tell


    do shell script "flashspace assign-visible-apps"
    set winCount to my countVisibleWindows()
    
    if winCount = 2 then 
      do shell script "open 'raycast://extensions/teemu_suvinen/window-layouts/horizontal-50-50'"
      # return
    end if

    if winCount = 3 then 
      do shell script "open 'raycast://extensions/teemu_suvinen/window-layouts/horizontal-3'"
      # return
    end if

    if winCount ≥ 4 then 
      do shell script "open 'raycast://extensions/teemu_suvinen/window-layouts/grid'"
      # return
    end if

    tell application frontmostApplicationName
      activate
    end tell

  on error errMsg
    return 
  end try
end run

on countVisibleWindows()
    tell application "System Events"
        set theCount to 0
        repeat with _app in (every process whose visible is true)
            tell _app
                set theCount to theCount + (count of every window)
            end tell
        end repeat
    end tell
    return theCount
end countVisibleWindows
