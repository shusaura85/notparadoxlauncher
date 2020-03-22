program bootstrapper_v2;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,
  Process, SysUtils;

var
   gamedir:string;
   launcherpath : string;
   RunProgram: TProcess;

{$R *.res}

begin
gamedir := '';
if (ParamStr(1)= '--gameDir') then gamedir := ParamStr(2);

launcherpath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'launcher';

RunProgram := TProcess.Create(nil);
RunProgram.Executable:= launcherpath; //'/home/shu/.notparadoxlauncher/launcher';
RunProgram.Parameters.Add('--gameDir');
RunProgram.Parameters.Add(gamedir);
//RunProgram.Options:= RunProgram.Options + [poUsePipes];
RunProgram.Execute;
RunProgram.Free;
end.

