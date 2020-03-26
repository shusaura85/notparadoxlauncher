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

   //f:Text;
   i:integer;

{$R *.res}

begin
gamedir := '';
// Sunset Harbor update added a new parameter to the launcher --pdxlGameDir but it still has the original --gameDir parameter so we aren't using it at this moment
{
for i:=1 to ParamCount-1 do
    if (ParamStr(i) = '--pdxlGameDir') then gamedir := ParamStr(i+1);
}
// pre Sunset Harbor update
if gamedir = '' then
   begin
   for i:=1 to ParamCount-1 do
       if (ParamStr(i)= '--gameDir') then gamedir := ParamStr(i+1);
   end;

launcherpath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'launcher';

{
Assign(f, IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'debug.txt');
Rewrite(f);
if IOResult = 0 then
   begin
   WriteLn(F, 'Param Count: '+IntToStr(ParamCount));
   for i:= 0 to ParamCount do
       WriteLn(F, 'Param '+IntToStr(i)+': '+ParamStr(i));

   System.Close(F);
   end;
}

RunProgram := TProcess.Create(nil);
RunProgram.Executable:= launcherpath; //'/home/shu/.notparadoxlauncher/launcher';
RunProgram.Parameters.Add('--gameDir');
RunProgram.Parameters.Add(gamedir);
//RunProgram.Options:= RunProgram.Options + [poUsePipes];
RunProgram.Execute;
RunProgram.Free;
end.

