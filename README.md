# Open CMD Here

Adds a localized option to the Windows context menu to open any folder or folder background directly in a Command Prompt.

## Features
- **Native OS Localization:** Dynamically loads Windows system strings (`shell32.dll`) so the context menu entry and title bar automatically adapt to your active Windows display language.
- **Configurable Window Title:** Choose between multiple window title formats (e.g., `Command Prompt - Folder`, `Folder Only`, `Full Path`, etc.) during setup.
- **Folder & Background Support:** Works when right-clicking an unopened folder icon or anywhere in the background of an open directory.
- **Clean Registry Management:** Registers safely under `HKCR` and `HKCU`, cleanly removing all registry entries upon uninstallation.

## Installation
1. Download the latest `OpenCmdHere_Setup_vX.X.X.exe` from [Releases](https://github.com/ILike2WatchMemes/open-cmd-here/releases/latest).
2. Run the installer and select your preferred window title format.

> **Tip:** If you wish to change your window title format preference in the future, simply re-run the installer.

## Build Locally

### Prerequisites
- [AutoIt v3 (x64)](https://www.autoitscript.com/site/autoit/downloads/) installed on your system.
- [Inno Setup 6+](https://jrsoftware.org/isinfo.php) installed on your system.

### Steps

1. **Compile the AutoIt Script:**
   - Open **Aut2exe** (AutoIt Script-to-Exe Converter).
   - Set **Script File:** `src/OpenCmdHere.au3`
   - Set **Output File:** `bin/OpenCmdHere.exe`
   - Set **Target Architecture:** `x64`
   - Click **Convert**.

2. **Compile the Installer:**
   - Open `setup.iss` in **Inno Setup Compiler**.
   - Press `Ctrl + F9` (or click **Build -> Compile**).
   - The compiled installer executable will be generated in `Output/`.
