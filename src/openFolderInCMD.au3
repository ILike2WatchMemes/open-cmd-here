If $CmdLine[0] = 1 Then
    Local $selectedFolder = $CmdLine[1]
	Run(@ComSpec & ' /k cd ' & $selectedFolder &' && cls', "", @SW_SHOW)
Else
    MsgBox(48, "Error", "No folder selected.")
EndIf