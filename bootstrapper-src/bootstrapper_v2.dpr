program bootstrapper_v2;

{$R *.res}

uses
  Windows,
  ShellApi,
  System.SysUtils;

var
   gamedir:string;

begin
gamedir := '';
if (ParamStr(1)= '--gameDir') then gamedir := ParamStr(2);

if gamedir <> '' then ShellExecute(0,'open',PChar('launcher.exe'),PChar('--gameDir "'+gamedir+'"'), PChar(ExtractFilePath(ParamStr(0))), SW_SHOWNORMAL)
                 else ShellExecute(0,'open',PChar('launcher.exe'),nil, PChar(ExtractFilePath(ParamStr(0))), SW_SHOWNORMAL);

end.
