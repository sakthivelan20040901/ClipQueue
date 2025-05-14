# 🧠 Clipboard Manager (AutoHotkey)

A powerful and minimal clipboard manager built with AutoHotkey. This tool allows you to **append copied text**, **classify entries** (URL, Code, Text), **view logs with color coding**, and **manage clipboard history** via a user-friendly GUI.

---

## 📦 Features

- ✅ **Append copied snippets** using `Ctrl + Shift + C`
- 🕒 **Track time and type** of each clipboard entry
- 🌐 **Classify copied content** as:
  - `URL` – Blue
  - `Code` – Gray
  - `Text` – Green
- 📋 **Paste all collected entries** using `Ctrl + Shift + V`
- 💾 **Export clipboard** to a `.txt` file (`Ctrl + Shift + E`)
- ✍️ **Edit collected text** inside GUI
- 📤 **Copy, clear, save, or export** from GUI (`Ctrl + Shift + G`)
- ❎ **Reset clipboard memory** using `Ctrl + Shift + X`
- 🔁 **Custom Shift+Tab mappings** for both left and right Shift keys

---

## 🖥️ Hotkey Summary

| Hotkey              | Action                          |
|---------------------|----------------------------------|
| `Ctrl + Shift + C`  | Copy and append to memory        |
| `Ctrl + Shift + V`  | Paste all collected text         |
| `Ctrl + Shift + X`  | Clear clipboard memory           |
| `Ctrl + Shift + E`  | Export clipboard to `.txt`       |
| `Ctrl + Shift + G`  | Open GUI to view/edit/export     |
| `LShift + Tab`      | Reverse tab                     |
| `RShift + Tab`      | Reverse tab                     |

---

## ⚙️ Setup Instructions

### 🔧 Step 1: Install AutoHotkey
- Download from the [official AutoHotkey site](https://www.autohotkey.com/)
- Run the installer and choose the **Unicode 64-bit** version

### 📁 Step 2: Create and Run the Script
1. Open **Notepad** or any text editor
2. Paste the full clipboard manager script code
3. Save it as:  
   `ClipboardManager.ahk`
4. Double-click the `.ahk` file to run it

✅ You’ll now be able to use the hotkeys and GUI features!

> Optional: Place a shortcut in the `Startup` folder to run on Windows boot:
> ```
> Win + R → shell:startup
> ```

---

## 🎨 GUI Preview

- A categorized clipboard log
- Color-coded entries:
  - 🔵 URLs
  - ⚪ Code Snippets
  - 🟢 Plain Text
- Full edit box with:
  - 💾 Save
  - 📋 Copy
  - ❌ Clear
  - 📤 Export
  - ❎ Close

---

## 🔍 How It Works

### 📋 Clipboard Logging
Each copy (`^+c`) captures:
- Text content
- Timestamp
- Content type (via pattern matching)

### 🔍 Type Detection Logic
```autohotkey
DetectClipboardType(text) {
    if RegExMatch(text, "i)^(https?|ftp)://\S+$")
        return "URL"
    else if (InStr(text, "{") && InStr(text, "}")) || RegExMatch(text, "i)\b(function|var|let|const|if|else|<[^>]+>)\b")
        return "Code"
    else
        return "Text"
}
🧰 Requirements
Run the Precompiled .exe
Download the latest .exe file from Releases
Double-click to run.
It will work silently in the background. No installation required!
📌 You may optionally add it to:

Startup folder to launch on boot
Use a tool like TrayIt! to keep it in the background tray (optional)

📁 Export Format
When exporting, the full collected text is saved to a user-selected .txt file in UTF-8 format.

💡 Future Enhancements
🔍 Search/filter in GUI

📅 Date-based grouping

🌓 Theme support

📌 Pin snippets

🔔 Tray icon quick access

👨‍💻 Author
Created with ❤️ by Sakthivelan
Inspired by daily productivity needs 🧠

📜 License
This project is free to use and modify for personal or professional use. Attribution appreciated but not required.

Let me know if you'd like the README exported as a downloadable file (`.md`), or if you'd like to add screenshots, badges, or GitHub instructions.
