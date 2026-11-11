#ifndef MyAppVersion
  #define MyAppVersion "v1.0.4"
#endif

#define MyAppName "Open CMD Here"
#define MyAppPublisher "Justus Schultz"
#define MyAppExeName "OpenCmdHere.exe"

[Setup]
AppId={{EC1EC422-2B31-4C05-B29F-BA7E70491B6E}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputDir=Output
OutputBaseFilename=OpenCmdHere_Setup_{#MyAppVersion}
Compression=lzma2/ultra64
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64compatible
ShowLanguageDialog=yes
CloseApplications=yes
UninstallDisplayIcon={app}\{#MyAppExeName}

[Languages]
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

; Clean up the user preference key on uninstall
Root: HKCU; Subkey: "Software\OpenCmdHere"; Flags: uninsdeletekey

[Code]
var
  TitleFormatPage: TInputOptionWizardPage;

procedure InitializeWizard();
begin
  // Create radio button options page
  TitleFormatPage := CreateInputOptionPage(
    wpSelectDir,
    'Window Title Format',
    'Choose how the Command Prompt title bar should be displayed.' + #13#10 + 'Simply Re-run the installer if you wish to change this setting in the future.',
    'Select your preferred title format:',
    True,  // Exclusive selection (Radio buttons)
    False
  );

  // Add format options
  TitleFormatPage.Add('Command Prompt');
  TitleFormatPage.Add('Folder only (e.g., "src")');
  TitleFormatPage.Add('Full Path (e.g., "C:\Projects\src")');
  TitleFormatPage.Add('Command Prompt - Folder (e.g., "Command Prompt - src")');
  TitleFormatPage.Add('Command Prompt [Full Path] (e.g., "Command Prompt [C:\Projects\src]")');

  // Set default selection (Option 0 = Command Prompt)
  TitleFormatPage.SelectedValueIndex := 0;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  SelectedFormat: String;
begin
  if CurStep = ssPostInstall then
  begin
    case TitleFormatPage.SelectedValueIndex of
      0: SelectedFormat := '{cmd}';
      1: SelectedFormat := '{folder}';
      2: SelectedFormat := '{path}';
      3: SelectedFormat := '{cmd} - {folder}';
      4: SelectedFormat := '{cmd} [{path}]';
    else
      SelectedFormat := '{cmd}';
    end;

    // Write choice directly to Registry
    RegWriteStringValue(HKCU, 'Software\OpenCmdHere', 'TitleFormat', SelectedFormat);
  end;
end;