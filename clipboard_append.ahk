#NoTrayIcon  ; Hide tray icon for service-like experience
global collectedText := ""

; 🔹 Append copied text to memory (Ctrl + Shift + C)
^+c::
    ClipSaved := ClipboardAll
    Clipboard := ""
    Send, ^c
    ClipWait, 1  ; Added timeout parameter
    if ErrorLevel
        return   ; Skip if clipboard is empty/timeout
    collectedText .= Trim(Clipboard) . "`n`n"
    Clipboard := ClipSaved
    ClipSaved := ""  ; Free memory
return

; 🔹 Paste all collected snippets (Ctrl + Shift + V)
^+v::
    if (collectedText = "")  ; Check if there's content
        return
    ClipSaved := ClipboardAll
    Clipboard := collectedText
    Send, ^v
    Sleep, 100  ; Brief pause
    Clipboard := ClipSaved
    ClipSaved := ""  ; Free memory
return

; 🔹 Clear clipboard memory (Ctrl + Shift + X)
^+x::
    collectedText := ""
    MsgBox, 64, Clipboard Manager, 📋 Clipboard memory cleared!
return

; 🔹 Reverse tab function - Make both left and right Shift+Tab work
; Left Shift + Tab
LShift & Tab::Send, +{Tab}  ; Explicitly map left Shift+Tab

; Right Shift + Tab
RShift & Tab::Send, +{Tab}  ; Explicitly map right Shift+Tab

; GUI - Fixed control handling
gui_example:
    Gui, Add, Text,, Test the tab functionality:
    Gui, Add, Edit, vText1 w200, Text Box 1
    Gui, Add, Edit, vText2 w200, Text Box 2
    Gui, Add, Edit, vText3 w200, Text Box 3
    Gui, Add, Button, gSubmit, Submit
    Gui, Show, w220, Clipboard Manager
return

Submit:
    Gui, Submit, NoHide
    MsgBox, 64, Form Data, You entered:`n%Text1%`n%Text2%`n%Text3%
return

GuiClose:
GuiEscape:
    ExitApp