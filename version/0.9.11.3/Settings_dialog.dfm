object FSettings: TFSettings
  Left = 378
  Top = 243
  Width = 570
  Height = 326
  BorderIcons = []
  Caption = 'Settings'
  Color = clBtnFace
  Constraints.MinHeight = 310
  Constraints.MinWidth = 570
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    562
    292)
  PixelsPerInch = 96
  TextHeight = 13
  object Label31: TLabel
    Left = 45
    Top = 200
    Width = 74
    Height = 13
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = 'Large skip time:'
  end
  object pgSettings: TPageControl
    Left = 0
    Top = 0
    Width = 562
    Height = 266
    ActivePage = tabUserData
    Align = alClient
    MultiLine = True
    Style = tsFlatButtons
    TabOrder = 0
    object tabUserData: TTabSheet
      Caption = 'General'
      ImageIndex = 4
      DesignSize = (
        554
        235)
      object Label8: TLabel
        Left = 12
        Top = 6
        Width = 102
        Height = 13
        Alignment = taRightJustify
        Caption = 'User Name (optional):'
      end
      object Label9: TLabel
        Left = 31
        Top = 33
        Width = 83
        Height = 13
        Alignment = taRightJustify
        Caption = 'User ID (random):'
      end
      object Label16: TLabel
        Left = 21
        Top = 60
        Width = 93
        Height = 13
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Frame preview size:'
      end
      object Label17: TLabel
        Left = 148
        Top = 60
        Width = 19
        Height = 13
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'px x'
      end
      object Label22: TLabel
        Left = 12
        Top = 87
        Width = 102
        Height = 13
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Frame preview count:'
      end
      object Label27: TLabel
        Left = 218
        Top = 60
        Width = 114
        Height = 13
        Anchors = [akTop, akRight]
        Caption = '(change requires restart)'
      end
      object Label28: TLabel
        Left = 218
        Top = 87
        Width = 114
        Height = 13
        Anchors = [akTop, akRight]
        Caption = '(change requires restart)'
      end
      object Label32: TLabel
        Left = 42
        Top = 116
        Width = 72
        Height = 13
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Small skip time:'
      end
      object Label33: TLabel
        Left = 41
        Top = 144
        Width = 74
        Height = 13
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Large skip time:'
      end
      object Label34: TLabel
        Left = 148
        Top = 116
        Width = 15
        Height = 14
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 's'
      end
      object Label35: TLabel
        Left = 148
        Top = 144
        Width = 15
        Height = 14
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 's'
      end
      object Label36: TLabel
        Left = 200
        Top = 60
        Width = 11
        Height = 13
        Alignment = taCenter
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'px'
      end
      object Label37: TLabel
        Left = 35
        Top = 173
        Width = 80
        Height = 13
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Network timeout:'
      end
      object Label38: TLabel
        Left = 148
        Top = 173
        Width = 15
        Height = 14
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 's'
      end
      object EUserName: TEdit
        Left = 120
        Top = 3
        Width = 425
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object EUserID: TEdit
        Left = 120
        Top = 30
        Width = 425
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 1
      end
      object EFrameWidth: TEdit
        Left = 120
        Top = 57
        Width = 26
        Height = 21
        Anchors = [akTop, akRight]
        AutoSize = False
        MaxLength = 3
        TabOrder = 2
        Text = '280'
        OnExit = EFrameWidthExit
        OnKeyPress = EProxyPortKeyPress
      end
      object EFrameHeight: TEdit
        Left = 172
        Top = 57
        Width = 26
        Height = 21
        Anchors = [akTop, akRight]
        AutoSize = False
        MaxLength = 3
        TabOrder = 3
        Text = '210'
        OnExit = EFrameWidthExit
        OnKeyPress = EProxyPortKeyPress
      end
      object EFrameCount: TEdit
        Left = 120
        Top = 84
        Width = 26
        Height = 21
        Anchors = [akTop, akRight]
        AutoSize = False
        MaxLength = 2
        TabOrder = 4
        Text = '12'
        OnExit = EFrameWidthExit
        OnKeyPress = EProxyPortKeyPress
      end
      object RCutMode: TRadioGroup
        Left = 364
        Top = 60
        Width = 181
        Height = 61
        Hint = 
          'Cut out: New file is everything except cuts. Crop: NEw file is s' +
          'um of cuts.'
        Anchors = [akTop, akRight]
        Caption = 'Default Cut Mode'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Cut out'
          'Crop')
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
      end
      object edtLargeSkip: TEdit
        Left = 120
        Top = 141
        Width = 26
        Height = 21
        Anchors = [akTop, akRight]
        AutoSize = False
        MaxLength = 2
        TabOrder = 7
        Text = '25'
        OnExit = EFrameWidthExit
        OnKeyPress = EProxyPortKeyPress
      end
      object edtSmallSkip: TEdit
        Left = 120
        Top = 113
        Width = 26
        Height = 21
        Anchors = [akTop, akRight]
        AutoSize = False
        MaxLength = 2
        TabOrder = 6
        Text = '2'
        OnExit = EFrameWidthExit
        OnKeyPress = EProxyPortKeyPress
      end
    end
    object TabSaveMovie: TTabSheet
      Caption = 'Save movie'
      ImageIndex = 1
      DesignSize = (
        554
        235)
      object Label3: TLabel
        Left = 3
        Top = 68
        Width = 193
        Height = 13
        Caption = 'Automatically insert  before file extension:'
        WordWrap = True
      end
      object SaveCutMovieMode: TRadioGroup
        Left = 3
        Top = 3
        Width = 543
        Height = 56
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Save cut movie:'
        Items.Strings = (
          'with source movie'
          'always in this directory:')
        TabOrder = 0
      end
      object MovieNameAlwaysConfirm: TCheckBox
        Left = 3
        Top = 112
        Width = 209
        Height = 13
        Caption = 'Always confirm filename before cutting'
        TabOrder = 5
      end
      object CutMovieSaveDir: TEdit
        Left = 142
        Top = 34
        Width = 362
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        Text = 'CutMovieSaveDir'
      end
      object CutMovieExtension: TEdit
        Left = 200
        Top = 65
        Width = 345
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 3
        Text = 'CutMovieExtension'
      end
      object BCutMovieSaveDir: TButton
        Left = 510
        Top = 34
        Width = 27
        Height = 21
        Anchors = [akTop, akRight]
        Caption = '...'
        TabOrder = 2
        OnClick = BCutMovieSaveDirClick
      end
      object CBUseMovieNameSuggestion: TCheckBox
        Left = 3
        Top = 92
        Width = 313
        Height = 14
        Caption = 'Use movie file name suggested by cutlist (if present)'
        TabOrder = 4
      end
    end
    object TabSaveCutlist: TTabSheet
      Caption = 'Save cutlist'
      ImageIndex = 2
      DesignSize = (
        554
        235)
      object SaveCutlistMode: TRadioGroup
        Left = 3
        Top = 3
        Width = 542
        Height = 59
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Save cutlist:'
        Items.Strings = (
          'with source movie'
          'always in this directory:')
        TabOrder = 0
      end
      object CutlistNameAlwaysConfirm: TCheckBox
        Left = 3
        Top = 68
        Width = 209
        Height = 14
        Caption = 'Always confirm filename before saving'
        TabOrder = 3
      end
      object CutListSaveDir: TEdit
        Left = 142
        Top = 34
        Width = 361
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
      end
      object CutlistAutoSaveBeforeCutting: TCheckBox
        Left = 3
        Top = 88
        Width = 209
        Height = 13
        Caption = 'Auto save before cutting'
        TabOrder = 4
      end
      object BCUtlistSaveDir: TButton
        Left = 509
        Top = 34
        Width = 27
        Height = 21
        Anchors = [akTop, akRight]
        Caption = '...'
        TabOrder = 2
        OnClick = BCUtlistSaveDirClick
      end
    end
    object tabURLs: TTabSheet
      Caption = 'URLs'
      ImageIndex = 3
      Constraints.MinHeight = 210
      DesignSize = (
        554
        235)
      object Label4: TLabel
        Left = 66
        Top = 6
        Width = 62
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cutlist Server'
      end
      object Label5: TLabel
        Left = 27
        Top = 60
        Width = 101
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cut Assistant Info File'
      end
      object Label6: TLabel
        Left = 82
        Top = 87
        Width = 46
        Height = 13
        Alignment = taRightJustify
        Caption = 'Wiki Help'
      end
      object Label7: TLabel
        Left = 3
        Top = 33
        Width = 125
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cutlist Server Upload Form'
      end
      object EURL_Cutlist_Home: TEdit
        Left = 134
        Top = 3
        Width = 411
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object EURL_Info_File: TEdit
        Left = 134
        Top = 57
        Width = 411
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
      end
      object EURL_Cutlist_Upload: TEdit
        Left = 134
        Top = 30
        Width = 411
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
      end
      object EURL_Help: TEdit
        Left = 134
        Top = 84
        Width = 411
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 3
      end
      object GroupBox1: TGroupBox
        Left = 3
        Top = 111
        Width = 542
        Height = 92
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Proxy Prameters'
        TabOrder = 4
        DesignSize = (
          542
          92)
        object Label10: TLabel
          Left = 34
          Top = 22
          Width = 31
          Height = 13
          Alignment = taRightJustify
          Caption = 'Server'
        end
        object Label12: TLabel
          Left = 458
          Top = 22
          Width = 19
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Port'
        end
        object Label13: TLabel
          Left = 329
          Top = 49
          Width = 46
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Password'
        end
        object Label11: TLabel
          Left = 12
          Top = 49
          Width = 53
          Height = 13
          Alignment = taRightJustify
          Caption = 'User Name'
        end
        object Label14: TLabel
          Left = 263
          Top = 72
          Width = 266
          Height = 13
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Warning: Password will be saved in settings in clear text!'
        end
        object EProxyServerName: TEdit
          Left = 71
          Top = 19
          Width = 363
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'Server'
        end
        object EProxyPort: TEdit
          Left = 483
          Top = 18
          Width = 46
          Height = 21
          Anchors = [akTop, akRight]
          TabOrder = 1
          Text = '0'
          OnKeyPress = EProxyPortKeyPress
        end
        object EProxyPassword: TEdit
          Left = 381
          Top = 45
          Width = 148
          Height = 21
          Anchors = [akTop, akRight]
          PasswordChar = '*'
          TabOrder = 3
        end
        object EProxyUserName: TEdit
          Left = 71
          Top = 46
          Width = 230
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
          Text = 'User'
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Info Check'
      ImageIndex = 9
      object GBInfoCheck: TGroupBox
        Left = 3
        Top = 23
        Width = 286
        Height = 106
        TabOrder = 1
        object Label26: TLabel
          Left = 13
          Top = 22
          Width = 209
          Height = 13
          Alignment = taRightJustify
          Caption = 'Days between checking for Infos on server: '
        end
        object CBInfoCheckStable: TCheckBox
          Left = 13
          Top = 65
          Width = 241
          Height = 13
          Caption = 'Check on server for new stable versions'
          TabOrder = 2
        end
        object EChceckInfoInterval: TEdit
          Left = 244
          Top = 19
          Width = 33
          Height = 21
          TabOrder = 0
          Text = '0'
          OnKeyPress = EChceckInfoIntervalKeyPress
        end
        object CBInfoCheckBeta: TCheckBox
          Left = 13
          Top = 84
          Width = 241
          Height = 13
          Caption = 'Check on server for new beta versions'
          TabOrder = 3
        end
        object CBInfoCheckMessages: TCheckBox
          Left = 13
          Top = 46
          Width = 176
          Height = 13
          Caption = 'Check on server for messages'
          TabOrder = 1
        end
      end
      object CBInfoCheckEnabled: TCheckBox
        Left = 3
        Top = 3
        Width = 290
        Height = 14
        Caption = 'Check Infos on Server on Startup'
        TabOrder = 0
      end
    end
    object TabExternalCutApplication: TTabSheet
      Caption = 'External cut application'
      object Label18: TLabel
        Left = 3
        Top = 22
        Width = 144
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cut Windows Media Files with:'
      end
      object Label19: TLabel
        Left = 62
        Top = 49
        Width = 85
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cut AVI Files with:'
      end
      object Label20: TLabel
        Left = 42
        Top = 103
        Width = 105
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cut all other Files with:'
      end
      object Label21: TLabel
        Left = 3
        Top = 0
        Width = 246
        Height = 13
        Caption = 'Please select the Cut Application for each File Type:'
      end
      object Label1: TLabel
        Left = 40
        Top = 76
        Width = 107
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cut MP4 Iso Files with:'
      end
      object Label29: TLabel
        Left = 4
        Top = 132
        Width = 272
        Height = 13
        Alignment = taRightJustify
        Caption = 'Automatically close Cutting window after (use 0 to disable)'
      end
      object Label30: TLabel
        Left = 360
        Top = 132
        Width = 5
        Height = 13
        Caption = 's'
      end
      object CBWmvApp: TComboBox
        Left = 153
        Top = 19
        Width = 200
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        Items.Strings = (
          '')
      end
      object CBAviApp: TComboBox
        Left = 153
        Top = 46
        Width = 200
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        Items.Strings = (
          '')
      end
      object CBOtherApp: TComboBox
        Left = 153
        Top = 100
        Width = 200
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        Items.Strings = (
          '')
      end
      object cbMP4App: TComboBox
        Left = 153
        Top = 73
        Width = 200
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
        Items.Strings = (
          '')
      end
      object spnWaitTimeout: TJvSpinEdit
        Left = 288
        Top = 128
        Width = 65
        Height = 21
        CheckMinValue = True
        Alignment = taRightJustify
        ButtonKind = bkStandard
        Decimal = 0
        Value = 20.000000000000000000
        TabOrder = 4
      end
    end
    object tsSourceFilter: TTabSheet
      Caption = 'Source Filter'
      ImageIndex = 8
      Constraints.MinHeight = 220
      Constraints.MinWidth = 548
      OnShow = tsSourceFilterShow
      DesignSize = (
        554
        235)
      object lblSourceFilter: TLabel
        Left = 3
        Top = 9
        Width = 105
        Height = 13
        Caption = 'Preferred Source Filter'
      end
      object Label2: TLabel
        Left = 63
        Top = 66
        Width = 53
        Height = 13
        Alignment = taRightJustify
        Caption = 'for AVI files'
      end
      object Label23: TLabel
        Left = 41
        Top = 94
        Width = 75
        Height = 13
        Alignment = taRightJustify
        Caption = 'for MP4 Iso files'
      end
      object Label24: TLabel
        Left = 41
        Top = 122
        Width = 75
        Height = 13
        Alignment = taRightJustify
        Caption = 'for all Other files'
      end
      object Label25: TLabel
        Left = 4
        Top = 38
        Width = 112
        Height = 13
        Alignment = taRightJustify
        Caption = 'for Windows Media files'
      end
      object Label15: TLabel
        Left = 52
        Top = 149
        Width = 64
        Height = 13
        Alignment = taRightJustify
        Caption = 'Filter Blacklist'
      end
      object pnlPleaseWait: TPanel
        Left = 122
        Top = 3
        Width = 296
        Height = 25
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Checking Filters. Please Wait...'
        Color = clGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        Visible = False
      end
      object cbxSourceFilterListAVI: TComboBox
        Left = 122
        Top = 63
        Width = 424
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 0
        ParentFont = False
        TabOrder = 0
        Text = '(none)'
      end
      object cbxSourceFilterListMP4: TComboBox
        Left = 122
        Top = 91
        Width = 424
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 0
        ParentFont = False
        TabOrder = 1
        Text = '(none)'
      end
      object cbxSourceFilterListOther: TComboBox
        Left = 122
        Top = 119
        Width = 424
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 0
        ParentFont = False
        TabOrder = 2
        Text = '(none)'
      end
      object btnRefreshFilterList: TButton
        Left = 424
        Top = 6
        Width = 121
        Height = 21
        Anchors = [akTop, akRight]
        Caption = 'Refresh Filter List'
        TabOrder = 3
        OnClick = btnRefreshFilterListClick
      end
      object cbxSourceFilterListWMV: TComboBox
        Left = 122
        Top = 35
        Width = 424
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 0
        ParentFont = False
        TabOrder = 4
        Text = '(none)'
      end
      object lbchkBlackList: TCheckListBox
        Left = 122
        Top = 147
        Width = 423
        Height = 66
        OnClickCheck = lbchkBlackListClickCheck
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 6
      end
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 266
    Width = 562
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      562
      26)
    object Cancel: TButton
      Left = 376
      Top = 0
      Width = 85
      Height = 21
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 0
    end
    object OK: TButton
      Left = 467
      Top = 0
      Width = 85
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 1
    end
  end
  object edtNetTimeout: TEdit
    Left = 124
    Top = 197
    Width = 26
    Height = 21
    Anchors = [akTop, akRight]
    AutoSize = False
    MaxLength = 2
    TabOrder = 2
    Text = '20'
    OnExit = EFrameWidthExit
    OnKeyPress = EProxyPortKeyPress
  end
end
