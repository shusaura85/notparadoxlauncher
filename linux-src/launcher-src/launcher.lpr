program launcher;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, lazcontrols, uMain, uOptions,
  SysUtils, process
  { you can add units after this };

{$R *.res}

function runScript(command:PChar):boolean;
begin
  Result := false;
  with TProcess.Create(nil) do
       try
         CommandLine := command;
         Execute;
       finally
         Free;
       end;
end;


begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TNotLauncherWindow, NotLauncherWindow);
  Application.CreateForm(TNotLauncherOptions, NotLauncherOptions);
  Application.Run;


// the app won't close properly if XDG_CURRENT_DESKTOP is set to "KDE"
// from online information, it would appear to be a bug in KDE (kio core)
if (GetEnvironmentVariable('XDG_CURRENT_DESKTOP') = 'KDE') then
   begin
   // call kill to terminate the app's pID. This way, even if the bug is triggered, the app still closes
   runScript(PChar('kill -15 ' + IntToStr(GetProcessID)));
   end;

end.

