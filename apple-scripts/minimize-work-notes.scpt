# Minimize all Terminal and MacVim windows that contain the substring "work-notes" in their titles
# References: https://stackoverflow.com/questions/3535957/close-multiple-safari-windows-using-applescript

set keyword to "work-notes"
set appList to {"MacVim", "Emacs", "iTerm", "Terminal"}
set miniaturizedState to true

repeat with appName in appList
    if application appName is running then
        tell application appName
            set miniaturized of (every window whose name contains keyword) to miniaturizedState
        end tell
    end if
end repeat

