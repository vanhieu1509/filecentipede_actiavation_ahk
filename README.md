# Auto Activation Code Paster for File Centipede

This AutoHotkey v1 script automatically fetches the latest activation code for [File Centipede](https://filecxx.com) and pastes it into the active input field with a single shortcut: `Ctrl + Shift + A`.

## 🔧 Features

- Automatically downloads the activation page (`activation_code.html`)
- Extracts the currently valid activation code based on today’s date
- Copies the code to clipboard
- Pastes it into the focused input field
- Shows confirmation popup for debugging or confirmation

## ✅ Requirements

- [AutoHotkey v1.x](https://www.autohotkey.com/)
  > ⚠️ This script is written for **AutoHotkey v1**, not compatible with v2.

## 🚀 Usage

1. Install AutoHotkey v1.
2. Download or clone this repository.
3. Run the `.ahk` script.
4. Place your cursor in the activation input field of File Centipede.
5. Press `Ctrl + Shift + A`.

That's it! The activation code will be fetched and pasted automatically.

## 📁 Debug

If no valid activation code is found, the full HTML content of the activation page will be saved to:
