unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ShellApi, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, JsonDataObjects, launcher_utils, UCL.TUThemeManager,
  UCL.TUButton, UCL.TUHyperLink, UCL.TUShadow;

type
  TNotLauncherWindow = class(TForm)
    Image1: TImage;
    lblVersion: TLabel;
    lblVersionShadow: TLabel;
    SetupTimer: TTimer;
    lblGameTitle: TLabel;
    lblGameTitleShadow: TLabel;
    ShutdownTimer: TTimer;
    lblCountdown: TLabel;
    lblCountdownShadow: TLabel;
    StartGameTimer: TTimer;
    btnCancelStart: TUButton;
    UThemeManager1: TUThemeManager;
    UHyperLink1: TUHyperLink;
    btnPlay: TUButton;
    btnOptions: TUButton;
    btnSwitchResume: TUButton;
    btnSwitchWorkshop: TUButton;
    procedure FormShow(Sender: TObject);
    procedure SetupTimerTimer(Sender: TObject);
    procedure ShutdownTimerTimer(Sender: TObject);
    procedure StartGameTimerTimer(Sender: TObject);
    procedure btnCancelStartClick(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure btnOptionsClick(Sender: TObject);
    procedure btnSwitchResumeClick(Sender: TObject);
    procedure btnSwitchWorkshopClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    gamedir : string;
    gameexe : string;

    option_loadlastsave: boolean;
    option_noworkshop  : boolean;
    option_disablemods : boolean;
    option_nolog       : boolean;
    option_windowmode  : string;
    option_limitfps    : integer;
    option_forced3d9   : boolean;
    option_forceopengl : boolean;
    option_advanced    : string;
//    option_nosteamoverlay : boolean;


    obj: TJsonObject;


    procedure LoadOptions;
    procedure StartGame;
  end;

var
  NotLauncherWindow: TNotLauncherWindow;

implementation

{$R *.dfm}

uses uOptions;

const LANG_RESUME_LAST_GAME = 'Will not continue last save game';
      LANG_DO_NOT_RESUME_LAST_GAME = 'Will continue last save game';

      LANG_DISABLE_STEAM_WORKSHOP = 'Disable Steam Workshop';
      LANG_ENABLE_STEAM_WORKSHOP = 'Enable Steam Workshop';

procedure TNotLauncherWindow.SetupTimerTimer(Sender: TObject);
begin
SetupTimer.Enabled := false;
//ShowMessage('Not Paradox Launcher is setup! Start the game from Steam as usual!');
//Close;
   lblCountdown.Visible := true;
   lblCountdownShadow.Visible := true;

   lblCountdown.Caption := 'Not Paradox Launcher is setup!'#13#10'Start the game from Steam as usual!';
   lblCountdownShadow.Caption := lblCountdown.Caption;
end;

procedure TNotLauncherWindow.ShutdownTimerTimer(Sender: TObject);
begin
// close the launcher
Close;
end;


procedure TNotLauncherWindow.LoadOptions;
var path:string;
begin
path := IncludeTrailingPathDelimiter( ExtractFilePath(Application.ExeName) );
if FileExists(path+'notlauncher-options.json') then
   begin
   // options file found - load options
   obj := TJsonObject.Create;
   obj.LoadFromFile(path+'notlauncher-options.json');

   option_loadlastsave := obj.B['continuelastsave'];
   option_noworkshop   := obj.B['noworkshop'];
   option_disablemods  := obj.B['disablemods'];
   option_nolog        := obj.B['nolog'];

   if obj.S['windowmode'] = 'window' then option_windowmode := 'windowed'
   else
   if obj.S['windowmode'] = 'fullscreen' then option_windowmode := 'fullscreen'
   else
   if obj.S['windowmode'] = 'borderless' then option_windowmode := 'popupwindow'
   else
       option_windowmode := '';

   option_limitfps := obj.I['limitfps'];
   option_forced3d9 := obj.B['forced3d9'];
   option_forceopengl := obj.B['foceopengl'];
   if option_forceopengl then option_forced3d9 := false;

   option_advanced := obj.S['advanced'];

//   option_nosteamoverlay := obj.B['nosteamoverlay'];

   obj.Free;
  end
else
  begin
  // options file doesn't exist - set default values
  option_loadlastsave:= false;
  option_noworkshop  := false;
  option_disablemods := false;
  option_nolog       := false;
  option_windowmode  := '';
  option_limitfps    := 0;
  option_forced3d9   := false;
  option_forceopengl := false;
  option_advanced    := '';
//  option_nosteamoverlay := false;
  end;

end;

procedure TNotLauncherWindow.StartGame;
var
 SI : TStartupInfo;
 PI : TProcessInformation ;
 FileName, params : String ;
 pid:cardinal;
 steampath, steamoverlay:string;
begin

// prepare vars for createprocess
FileName := gamedir + gameexe; //'Cities.exe';

params := '';
if option_loadlastsave     then params := params + ' --continuelastsave';
if option_noworkshop       then params := params + ' --noWorkshop';
if option_disablemods      then params := params + ' --disableMods';
if option_nolog            then params := params + ' -nolog';
if option_windowmode <> '' then params := params + ' -'+option_windowmode;
if option_limitfps > 0     then params := params + ' -limitfps '+IntToStr(option_limitfps);
if option_forced3d9        then params := params + ' -force-d3d9';
if option_forceopengl      then params := params + ' -force-opengl';
if option_advanced <> ''   then params := params + ' '+option_advanced;


ZeroMemory(@SI,sizeof(SI));
SI.cb := sizeof(SI);

// start the game
if params <> '' then CreateProcess(nil,PChar('"'+FileName+'" '+params),nil,nil,False,0,nil,PChar(gamedir),SI,PI)
                else CreateProcess(PChar(FileName),nil,nil,nil,False,0,nil,PChar(gamedir),SI,PI);
// get game pid
pid := PI.dwProcessId;

{
if not option_nosteamoverlay then
   begin
   // start steam overlay
   steampath := GetSteamPath;
   steamoverlay := GetSteamOverlayExe;

   // run steam overlay
   // SteamOverlayUI.exe -pid gamepid -manuallyclearframes 0
   ShellExecute(0,'open',PChar(steamoverlay),PChar('-pid '+IntToStr(pid)+' -manuallyclearframes 0'),PChar(steampath), SW_SHOWNORMAL);
   end;
}

ShutdownTimer.Enabled := true;
end;



procedure TNotLauncherWindow.StartGameTimerTimer(Sender: TObject);
begin
if StartGameTimer.Tag > 0 then
   begin
   lblCountdown.Caption := 'Starting game in '+IntTostr(StartGameTimer.Tag)+'...';
   if option_loadlastsave then lblCountdown.Caption := lblCountdown.Caption + #13#10 + 'Autoloading last save game!';
   lblCountdownShadow.Caption := lblCountdown.Caption;

   StartGameTimer.Tag := StartGameTimer.Tag - 1;
   end
else
   begin
   // disable countdown timer
   StartGameTimer.Enabled := false;

   // starting game
   lblCountdown.Caption := 'Starting game...';
   lblCountdownShadow.Caption := lblCountdown.Caption;

   // start the actual game
   StartGame;
   end;

end;

procedure TNotLauncherWindow.btnCancelStartClick(Sender: TObject);
begin
StartGameTimer.Enabled := false;
StartGameTimer.Tag := 4;

lblCountdown.Caption := ' ';
lblCountdownShadow.Caption := lblCountdown.Caption;

btnCancelStart.Visible := false;
btnSwitchResume.Visible := false;
btnPlay.Visible := true;
end;

procedure TNotLauncherWindow.btnOptionsClick(Sender: TObject);
begin
// stop game load if active
if StartGameTimer.Enabled then btnCancelStartClick(Sender);
// show options window
NotLauncherOptions.hasSaved := false;
NotLauncherOptions.ShowModal;
if NotLauncherOptions.hasSaved then
   begin
   LoadOptions;
   // refresh enable/disable steam workshop button
   if option_noworkshop then btnSwitchWorkshop.Caption := LANG_ENABLE_STEAM_WORKSHOP
                        else btnSwitchWorkshop.Caption := LANG_DISABLE_STEAM_WORKSHOP;

   if btnSwitchWorkshop.Visible then btnSwitchWorkshop.Repaint;
   end;

end;

procedure TNotLauncherWindow.btnPlayClick(Sender: TObject);
begin

StartGameTimer.Tag := 4; //5 second timer, 0 based
StartGameTimer.Enabled := true;

lblCountdown.Caption := 'Starting game in '+IntTostr(StartGameTimer.Tag+1)+'...';
if option_loadlastsave then lblCountdown.Caption := lblCountdown.Caption + #13#10 + 'Autoloading last save game!';

lblCountdownShadow.Caption := lblCountdown.Caption;
lblCountdown.Visible := true;
lblCountdownShadow.Visible := true;

btnCancelStart.Visible := true;
btnSwitchResume.Visible := true;
if option_loadlastsave then btnSwitchResume.Caption := LANG_DO_NOT_RESUME_LAST_GAME
                       else btnSwitchResume.Caption := LANG_RESUME_LAST_GAME;

btnSwitchWorkshop.Visible := true;
if option_noworkshop then btnSwitchWorkshop.Caption := LANG_ENABLE_STEAM_WORKSHOP
                     else btnSwitchWorkshop.Caption := LANG_DISABLE_STEAM_WORKSHOP;

btnPlay.Visible := false;
end;

procedure TNotLauncherWindow.btnSwitchResumeClick(Sender: TObject);
begin
option_loadlastsave := not option_loadlastsave;

if option_loadlastsave then btnSwitchResume.Caption := LANG_DO_NOT_RESUME_LAST_GAME
                       else btnSwitchResume.Caption := LANG_RESUME_LAST_GAME;

btnSwitchResume.Repaint;

lblCountdown.Caption := 'Starting game in '+IntTostr(StartGameTimer.Tag+1)+'...';
if option_loadlastsave then lblCountdown.Caption := lblCountdown.Caption + #13#10 + 'Autoloading last save game!';
lblCountdownShadow.Caption := lblCountdown.Caption;

end;

procedure TNotLauncherWindow.btnSwitchWorkshopClick(Sender: TObject);
begin
option_noworkshop := not option_noworkshop;

if option_noworkshop then btnSwitchWorkshop.Caption := LANG_ENABLE_STEAM_WORKSHOP
                     else btnSwitchWorkshop.Caption := LANG_DISABLE_STEAM_WORKSHOP;

btnSwitchWorkshop.Repaint;
end;

procedure TNotLauncherWindow.FormShow(Sender: TObject);
var SL:TStringList;
    launcherdir:string;
begin
// load game options
LoadOptions;
// if launcher-settings.json doesn't exist, we use cities.exe
gameexe := 'game-main-executable.exe';
// have a safe default dir
gamedir := GetAppDataPath();

if ParamStr(1)= '--gameDir' then gamedir := ParamStr(2)+'\';

// try to open launcher settings json file
if FileExists(gamedir+'launcher-settings.json') then
   begin
   // open file
   SL := TStringList.Create;
   SL.LoadFromFile(gamedir+'launcher-settings.json');

   // create json object
   obj := TJsonObject.Parse(SL.Text) as TJsonObject;
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


      btnPlayClick(Sender);
      {
      StartGameTimer.Tag := 4; //5 second timer, 0 based
      StartGameTimer.Enabled := true;

      lblCountdown.Caption := 'Starting game in '+IntTostr(StartGameTimer.Tag+1)+'...';
      lblCountdownShadow.Caption := lblCountdown.Caption;
      lblCountdown.Visible := true;
      lblCountdownShadow.Visible := true;
      }

   finally
    Obj.Free;
   end; // try

   end //FileExists
else
   begin
   // Paradox games look in %appdata%\Local\Paradox Interactive for a file "launcherpath"
   // this file specifies the location to "bootstraper-v2.exe" that starts the actual launcher
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
