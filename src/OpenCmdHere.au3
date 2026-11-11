#NoTrayIcon
If $CmdLine[0] >= 1 Then
    Local $selectedFolder = $CmdLine[1]

    ; Strip trailing backslashes (e.g., "C:\" -> "C:") for uniform parsing
    $selectedFolder = StringRegExpReplace($selectedFolder, '[\\/]+$', '')
    If StringLen($selectedFolder) = 2 And StringRight($selectedFolder, 1) = ":" Then
        $selectedFolder &= "\" ; Keep root drive backslash intact (e.g., "C:\")
    EndIf

    ; Load localized "Command Prompt" string from shell32.dll (Resource -22022)
    Local $localizedCmdName = _GetMUIString("@shell32.dll,-22022")
    If $localizedCmdName = "" Then $localizedCmdName = "Command Prompt" ; Fallback if reading fails

    Local $folderName = StringRegExpReplace($selectedFolder, '.*[\\]', '')
    If $folderName = "" Then $folderName = $selectedFolder

    ; Read title format from Registry (Default: "{cmd}")
    ; Supported tokens:
    ;   {cmd}    -> Localized Command Prompt name (e.g., "Eingabeaufforderung")
    ;   {folder} -> Directory name (e.g., "src")
    ;   {path}   -> Full directory path (e.g., "C:\Projects\src")
    Local $titleFormat = RegRead("HKCU\Software\OpenCmdHere", "TitleFormat")
    If @error Or $titleFormat = "" Then $titleFormat = "{cmd}"

    ; Replace tokens
    Local $windowTitle = $titleFormat
    $windowTitle = StringReplace($windowTitle, "{cmd}", $localizedCmdName)
    $windowTitle = StringReplace($windowTitle, "{folder}", $folderName)
    $windowTitle = StringReplace($windowTitle, "{path}", $selectedFolder)

	; ESCAPE FIX: Escape special CMD characters (&, |, <, >, ^) with a caret (^) for the title
    $windowTitle = StringRegExpReplace($windowTitle, '([&|<>^])', '^\1')

    ; Launch cmd with customized window title
    Run(@ComSpec & ' /k "title ' & $windowTitle & ' && cd /d "' & $selectedFolder & '" && cls"', "", @SW_SHOW)
Else
    MsgBox(48, "Error", "No folder selected.")
EndIf

; Helper function to resolve MUI string resource paths like "@shell32.dll,-22022"
Func _GetMUIString($sMuiSource)
    Local $aResult = DllCall("shlwapi.dll", "int", "SHLoadIndirectString", "wstr", $sMuiSource, "wstr", "", "uint", 1024, "ptr", 0)
    If Not @error And $aResult[0] = 0 Then Return $aResult[2]
    Return ""
EndFunc
