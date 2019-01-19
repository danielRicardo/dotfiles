on run argv
    tell application "iTerm2"
        
        # open new tab
        tell current window
            create tab with default profile
        end tell
        set ssn to (current session of current window)

        # split tabs according to the number of servers
        repeat with i from 2 to count argv
            tell current session of current window
                if i mod 2 equals 0 and i is not count argv then
                    set ssn to (split horizontally with default profile)
                else
                    split vertically with default profile
                    select ssn
                end
            end tell
        end repeat

        # ssh to servers
        repeat with i from 1 to count argv
            tell session i of current tab of current window
                write text "ssh " & (item i of argv)
            end tell
        end repeat
    end tell
    
    # enable input broadcast
    tell application "System Events"
        delay 0.5
        key code 34 using {option down, command down} # { command + option + I }
        delay 0.2
        key code 36 # { enter }
    end tell
end run