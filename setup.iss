#define MyAppName "Open CMD Here"
#define MyAppPublisher "Justus Schultz"
#define MyAppVersion "1.0.0"
#define MyAppExeName "OpenCmdHere.exe"

[Setup]
AppId={{8F7A3C12-9B3E-4A1D-B2C5-91A234567890}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputDir=Output
OutputBaseFilename=OpenCmdHere_Setup_v{#MyAppVersion}
Compression=lzma2/ultra64
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64compatible
ShowLanguageDialog=yes

[Languages]
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "bin\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion

[Registry]
; Context menu for right-clicking a folder
Root: HKCR; Subkey: "Directory\shell\OpenCmdHere"; ValueType: string; ValueName: "MUIVerb"; ValueData: "@shell32.dll,-8506"; Flags: uninsdeletekey
Root: HKCR; Subkey: "Directory\shell\OpenCmdHere"; ValueType: string; ValueName: "Icon"; ValueData: "cmd.exe"
Root: HKCR; Subkey: "Directory\shell\OpenCmdHere\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""

; Context menu for right-clicking inside an open folder (Background)
Root: HKCR; Subkey: "Directory\Background\shell\OpenCmdHere"; ValueType: string; ValueName: "MUIVerb"; ValueData: "@shell32.dll,-8506"; Flags: uninsdeletekey
Root: HKCR; Subkey: "Directory\Background\shell\OpenCmdHere"; ValueType: string; ValueName: "Icon"; ValueData: "cmd.exe"
Root: HKCR; Subkey: "Directory\Background\shell\OpenCmdHere\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%V"""