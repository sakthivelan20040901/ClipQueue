#NoTrayIcon
#Persistent
#SingleInstance Force

global collectedText := ""
global clipLog := []

; 🔹 Append copied text to memory (Ctrl + Shift + C)
^+c::
{
    ToolTip, 🔄 Copying...
    ClipSaved := ClipboardAll
    Clipboard := ""  ; Clear to detect change

    SendInput, ^c
    ClipWait, 2
    if (ErrorLevel) {
        Clipboard := ClipSaved
        ToolTip
        MsgBox 16, Error, ❌ Failed to copy text to clipboard.
        return
    }

    newText := Trim(Clipboard)
    if (newText != "") {
        collectedText .= newText . "`n`n"
        clipType := DetectClipboardType(newText)
        currentTime := FormatTime(A_Now, "HH:mm:ss")
        clipLog.Push({text: newText, time: currentTime, type: clipType})
        ToolTip, ✅ Text added at %currentTime%
    } else {
        ToolTip, ⚠️ No new text found
    }

    Sleep 1500
    ToolTip
    Clipboard := ClipSaved
    return
}

; 🔹 Paste all collected snippets (Ctrl + Shift + V)
^+v::
{
    if (collectedText = "")
        return
    ClipSaved := ClipboardAll
    Clipboard := collectedText
    SendInput, ^v
    Sleep 100
    Clipboard := ClipSaved
    return
}

; 🔹 Clear clipboard memory (Ctrl + Shift + X)
^+x::
{
    collectedText := ""
    clipLog := []
    MsgBox 64, Clipboard Manager, 📋 Clipboard memory cleared!
    return
}

; 🔹 Export to file (Ctrl + Shift + E)
^+e::
{
    FileSelectFile filePath, S16, ClipQueue.txt, Save ClipQueue, Text Documents (*.txt)
    if (filePath != "") {
        try {
            FileAppend, %collectedText%, %filePath%, UTF-8
            MsgBox 64, Exported, ✅ Clipboard saved to:`n%filePath%
        } catch e {
            MsgBox 16, Error, Failed to save file: %e%
        }
    }
    return
}

; 🔹 GUI - Enhanced ClipQueue with color-coded entries (Ctrl + Shift + G)
^+g::
{
    Gui Clipboard:New, +AlwaysOnTop +Resize
    Gui Clipboard:Font, s9, Segoe UI
    Gui Clipboard:Add, Text, x10 y10, 🧾 Clipboard Log:

    ; Display each log entry with color based on type
    yPos := 40
    for index, entry in clipLog {
        entryText := "[" . entry.time . "] " . SubStr(entry.text, 1, 100) ; Limit text length for display
        color := (entry.type = "URL") ? "Blue"
              : (entry.type = "Code") ? "Gray"
              : "Green"
        Gui Clipboard:Font, c%color%
        Gui Clipboard:Add, Text, x10 y%yPos% w520 vClip%index%, %entryText%
        yPos += 30
    }

    ; Reset font color and add editable field
    Gui Clipboard:Font, cBlack
    Gui Clipboard:Add, Text, x10 y%yPos%, ✍️ Edit All Collected Text Below:
    yPos += 20
    Gui Clipboard:Add, Edit, x10 y%yPos% w520 h200 vEditClipboardData, %collectedText%
    yPos += 210
    Gui Clipboard:Add, Button, x10 y%yPos% gSaveClipboardEdit, 💾 Save
    Gui Clipboard:Add, Button, x110 yp gCopyClipboard, 📋 Copy All
    Gui Clipboard:Add, Button, x210 yp gClearClipboard, ❌ Clear
    Gui Clipboard:Add, Button, x310 yp gExportClipboard, 📤 Export
    Gui Clipboard:Add, Button, x410 yp gCloseClipboard, ❎ Close
    Gui Clipboard:Show, w550 h600, ClipQueue Editor 🧠
    return
}

; 🔹 GUI Button Handlers
SaveClipboardEdit:
{
    Gui Clipboard:Submit, NoHide
    collectedText := EditClipboardData
    MsgBox 64, Saved, ✅ Clipboard data updated.
    return
}

CopyClipboard:
{
    if (collectedText != "") {
        Clipboard := collectedText
        MsgBox 64, Copied, All collected clipboard data copied.
    }
    return
}

ClearClipboard:
{
    collectedText := ""
    clipLog := []
    Gui Clipboard:Destroy
    MsgBox 64, Clipboard Manager, 📋 Memory cleared!
    return
}

ExportClipboard:
{
    Gosub ^+e
    return
}

CloseClipboard:
{
    Gui Clipboard:Destroy
    return
}

; 🔹 Reverse tab functionality
LShift & Tab::Send {Shift down}{Tab}{Shift up}
RShift & Tab::Send {Shift down}{Tab}{Shift up}

; 🔹 Detect clipboard type function
DetectClipboardType(text) {
    if RegExMatch(text, "i)^(https?|ftp)://\S+$")
        return "URL"
    else if (InStr(text, "{") && InStr(text, "}")) || RegExMatch(text, "i)\b(function|var|let|const|if|else|<[^>]+>)\b")
        return "Code"
    else
        return "Text"
}

; 🔹 Format time helper
FormatTime(time, format) {
    FormatTime formattedTime, %time%, %format%
    return formattedTime
}