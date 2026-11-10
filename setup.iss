#define MyAppName "Open CMD Here"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Schultz Solutions"
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
ArchitecturesInstallIn64BitMode=x64
ShowLanguageDialog=yes

[Languages]
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "bin\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion

[Registry]
; Kontextmenü für Ordner
Root: HKCR; Subkey: "Directory\shell\OpenCmdHere"; ValueType: string; ValueData: "Eingabeaufforderung hier öffnen"; Flags: uninsdeletekey
Root: HKCR; Subkey: "Directory\shell\OpenCmdHere"; ValueType: string; ValueName: "Icon"; ValueData: "cmd.exe"
Root: HKCR; Subkey: "Directory\shell\OpenCmdHere\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%1"""

; Kontextmenü für den Hintergrund eines geöffneten Ordners
Root: HKCR; Subkey: "Directory\Background\shell\OpenCmdHere"; ValueType: string; ValueData: "Eingabeaufforderung hier öffnen"; Flags: uninsdeletekey
Root: HKCR; Subkey: "Directory\Background\shell\OpenCmdHere"; ValueType: string; ValueName: "Icon"; ValueData: "cmd.exe"
Root: HKCR; Subkey: "Directory\Background\shell\OpenCmdHere\command"; ValueType: string; ValueData: """{app}\{#MyAppExeName}"" ""%V"""