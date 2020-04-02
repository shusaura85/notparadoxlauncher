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
   path:string;

{$R *.res}

begin
gamedir := '';
for i:=1 to ParamCount-1 do
    if (ParamStr(i)= '--gameDir') then gamedir := ParamStr(i+1);

path := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
launcherpath := path+'launcher';

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

