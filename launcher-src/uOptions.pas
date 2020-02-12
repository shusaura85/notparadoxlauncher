unit uOptions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UCL.TURadioButton, Vcl.StdCtrls, JsonDataObjects,
  UCL.TUText, UCL.TUThemeManager, UCL.TUCheckBox, UCL.TUScrollBox, UCL.TUButton,
  UCL.TUPanel, UCL.TUHyperLink, Vcl.ExtCtrls, UCL.TUEdit, UCL.TUSlider,
  UCL.TUSeparator;

type
  TNotLauncherOptions = class(TForm)
    UScrollBox1: TUScrollBox;
    option_loadlastsave: TUCheckBox;
    UThemeManager1: TUThemeManager;
    UText1: TUText;
    option_noworkshop: TUCheckBox;
    option_disablemods: TUCheckBox;
    UText2: TUText;
    UText3: TUText;
    lblgameoptions: TUText;
    UText5: TUText;
    option_limitFPS_active: TUCheckBox;
    UText6: TUText;
    UText7: TUText;
    option_windowmode_default: TURadioButton;
    option_windowmode_fullscreen: TURadioButton;
    option_windowmode_window: TURadioButton;
    option_windowmode_borderless: TURadioButton;
    option_advanced: TUEdit;
    UText8: TUText;
    UText9: TUText;
    UHyperLink1: TUHyperLink;
    UPanel1: TUPanel;
    btnSaveOptions: TUButton;
    btnCancel: TUButton;
    option_nolog: TUCheckBox;
    UText10: TUText;
    option_limitFPS: TUSlider;
    lblFPS: TUText;
    option_forced3d9: TUCheckBox;
    UText11: TUText;
    option_forceopengl: TUCheckBox;
    UText12: TUText;
    UText13: TUText;
    procedure option_limitFPSChange(Sender: TObject);
    procedure option_limitFPS_activeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSaveOptionsClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    obj: TJsonObject;
    path: string;

    hasSaved : boolean;
  end;

var
  NotLauncherOptions: TNotLauncherOptions;

implementation

{$R *.dfm}

procedure TNotLauncherOptions.FormShow(Sender: TObject);
var tmp:string;
begin
path := IncludeTrailingPathDelimiter( ExtractFilePath(Application.ExeName) );

UScrollBox1.ScrollInView(lblgameoptions);

if FileExists(path+'notlauncher-options.json') then
   begin
   obj := TJsonObject.Create;
   obj.LoadFromFile(path+'notlauncher-options.json');

   if obj.B['continuelastsave'] then option_loadlastsave.State := cbsChecked
                                else option_loadlastsave.State := cbsUnchecked;

   if obj.B['noworkshop'] then option_noworkshop.State := cbsChecked
                          else option_noworkshop.State := cbsUnchecked;

   if obj.B['disablemods'] then option_disablemods.State := cbsChecked
                           else option_disablemods.State := cbsUnchecked;

   if obj.B['nolog'] then option_nolog.State := cbsChecked
                     else option_nolog.State := cbsUnchecked;

   tmp := obj.S['windowmode'];
   if tmp = 'window' then
      option_windowmode_fullscreen.IsChecked := true
   else
   if tmp = 'fullscreen' then
      option_windowmode_fullscreen.IsChecked := true
   else
   if tmp = 'borderless' then
      option_windowmode_borderless.IsChecked := true
   else
      option_windowmode_default.IsChecked := true;

   tmp := obj.S['limitfps'];
   if tmp <> '' then
      begin
      option_limitFPS_active.State := cbsChecked;
      option_limitFPS.Visible := true;
      option_limitFPS.Value := obj.I['limitfps'];
      lblFPS.Visible := true;
      lblFPS.Caption := tmp + ' FPS';
      end
   else
      begin
      option_limitFPS_active.State := cbsUnchecked;
      option_limitFPS.Visible := false;
      lblFPS.Visible := false;
      end;

   if obj.B['forced3d9'] then option_forced3d9.State := cbsChecked
                         else option_forced3d9.State := cbsUnchecked;

   if obj.B['forceopengl'] then option_forceopengl.State := cbsChecked
                           else option_forceopengl.State := cbsUnchecked;

   option_advanced.Edit.Text := obj.S['advanced'];

//   if obj.B['nosteamoverlay'] then option_nosteamoverlay.State := cbsChecked
//                              else option_nosteamoverlay.State := cbsUnchecked;


   obj.Free;

  end;
end;

procedure TNotLauncherOptions.option_limitFPSChange(Sender: TObject);
begin
lblFPS.Caption := IntToStr(option_limitFPS.Value)+' FPS';
end;

procedure TNotLauncherOptions.option_limitFPS_activeClick(Sender: TObject);
begin
if option_limitFPS_active.State = cbsChecked then
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
begin
obj := TJsonObject.Create;

if option_loadlastsave.State = cbsChecked then obj.B['continuelastsave'] := true
                                          else obj.B['continuelastsave'] := false;

if option_noworkshop.State = cbsChecked then obj.B['noworkshop'] := true
                                        else obj.B['noworkshop'] := false;

if option_disablemods.State = cbsChecked then obj.B['disablemods'] := true
                                         else obj.B['disablemods'] := false;

if option_nolog.State = cbsChecked then obj.B['nolog'] := true
                                   else obj.B['nolog'] := false;

if option_windowmode_window.IsChecked then obj.S['windowmode'] := 'window'
else
if option_windowmode_fullscreen.IsChecked then obj.S['windowmode'] := 'fullscreen'
else
if option_windowmode_borderless.IsChecked then obj.S['windowmode'] := 'borderless'
else
   obj.S['windowmode'] := 'default';

if option_limitFPS_active.State = cbsChecked then obj.I['limitfps'] := option_limitFPS.Value;

if option_forced3d9.State = cbsChecked then obj.B['forced3d9'] := true
                                       else obj.B['forced3d9'] := false;

if option_forceopengl.State = cbsChecked then obj.B['forceopengl'] := true
                                         else obj.B['forceopengl'] := false;


obj.S['advanced'] := option_advanced.Edit.Text;

//if option_nosteamoverlay.State = cbsChecked then obj.B['nosteamoverlay'] := true
//                                            else obj.B['nosteamoverlay'] := false;

// save settings to file
obj.SaveToFile(path+'notlauncher-options.json', false, TEncoding.UTF8, true);
obj.Free;

hasSaved  := true;
// close options window
Close;
end;

end.
