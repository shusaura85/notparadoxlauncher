unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Process, fpjson, jsonparser
  {$IFDEF DARWIN}, MacOSAll{$ENDIF};

type

  { TNotLauncherWindow }

  TNotLauncherWindow = class(TForm)
    btnPlay: TButton;
    btnCancelStart: TButton;
    btnSwitchResume: TButton;
    btnOptions: TButton;
    btnSwitchWorkshop: TButton;
    Image1: TImage;
    lblGameTitle: TLabel;
    lblCountdown: TLabel;
    lblGameTitleShadow: TLabel;
    lblCountdownShadow: TLabel;
    ShutdownTimer: TTimer;
    SetupTimer: TTimer;
    StartGameTimer: TTimer;
    procedure btnCancelStartClick(Sender: TObject);
    procedure btnOptionsClick(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure btnSwitchWorkshopClick(Sender: TObject);
    procedure btnSwitchResumeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SetupTimerTimer(Sender: TObject);
    procedure ShutdownTimerTimer(Sender: TObject);
    procedure StartGameTimerTimer(Sender: TObject);
  private

  public

    gamedir : string;
    gameexe : string;
    gamever : string;

    option_loadlastsave: boolean;
    option_noworkshop  : boolean;
    option_disablemods : boolean;
    option_nolog       : boolean;
    option_windowmode  : string;
    option_limitfps    : integer;
    option_forced3d9   : boolean;
    option_forceopengl : boolean;
    option_advanced    : string;



    procedure LoadOptions;
    procedure StartGame;

  end;

var
  NotLauncherWindow: TNotLauncherWindow;

implementation

{$R *.lfm}

uses uOptions;

const LANG_RESUME_LAST_GAME = 'Continue last save game';
      LANG_DO_NOT_RESUME_LAST_GAME = 'Do not continue last save game';

      LANG_DISABLE_STEAM_WORKSHOP = 'Disable Steam Workshop';
      LANG_ENABLE_STEAM_WORKSHOP = 'Enable Steam Workshop';

{ TNotLauncherWindow }

function GetPreferencesFolder: String;
{platform-independend method to search for the location of preferences folder}
const
  kMaxPath = 1024;
var
  {$IFDEF DARWIN}
  theError: OSErr;
  theRef: FSRef;
  {$ENDIF}
  pathBuffer: PChar;
begin
  {$IFDEF DARWIN} {standard method for Mac OS X}
    try
      pathBuffer := Allocmem(kMaxPath);
    except on exception do
      begin
        GetPreferencesFolder := '';
        exit;
      end
    end;
    try
      Fillchar(pathBuffer^, kMaxPath, #0);
      Fillchar(theRef, Sizeof(theRef), #0);
      theError := FSFindFolder(kOnAppropriateDisk, kPreferencesFolderType, kDontCreateFolder, theRef);
      if (pathBuffer <> nil) and (theError = noErr) then
      begin
        theError := FSRefMakePath(theRef, pathBuffer, kMaxPath);
        if theError = noErr then GetPreferencesFolder := UTF8ToAnsi(StrPas(pathBuffer)) + '/';
      end;
    finally
      Freemem(pathBuffer);
    end
  {$ELSE}
    GetPreferencesFolder := GetAppConfigDir(false); {standard method for Linux and Windows}
  {$ENDIF}
end;


procedure TNotLauncherWindow.LoadOptions;
var  path : string;
       MS : TStringList;
    jData : TJSONData;
      obj : TJSONObject;
begin
path := IncludeTrailingPathDelimiter( ExtractFilePath(Application.ExeName) );
if FileExists(path+'notlauncher-options.json') then
   begin
   // options file found - load options
   MS := TStringList.Create;
   MS.LoadFromFile(path+'notlauncher-options.json');


   jData := GetJSON( MS.Text );

   // cast as TJSONObject to make access easier
   obj := TJSONObject(jData);

   option_loadlastsave := obj.Get('continuelastsave', false);
   option_noworkshop   := obj.Get('noworkshop', false);
   option_disablemods  := obj.Get('disablemods', false);
   option_nolog        := obj.Get('nolog', false);

   if obj.Get('windowmode','') = 'window' then option_windowmode := 'windowed'
   else
   if obj.Get('windowmode','') = 'fullscreen' then option_windowmode := 'fullscreen'
   else
   if obj.Get('windowmode','') = 'borderless' then option_windowmode := 'popupwindow'
   else
       option_windowmode := '';

   option_limitfps := obj.Get('limitfps',0);
   option_forced3d9 := obj.Get('forced3d9', false);
   option_forceopengl := obj.Get('foceopengl', false);
   if option_forceopengl then option_forced3d9 := false;

   option_advanced := obj.Get('advanced', '');

   MS.Free;
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
   FileName : String ;
   RunProgram : TProcess;
begin
// prepare vars for createprocess
FileName := gamedir + gameexe; //'Cities.x64';

// set current directory to game directory
SetCurrentDir(gamedir);

RunProgram := TProcess.Create(nil);
RunProgram.Executable:= FileName;
if option_loadlastsave then RunProgram.Parameters.Add('--continuelastsave');
if option_noworkshop       then RunProgram.Parameters.Add('--noWorkshop');
if option_disablemods      then RunProgram.Parameters.Add('--disableMods');
if option_nolog            then RunProgram.Parameters.Add('-nolog');
if option_windowmode <> '' then RunProgram.Parameters.Add('-'+option_windowmode);
if option_limitfps > 0     then
   begin
   RunProgram.Parameters.Add('-limitfps');
   RunProgram.Parameters.Add(IntToStr(option_limitfps));
   end;
if option_forced3d9        then RunProgram.Parameters.Add('-force-d3d9');
if option_forceopengl      then RunProgram.Parameters.Add('-force-opengl');

if option_advanced <> ''   then RunProgram.Parameters.Text := RunProgram.Parameters.Text + ' '+option_advanced;

//RunProgram.Options:= RunProgram.Options + [poUsePipes];
RunProgram.Execute;
RunProgram.Free;

ShutdownTimer.Enabled := true;
end;

procedure TNotLauncherWindow.FormShow(Sender: TObject);
var    SL : TStringList;
    launcherdir:string;
    jData : TJSONData;
      obj : TJSONObject;

begin
// load game options
LoadOptions;
// if launcher-settings.json doesn't exist
gameexe := 'game-main-executable.exe';
// have a safe default dir
gamedir := '/home';
gamever := '0.0.not-found';

if (ParamStr(1)= '--gameDir') then gamedir := IncludeTrailingPathDelimiter(ParamStr(2));

// debug
Caption := gamedir;
//gamedir := '/home/shu/.local/share/Steam/steamapps/common/Cities_Skylines/';

// try to open launcher settings json file
if FileExists(gamedir+'launcher-settings.json') then
   begin
   // open file
   SL := TStringList.Create;
   SL.LoadFromFile(gamedir+'launcher-settings.json');

   // create json object
   jData := GetJSON( SL.Text );

   // cast as TJSONObject to make access easier
   obj := TJSONObject(jData);


   // set game name
  lblGameTitle.Caption := obj.Get('displayName','');
  lblGameTitleShadow.Caption := lblGameTitle.Caption;
  gamever := obj.Get('version', '');
   // set launcher title
  Caption := 'Not Paradox Launcher for: '+lblGameTitle.Caption;
  if gamever <> '' then Caption := Caption + ' ('+gamever+')';
   // game exe file
  gameexe := obj.Get('exePath','');


   btnPlayClick(Sender);


   // release file
   Sl.Free;

   end //FileExists
else
   begin
   SL := TStringList.Create;
   SL.Add( IncludeTrailingPathDelimiter( ExtractFilePath(Application.ExeName) ) );
   // make sure the path exists for launcherpath
   //launcherdir := GetUserDir+'.local/share/Paradox Interactive/';
   launcherdir := GetPreferencesFolder + 'Paradox Interactive/';
   writeln(launcherdir);
   if not DirectoryExists(launcherdir) then ForceDirectories(launcherdir);
   // save the file
   SL.SaveToFile(launcherdir + 'launcherpath');
   SL.Free;

   SetupTimer.Enabled := true;
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

procedure TNotLauncherWindow.btnSwitchWorkshopClick(Sender: TObject);
begin
option_noworkshop := not option_noworkshop;

if option_noworkshop then btnSwitchWorkshop.Caption := LANG_ENABLE_STEAM_WORKSHOP
                     else btnSwitchWorkshop.Caption := LANG_DISABLE_STEAM_WORKSHOP;

btnSwitchWorkshop.Repaint;

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
if NotLauncherOptions.hasSaved then LoadOptions;
end;

procedure TNotLauncherWindow.SetupTimerTimer(Sender: TObject);
begin
SetupTimer.Enabled := false;
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

   btnSwitchResume.Enabled:= false;
   btnCancelStart.Enabled := false;

   // start the actual game
   StartGame;
   end;

end;


end.

