object NotLauncherOptions: TNotLauncherOptions
  Left = 0
  Top = 0
  ActiveControl = btnSaveOptions
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Options'
  ClientHeight = 450
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object UScrollBox1: TUScrollBox
    Left = 0
    Top = 0
    Width = 600
    Height = 400
    HorzScrollBar.Tracking = True
    VertScrollBar.Position = 657
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Align = alClient
    Color = 15132390
    ParentColor = False
    TabOrder = 0
    ThemeManager = UThemeManager1
    AniSet.AniKind = akOut
    AniSet.AniFunctionKind = afkCubic
    AniSet.DelayStartTime = 0
    AniSet.Duration = 120
    AniSet.Step = 10
    BackColor.Enabled = False
    BackColor.Color = clBlack
    BackColor.LightColor = 15132390
    BackColor.DarkColor = 2039583
    ExplicitHeight = 607
    object option_loadlastsave: TUCheckBox
      Left = 16
      Top = -601
      Width = 561
      ThemeManager = UThemeManager1
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      Caption = 'Continue Last Save Game (--continuelastsave)'
    end
    object UText1: TUText
      Left = 48
      Top = -565
      Width = 532
      Height = 33
      AutoSize = False
      Caption = 
        'This option when active will skip the main menu of the game and ' +
        'automatatically load the last save game you played. Disable this' +
        ' option if you want to load the main menu.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 6710886
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ThemeManager = UThemeManager1
      TextKind = tkDescription
    end
    object option_noworkshop: TUCheckBox
      Left = 16
      Top = -513
      Width = 561
      Hint = '--noWorkshop'
      ThemeManager = UThemeManager1
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      Caption = 'Disable Steam Workshop (--noWorkshop)'
    end
    object option_disablemods: TUCheckBox
      Left = 16
      Top = -425
      Width = 561
      ThemeManager = UThemeManager1
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      Caption = 'Disable Mods (--disableMods)'
    end
    object UText2: TUText
      Left = 48
      Top = -477
      Width = 529
      Height = 33
      AutoSize = False
      Caption = 
        'This option when active will disable Steam Workshop. This includ' +
        'es all assets and mods that are downloaded from Steam Workshop.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 6710886
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ThemeManager = UThemeManager1
      TextKind = tkDescription
    end
    object UText3: TUText
      Left = 48
      Top = -389
      Width = 532
      Height = 33
      AutoSize = False
      Caption = 
        'This option when active will disable all mods loaded in the game' +
        '. Either from Steam Workshop or from preinstalled mods (such as ' +
        'unlimited money mod) and manually installed mods.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 6710886
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ThemeManager = UThemeManager1
      TextKind = tkDescription
    end
    object lblgameoptions: TUText
      Left = 16
      Top = -647
      Width = 167
      Height = 28
      Caption = 'Game Play Options'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ThemeManager = UThemeManager1
      TextKind = tkHeading
    end
    object UText5: TUText
      Left = 16
      Top = -134
      Width = 151
      Height = 28
      Caption = 'Graphics Options'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ThemeManager = UThemeManager1
      TextKind = tkHeading
    end
    object option_limitFPS_active: TUCheckBox
      Left = 16
      Top = -97
      Width = 130
      ThemeManager = UThemeManager1
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      Caption = 'Limit FPS (-limitfps)'
      OnClick = option_limitFPS_activeClick
    end
    object UText6: TUText
      Left = 48
      Top = -61
      Width = 532
      Height = 53
      AutoSize = False
      Caption = 
        'This option is useful if your graphics card is overheating, espe' +
        'cially if you are using a laptop in summer months. It might also' +
        ' be useful if your monitor can'#39't handle higher frame rates.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 6710886
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ThemeManager = UThemeManager1
      TextKind = tkDescription
    end
    object UText7: TUText
      Left = 16
      Top = -254
      Width = 130
      Height = 28
      Caption = 'Window Mode'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ThemeManager = UThemeManager1
      TextKind = tkHeading
    end
    object option_windowmode_default: TURadioButton
      Left = 16
      Top = -220
      Width = 257
      ThemeManager = UThemeManager1
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      IsChecked = True
      Group = '1'
      CustomActiveColor = 14120960
      Caption = 'Use default game mode'
    end
    object option_windowmode_window: TURadioButton
      Left = 288
      Top = -220
      Width = 273
      Hint = '-windowed'
      ThemeManager = UThemeManager1
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      Group = '1'
      CustomActiveColor = 14120960
      Caption = 'Run game in window (-windowed)'
    end
    object option_windowmode_borderless: TURadioButton
      Left = 288
      Top = -184
      Width = 273
      Hint = '-popupwindow'
      ThemeManager = UThemeManager1
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      Group = '1'
      CustomActiveColor = 14120960
      Caption = 'Run game in borderless window (-popupwindow)'
    end
    object UText8: TUText
      Left = 16
      Top = 181
      Width = 87
      Height = 28
      Caption = 'Advanced'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ThemeManager = UThemeManager1
      TextKind = tkHeading
    end
    object UText9: TUText
      Left = 16
      Top = 278
      Width = 561
      Height = 45
      AutoSize = False
      Caption = 
        'Add here any other command line arguments that you want to use t' +
        'hat are not available with the options above. If you want to fin' +
        'd out more about the parameters supported by Cities: Skylines, u' +
        'se the link bellow to see available arguments.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 6710886
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ThemeManager = UThemeManager1
      TextKind = tkDescription
    end
    object UHyperLink1: TUHyperLink
      Left = 16
      Top = 333
      Width = 151
      Height = 13
      Caption = 'Launch Options - Cities Skylines'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 14120960
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      CustomTextColors.None = 14120960
      CustomTextColors.Hover = clGray
      CustomTextColors.Press = clMedGray
      CustomTextColors.Disabled = clMedGray
      CustomTextColors.Focused = 14120960
      URL = 'https://steamcommunity.com/sharedfiles/filedetails/?id=466981085'
    end
    object option_windowmode_fullscreen: TURadioButton
      Left = 16
      Top = -184
      Width = 257
      Hint = '-fullscreen'
      ThemeManager = UThemeManager1
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      Group = '1'
      CustomActiveColor = 14120960
      Caption = 'Run game in full screen (-fullscreen)'
    end
    object option_nolog: TUCheckBox
      Left = 16
      Top = -345
      Width = 561
      Hint = '-nolog'
      ThemeManager = UThemeManager1
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      Caption = 'Disable Game Log (-nolog)'
    end
    object UText10: TUText
      Left = 48
      Top = -309
      Width = 529
      Height = 49
      AutoSize = False
      Caption = 
        'This option when active will disable the game logs. If active it' +
        ' can reduce the load times but at the same time you won'#39't know w' +
        'hat errors and why they occured (do not use if you are testing n' +
        'ew mods or assets)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 6710886
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ThemeManager = UThemeManager1
      TextKind = tkDescription
    end
    object option_limitFPS: TUSlider
      Left = 160
      Top = -97
      Width = 297
      Height = 30
      ThemeManager = UThemeManager1
      Min = 20
      Max = 240
      Value = 240
      OnChange = option_limitFPSChange
      Visible = False
    end
    object lblFPS: TUText
      Left = 480
      Top = -89
      Width = 45
      Height = 17
      Caption = '240 FPS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Visible = False
      ThemeManager = UThemeManager1
    end
    object option_forced3d9: TUCheckBox
      Left = 16
      Top = -25
      Width = 561
      Hint = '-force-d3d9'
      ThemeManager = UThemeManager1
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      Caption = 'Force Direct3D 9 (-force-d3d9)'
    end
    object UText11: TUText
      Left = 48
      Top = 11
      Width = 529
      Height = 49
      AutoSize = False
      Caption = 
        'This option can resolve graphics issues at the expense of some g' +
        'raphics quality and frame rate. Before using it, try and upgrade' +
        ' your graphics card drivers to the latest stable release form th' +
        'e manufacturer website as that will often fix the problem at sou' +
        'rce.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 6710886
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ThemeManager = UThemeManager1
      TextKind = tkDescription
    end
    object option_forceopengl: TUCheckBox
      Left = 16
      Top = 63
      Width = 561
      Hint = '-force-opengl'
      ThemeManager = UThemeManager1
      IconFont.Charset = DEFAULT_CHARSET
      IconFont.Color = clWindowText
      IconFont.Height = -20
      IconFont.Name = 'Segoe MDL2 Assets'
      IconFont.Style = []
      Caption = 'Force OpenGL (-force-opengl)'
    end
    object UText12: TUText
      Left = 48
      Top = 99
      Width = 529
      Height = 49
      AutoSize = False
      Caption = 
        'This option will force the game to run using the OpenGL backend ' +
        'instead of DirectX. Note that this can cause problems with the U' +
        'I of some mods and possibly also cause issues with some of the m' +
        'ore elaborate workshop assets (This option will disable "Force D' +
        'irect3D 9" if enabled)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 6710886
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ThemeManager = UThemeManager1
      TextKind = tkDescription
    end
    object UText13: TUText
      Left = 48
      Top = 352
      Width = 529
      Height = 48
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 6710886
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ThemeManager = UThemeManager1
      TextKind = tkDescription
    end
    object option_advanced: TUEdit
      Left = 16
      Top = 234
      Width = 561
      Caption = 'option_advanced'
      TabOrder = 1
      ThemeManager = UThemeManager1
      Edit.Left = 5
      Edit.Top = 5
      Edit.Width = 552
      Edit.ParentColor = False
      Edit.ParentFont = False
    end
  end
  object UPanel1: TUPanel
    Left = 0
    Top = 400
    Width = 600
    Height = 50
    Align = alBottom
    Color = 15132390
    DoubleBuffered = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 1
    ThemeManager = UThemeManager1
    BackColor.Enabled = False
    BackColor.Color = clBlack
    BackColor.LightColor = 15132390
    BackColor.DarkColor = 2039583
    ExplicitTop = 607
    DesignSize = (
      600
      50)
    object btnSaveOptions: TUButton
      Left = 442
      Top = 10
      ThemeManager = UThemeManager1
      CustomBorderColors.None = 15921906
      CustomBorderColors.Hover = 15132390
      CustomBorderColors.Press = 13421772
      CustomBorderColors.Disabled = 15921906
      CustomBorderColors.Focused = 15921906
      CustomBackColors.None = 15921906
      CustomBackColors.Hover = 15132390
      CustomBackColors.Press = 13421772
      CustomBackColors.Disabled = 15921906
      CustomBackColors.Focused = 15921906
      CustomTextColors.Disabled = clGray
      Highlight = True
      Anchors = [akTop, akRight]
      Caption = 'Save options'
      OnClick = btnSaveOptionsClick
    end
    object btnCancel: TUButton
      Left = 16
      Top = 10
      ThemeManager = UThemeManager1
      CustomBorderColors.None = 15921906
      CustomBorderColors.Hover = 15132390
      CustomBorderColors.Press = 13421772
      CustomBorderColors.Disabled = 15921906
      CustomBorderColors.Focused = 15921906
      CustomBackColors.None = 15921906
      CustomBackColors.Hover = 15132390
      CustomBackColors.Press = 13421772
      CustomBackColors.Disabled = 15921906
      CustomBackColors.Focused = 15921906
      CustomTextColors.Disabled = clGray
      Caption = 'Cancel'
      OnClick = btnCancelClick
    end
  end
  object UThemeManager1: TUThemeManager
    Left = 536
    Top = 16
  end
end
