unit uOptions;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  fpjson, jsonparser;

type

  { TNotLauncherOptions }

  TNotLauncherOptions = class(TForm)
    btnCancel: TButton;
    btnSaveOptions: TButton;
    Label6: TLabel;
    option_advanced: TEdit;
    lblFPS: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    option_limitFPS_active: TCheckBox;
    option_windowmode: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    option_forceopengl: TCheckBox;
    option_loadlastsave: TCheckBox;
    option_noworkshop: TCheckBox;
    option_disablemods: TCheckBox;
    option_nolog: TCheckBox;
    PageControl1: TPageControl;
    tab1: TTabSheet;
    tab2: TTabSheet;
    tab3: TTabSheet;
    option_limitFPS: TTrackBar;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveOptionsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure option_limitFPSChange(Sender: TObject);
    procedure option_limitFPS_activeClick(Sender: TObject);
  private

  public
    path: string;

    hasSaved:boolean;
  end;

var
  NotLauncherOptions: TNotLauncherOptions;

implementation

{$R *.lfm}

{ TNotLauncherOptions }

procedure TNotLauncherOptions.FormShow(Sender: TObject);
var    MS : TStringList;
    jData : TJSONData;
      obj : TJSONObject;
      tmp : string;
        i : integer;
begin
path := IncludeTrailingPathDelimiter( ExtractFilePath(Application.ExeName) );

PageControl1.ActivePage := tab1;
if FileExists(path+'notlauncher-options.json') then
   begin
   // options file found - load options
   MS := TStringList.Create;
   MS.LoadFromFile(path+'notlauncher-options.json');


   jData := GetJSON( MS.Text );

   // cast as TJSONObject to make access easier
   obj := TJSONObject(jData);

   if obj.Get('continuelastsave', false) then option_loadlastsave.State := cbChecked
                                         else option_loadlastsave.State := cbUnchecked;

   if obj.Get('noworkshop', false) then option_noworkshop.State := cbChecked
                                   else option_noworkshop.State := cbUnchecked;

   if obj.Get('disablemods', false) then option_disablemods.State := cbChecked
                                    else option_disablemods.State := cbUnchecked;

   if obj.Get('nolog', false) then option_nolog.State := cbChecked
                              else option_nolog.State := cbUnchecked;

   tmp := obj.Get('windowmode', '');
   if tmp = 'window' then
      option_windowmode.ItemIndex := 1
   else
   if tmp = 'fullscreen' then
      option_windowmode.ItemIndex := 2
   else
   if tmp = 'borderless' then
      option_windowmode.ItemIndex := 3
   else
   option_windowmode.ItemIndex := 0;

   i := obj.Get('limitfps', 0);
   if i > 0 then
      begin
      option_limitFPS_active.State := cbChecked;
      option_limitFPS.Visible := true;
      option_limitFPS.Position := obj.Get('limitfps', 240);
      lblFPS.Visible := true;
      lblFPS.Caption := IntToStr(i) + ' FPS';
      end
   else
      begin
      option_limitFPS_active.State := cbUnchecked;
      option_limitFPS.Visible := false;
      lblFPS.Visible := false;
      end;

   if obj.Get('forceopengl', false) then option_forceopengl.State := cbChecked
                                    else option_forceopengl.State := cbUnchecked;

   option_advanced.Text := obj.Get('advanced', '');
   end;

end;

procedure TNotLauncherOptions.option_limitFPSChange(Sender: TObject);
begin
lblFPS.Caption := IntToStr(option_limitFPS.Position)+' FPS';
end;

procedure TNotLauncherOptions.option_limitFPS_activeClick(Sender: TObject);
begin
if option_limitFPS_active.State = cbChecked then
   begin
   option_limitFPS.Visible := true;
   lblFPS.Visible := true;
   end
else
   begin
   option_limitFPS.Visible := false;
   lblFPS.Visible := false;
   end;
end;

procedure TNotLauncherOptions.btnCancelClick(Sender: TObject);
begin
// close options window
Close;
end;

procedure TNotLauncherOptions.btnSaveOptionsClick(Sender: TObject);
var    MS : TStringList;
    jData : TJSONData;
      obj : TJSONObject;
      tmp : string;
begin
obj := TJSONObject.Create;

if option_loadlastsave.State = cbChecked then obj.Add('continuelastsave', true)
                                         else obj.Add('continuelastsave', false);

if option_noworkshop.State = cbChecked then obj.Add('noworkshop', true)
                                       else obj.Add('noworkshop', false);

if option_disablemods.State = cbChecked then obj.Add('disablemods', true)
                                        else obj.Add('disablemods', false);

if option_nolog.State = cbChecked then obj.Add('nolog', true)
                                  else obj.Add('nolog', false);

if option_windowmode.ItemIndex = 1 then obj.Add('windowmode', 'window')
else
if option_windowmode.ItemIndex = 2 then obj.Add('windowmode', 'fullscreen')
else
if option_windowmode.ItemIndex = 3 then obj.Add('windowmode', 'borderless')
else
   obj.Add('windowmode', 'default');

if option_limitFPS_active.State = cbChecked then obj.Add('limitfps', option_limitFPS.Position);

if option_forceopengl.State = cbChecked then obj.Add('forceopengl', true)
                                        else obj.Add('forceopengl', false);


obj.Add('advanced', option_advanced.Text);

// save settings to file
MS := TStringList.Create;
MS.Text := obj.AsJSON;
MS.SaveToFile(path+'notlauncher-options.json');
MS.Free;

FreeAndNil(obj);

hasSaved  := true;
// close options window
Close;
end;

end.

