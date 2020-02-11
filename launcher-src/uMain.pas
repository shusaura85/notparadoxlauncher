unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ShellApi, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, JsonDataObjects, launcher_utils;

type
  TNotLauncherWindow = class(TForm)
    Image1: TImage;
    lblVersion: TLabel;
    lblVersionShadow: TLabel;
    SetupTimer: TTimer;
    lblGameTitle: TLabel;
    lblGameTitleShadow: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SetupTimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    gamedir : string;
    gameexe : string;

    obj: TJsonObject;


    procedure StartGame;
  end;

var
  NotLauncherWindow: TNotLauncherWindow;

implementation

{$R *.dfm}

procedure TNotLauncherWindow.SetupTimerTimer(Sender: TObject);
begin
SetupTimer.Enabled := false;
ShowMessage('Not Paradox Launcher is setup! Start the game from Steam as usual!');
Close;
end;

procedure TNotLauncherWindow.StartGame;
var
 SI : TStartupInfo;
 PI : TProcessInformation ;
 FileName : String ;
 pid:cardinal;
 steampath, steamoverlay:string;
begin

// prepare vars for createprocess
FileName := gamedir + gameexe; //'Cities.exe';
ZeroMemory(@SI,sizeof(SI));
SI.cb := sizeof(SI);

// start the game
CreateProcess(PChar(FileName),nil,nil,nil,False,0,nil,PChar(gamedir),SI,PI);
// get game pid
pid := PI.dwProcessId;

// start steam overlay
steampath := GetSteamPath;
steamoverlay := GetSteamOverlayExe;

// C:\Program Files (x86)\Steam\ GameOverlayUI.exe
// run steam overlay
// SteamOverlayUI.exe -pid gamepid -manuallyclearframes 0
ShellExecute(0,'open',PChar(steamoverlay),PChar('-pid '+IntToStr(pid)+' -manuallyclearframes 0'),PChar(steampath), SW_SHOWNORMAL);


end;



procedure TNotLauncherWindow.FormCreate(Sender: TObject);
var SL:TStringList;
    launcherdir:string;
begin
// if launcher-settings.json doesn't exist, we use cities.exe
gameexe := 'Cities.exe';
// have a safe default dir
gamedir := ExtractFilePath(Application.ExeName);

if ParamStr(1)= '--gameDir' then gamedir := ParamStr(2)+'\';

// try to open launcher settings json file
if FileExists(gamedir+'launcher-settings.json') then
   begin
   // open file
   SL := TStringList.Create;
   SL.LoadFromFile(gamedir+'launcher-settings.json');

   // create json object
   obj := TJsonObject.Parse(SL.Text) as TJsonObject;;
   // release file
   Sl.Free;

   try
      // set game name
      lblGameTitle.Caption := obj.S['displayName'];
      lblGameTitleShadow.Caption := lblGameTitle.Caption;
      // set launcher title
      Caption := 'Not Paradox Launcher for: '+lblGameTitle.Caption;
      // game exe file
      gameexe := obj.S['exePath'];

      // show version string
      lblVersion.Caption := obj.S['version'];
      lblVersionShadow.Caption := lblVersion.Caption;

      // start the actual game
      StartGame;

   finally
    Obj.Free;
   end; // try

   end //FileExists
else
   begin
   // Paradox games look in %appdata%\Local\Paradox Interactive for a file "launcherpath"
   // this file specifies the location to "bootstrap-v2.exe" that starts the actual launcher
   // we take over this file to trick the games into thinking the launcher is installed
   // save to launcherpath
   SL := TStringList.Create;
   SL.Add( IncludeTrailingPathDelimiter( ExtractFilePath(Application.ExeName) ) );
   // make sure the path exists for launcherpath
   launcherdir := GetLocalAppDataPath + 'Paradox Interactive';
   if not DirectoryExists(launcherdir) then ForceDirectories(launcherdir);
   // save the file
   SL.SaveToFile(launcherdir + '\launcherpath');
   SL.Free;

   SetupTimer.Enabled := true;
   end;

end;

end.
