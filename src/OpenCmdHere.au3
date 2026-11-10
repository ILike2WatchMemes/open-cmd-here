If $CmdLine[0] = 1 Then
    Local $selectedFolder = $CmdLine[1]

    ; Load the localized "Command Prompt" string from Windows shell32.dll (Resource -22022)
    Local $localizedCmdName = _GetMUIString("@shell32.dll,-22022")
    If $localizedCmdName = "" Then $localizedCmdName = "Command Prompt" ; Fallback if reading fails

    Local $folderName = StringRegExpReplace($selectedFolder, '.*[\\]', '')

    ; Title format: "Command Prompt - folderName"
    Run(@ComSpec & ' /k title ' & $localizedCmdName & ' - ' & $folderName & ' && cd /d ' & $selectedFolder & ' && cls', "", @SW_SHOW)
Else
    MsgBox(48, "Error", "No folder selected.")
EndIf

; Helper function to resolve MUI string resource paths like "@shell32.dll,-22022"
Func _GetMUIString($sMuiSource)
    Local $aResult = DllCall("shlwapi.dll", "int", "SHLoadIndirectString", "wstr", $sMuiSource, "wstr", "", "uint", 1024, "ptr", 0)
    If Not @error And $aResult[0] = 0 Then Return $aResult[2]
    Return ""
EndFunc