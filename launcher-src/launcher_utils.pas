unit launcher_utils;

interface

uses
   SysUtils, Windows, SHFolder, Registry;

function GetLocalAppDataPath: string;
function GetAppDataPath: string;

function GetSteamPath:string;
function GetSteamOverlayExe:string;

implementation

function GetLocalAppDataPath: string;
var
  Path: array[0..MAX_PATH] of Char;
begin
  if SHGetFolderPath(0, CSIDL_LOCAL_APPDATA, 0, SHGFP_TYPE_CURRENT, Path) = S_OK then
    Result := IncludeTrailingPathDelimiter(Path)
  else
    Result := '';
end;

function GetAppDataPath: string;
var
  Path: array[0..MAX_PATH] of Char;
begin
  if SHGetFolderPath(0, CSIDL_APPDATA, 0, SHGFP_TYPE_CURRENT, Path) = S_OK then
    Result := IncludeTrailingPathDelimiter(Path)
  else
    Result := '';
end;


function GetSteamPath:string;
var reg:TRegistry;
    steamkey, steampath:string;
begin
steamkey := {$IFDEF WIN64}'SOFTWARE\\WOW6432Node\\Valve\\Steam\\'{$ELSE}'SOFTWARE\\Valve\\Steam\\'{$ENDIF};

reg := TRegistry.Create;
reg.RootKey := HKEY_LOCAL_MACHINE;
reg.Access := KEY_READ;

  if (reg.KeyExists(steamkey)) then
    begin
    reg.OpenKeyReadOnly(steamkey);
    steampath := reg.ReadString('InstallPath');
    reg.CloseKey;
    end;

reg.Free;

Result := IncludeTrailingPathDelimiter(steampath);

end;


function GetSteamOverlayExe:string;
var steampath:string;
begin
steampath := GetSteamPath;
if FileExists(steampath+'GameOverlayUI.exe') then
   Result := 'GameOverlayUI.exe'
else
if FileExists(steampath+'SteamOverlayUI.exe') then
   Result := 'SteamOverlayUI.exe'
else
    Result := '';
end;

end.
