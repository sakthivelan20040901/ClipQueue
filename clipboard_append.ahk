; Clipboard Append Script (No File, Only Memory)
#NoTrayIcon  ; Hide tray icon for service-like experience

global collectedText := ""

^+c::  ; Ctrl + Shift + C to append copied text
    ClipSaved := ClipboardAll
    Clipboard := ""
    Send, ^c
    ClipWait
    collectedText .= Clipboard . "`n`n"
    Clipboard := ClipSaved
return

^+v::  ; Ctrl + Shift + V to paste all appended clipboard
    Clipboard := collectedText
    Send, ^v
return

^+x::  ; Ctrl + Shift + X to clear the collected clipboard
    collectedText := ""
    MsgBox, Clipboard memory cleared!
return
