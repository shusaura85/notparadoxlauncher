program bootstrapper_v2;

{$R *.res}

uses
  Windows,
  ShellApi,
  System.SysUtils;

var
   gamedir:string;
   i:integer;

begin
gamedir := '';
if gamedir = '' then
   begin
   for i:=1 to ParamCount-1 do
       if (ParamStr(i)= '--gameDir') then gamedir := ParamStr(i+1);
   end;

if gamedir <> '' then ShellExecute(0,'open',PChar('launcher.exe'),PChar('--gameDir "'+gamedir+'"'), PChar(ExtractFilePath(ParamStr(0))), SW_SHOWNORMAL)
                 else ShellExecute(0,'open',PChar('launcher.exe'),nil, PChar(ExtractFilePath(ParamStr(0))), SW_SHOWNORMAL);

end.
