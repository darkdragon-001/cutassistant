object FSettings: TFSettings
  Left = 378
  Top = 243
  AutoScroll = False
  BorderIcons = []
  Caption = 'Settings'
  ClientHeight = 472
  ClientWidth = 865
  Color = clBtnFace
  Constraints.MinHeight = 310
  Constraints.MinWidth = 570
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Microsoft Sans Serif'
  Font.Pitch = fpVariable
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 144
  TextHeight = 20
  object pgSettings: TPageControl
    Left = 0
    Top = 0
    Width = 865
    Height = 432
    ActivePage = tabUserData
    Align = alClient
    MultiLine = True
    Style = tsFlatButtons
    TabOrder = 0
    object tabUserData: TTabSheet
      Caption = 'General'
      ImageIndex = 4
      DesignSize = (
        857
        394)
      object Label8: TLabel
        Left = 10
        Top = 9
        Width = 165
        Height = 20
        Alignment = taRightJustify
        Caption = 'User Name (optional):'
      end
      object Label9: TLabel
        Left = 39
        Top = 51
        Width = 136
        Height = 20
        Alignment = taRightJustify
        Caption = 'User ID (random):'
      end
      object Label16: TLabel
        Left = 24
        Top = 92
        Width = 151
        Height = 20
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Frame preview size:'
      end
      object Label17: TLabel
        Left = 228
        Top = 92
        Width = 29
        Height = 20
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'px x'
      end
      object Label22: TLabel
        Left = 14
        Top = 134
        Width = 161
        Height = 20
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Frame preview count:'
      end
      object Label27: TLabel
        Left = 335
        Top = 92
        Width = 186
        Height = 20
        Anchors = [akTop, akRight]
        Caption = '(change requires restart)'
      end
      object Label28: TLabel
        Left = 335
        Top = 134
        Width = 186
        Height = 20
        Anchors = [akTop, akRight]
        Caption = '(change requires restart)'
      end
      object Label32: TLabel
        Left = 56
        Top = 178
        Width = 119
        Height = 20
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Small skip time:'
      end
      object Label33: TLabel
        Left = 57
        Top = 222
        Width = 120
        Height = 20
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Large skip time:'
      end
      object Label34: TLabel
        Left = 228
        Top = 178
        Width = 23
        Height = 22
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 's'
      end
      object Label35: TLabel
        Left = 228
        Top = 222
        Width = 23
        Height = 21
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 's'
      end
      object Label36: TLabel
        Left = 308
        Top = 92
        Width = 17
        Height = 20
        Alignment = taCenter
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'px'
      end
      object Label37: TLabel
        Left = 51
        Top = 266
        Width = 126
        Height = 20
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Network timeout:'
      end
      object Label38: TLabel
        Left = 228
        Top = 266
        Width = 23
        Height = 22
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 's'
      end
      object EUserName: TEdit
        Left = 185
        Top = 5
        Width = 653
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object EUserID: TEdit
        Left = 185
        Top = 46
        Width = 653
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 1
      end
      object EFrameWidth: TEdit
        Left = 185
        Top = 88
        Width = 40
        Height = 32
        Anchors = [akTop, akRight]
        AutoSize = False
        MaxLength = 3
        TabOrder = 2
        Text = '180'
        OnExit = EFrameWidthExit
        OnKeyPress = EProxyPortKeyPress
      end
      object EFrameHeight: TEdit
        Left = 265
        Top = 88
        Width = 40
        Height = 32
        Anchors = [akTop, akRight]
        AutoSize = False
        MaxLength = 3
        TabOrder = 3
        Text = '135'
        OnExit = EFrameWidthExit
        OnKeyPress = EProxyPortKeyPress
      end
      object EFrameCount: TEdit
        Left = 185
        Top = 129
        Width = 40
        Height = 33
        Anchors = [akTop, akRight]
        AutoSize = False
        MaxLength = 2
        TabOrder = 4
        Text = '12'
        OnExit = EFrameWidthExit
        OnKeyPress = EProxyPortKeyPress
      end
      object RCutMode: TRadioGroup
        Left = 560
        Top = 92
        Width = 278
        Height = 70
        Hint = 
          'Cut out: New file is everything except cuts. Crop: New file is s' +
          'um of cuts.'
        Anchors = [akTop, akRight]
        Caption = 'Default Cut Mode'
        Columns = 2
        ItemIndex = 1
        Items.Strings = (
          'Cut out'
          'Crop')
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
      end
      object edtLargeSkip: TEdit
        Left = 185
        Top = 217
        Width = 40
        Height = 32
        Anchors = [akTop, akRight]
        AutoSize = False
        MaxLength = 2
        TabOrder = 7
        Text = '25'
        OnExit = EFrameWidthExit
        OnKeyPress = EProxyPortKeyPress
      end
      object edtSmallSkip: TEdit
        Left = 185
        Top = 174
        Width = 40
        Height = 32
        Anchors = [akTop, akRight]
        AutoSize = False
        MaxLength = 2
        TabOrder = 6
        Text = '2'
        OnExit = EFrameWidthExit
        OnKeyPress = EProxyPortKeyPress
      end
      object edtNetTimeout: TEdit
        Left = 185
        Top = 262
        Width = 40
        Height = 32
        Anchors = [akTop, akRight]
        AutoSize = False
        MaxLength = 2
        TabOrder = 8
        Text = '20'
        OnExit = EFrameWidthExit
        OnKeyPress = EProxyPortKeyPress
      end
      object cbAutoMuteOnSeek: TCheckBox
        Left = 337
        Top = 177
        Width = 188
        Height = 26
        Caption = 'Auto mute on seek'
        TabOrder = 9
      end
      object cbAutoMode: TCheckBox
        Left = 337
        Top = 213
        Width = 188
        Height = 26
        Caption = 'Automatic Add Mode'
        TabOrder = 10
      end
    end
    object TabSaveMovie: TTabSheet
      Caption = 'Save movie'
      ImageIndex = 1
      DesignSize = (
        857
        394)
      object Label3: TLabel
        Left = 5
        Top = 105
        Width = 236
        Height = 40
        Caption = 'Automatically insert  before file extension:'
        WordWrap = True
      end
      object SaveCutMovieMode: TRadioGroup
        Left = 5
        Top = 5
        Width = 835
        Height = 86
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Save cut movie:'
        Items.Strings = (
          'with source movie'
          'always in this directory:')
        TabOrder = 0
      end
      object MovieNameAlwaysConfirm: TCheckBox
        Left = 5
        Top = 172
        Width = 507
        Height = 20
        Caption = 'Always confirm filename before cutting'
        TabOrder = 5
      end
      object CutMovieSaveDir: TEdit
        Left = 218
        Top = 52
        Width = 557
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        Text = 'CutMovieSaveDir'
      end
      object CutMovieExtension: TEdit
        Left = 326
        Top = 100
        Width = 512
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 3
        Text = 'CutMovieExtension'
      end
      object BCutMovieSaveDir: TButton
        Left = 785
        Top = 52
        Width = 41
        Height = 33
        Anchors = [akTop, akRight]
        Caption = '...'
        TabOrder = 2
        OnClick = BCutMovieSaveDirClick
      end
      object CBUseMovieNameSuggestion: TCheckBox
        Left = 5
        Top = 142
        Width = 513
        Height = 21
        Caption = 'Use movie file name suggested by cutlist (if present)'
        TabOrder = 4
      end
    end
    object TabSaveCutlist: TTabSheet
      Caption = 'Save cutlist'
      ImageIndex = 2
      DesignSize = (
        857
        394)
      object SaveCutlistMode: TRadioGroup
        Left = 5
        Top = 5
        Width = 833
        Height = 86
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Save cutlist:'
        Items.Strings = (
          'with source movie'
          'always in this directory:')
        TabOrder = 0
      end
      object CutlistNameAlwaysConfirm: TCheckBox
        Left = 5
        Top = 102
        Width = 321
        Height = 21
        Caption = 'Always confirm filename before saving'
        TabOrder = 3
      end
      object CutListSaveDir: TEdit
        Left = 218
        Top = 52
        Width = 556
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
      end
      object CutlistAutoSaveBeforeCutting: TCheckBox
        Left = 5
        Top = 132
        Width = 321
        Height = 20
        Caption = 'Auto save before cutting'
        TabOrder = 4
      end
      object BCUtlistSaveDir: TButton
        Left = 783
        Top = 52
        Width = 42
        Height = 33
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
        857
        394)
      object Label4: TLabel
        Left = 95
        Top = 9
        Width = 102
        Height = 20
        Alignment = taRightJustify
        Caption = 'Cutlist Server'
      end
      object Label5: TLabel
        Left = 32
        Top = 92
        Width = 165
        Height = 20
        Alignment = taRightJustify
        Caption = 'Cut Assistant Info File'
      end
      object Label6: TLabel
        Left = 125
        Top = 134
        Width = 72
        Height = 20
        Alignment = taRightJustify
        Caption = 'Wiki Help'
      end
      object Label7: TLabel
        Left = -6
        Top = 51
        Width = 203
        Height = 20
        Alignment = taRightJustify
        Caption = 'Cutlist Server Upload Form'
      end
      object EURL_Cutlist_Home: TEdit
        Left = 206
        Top = 5
        Width = 632
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object EURL_Info_File: TEdit
        Left = 206
        Top = 88
        Width = 632
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
      end
      object EURL_Cutlist_Upload: TEdit
        Left = 206
        Top = 46
        Width = 632
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
      end
      object EURL_Help: TEdit
        Left = 206
        Top = 129
        Width = 632
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 3
      end
      object GroupBox1: TGroupBox
        Left = 5
        Top = 171
        Width = 833
        Height = 141
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Proxy Prameters'
        TabOrder = 4
        DesignSize = (
          833
          141)
        object Label10: TLabel
          Left = 51
          Top = 34
          Width = 49
          Height = 20
          Alignment = taRightJustify
          Caption = 'Server'
        end
        object Label12: TLabel
          Left = 703
          Top = 34
          Width = 31
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Port'
        end
        object Label13: TLabel
          Left = 503
          Top = 75
          Width = 74
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Password'
        end
        object Label11: TLabel
          Left = 15
          Top = 75
          Width = 85
          Height = 20
          Alignment = taRightJustify
          Caption = 'User Name'
        end
        object Label14: TLabel
          Left = 388
          Top = 111
          Width = 426
          Height = 20
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Warning: Password will be saved in settings in clear text!'
        end
        object EProxyServerName: TEdit
          Left = 109
          Top = 29
          Width = 559
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'Server'
        end
        object EProxyPort: TEdit
          Left = 743
          Top = 28
          Width = 71
          Height = 21
          Anchors = [akTop, akRight]
          TabOrder = 1
          Text = '0'
          OnKeyPress = EProxyPortKeyPress
        end
        object EProxyPassword: TEdit
          Left = 586
          Top = 69
          Width = 228
          Height = 21
          Anchors = [akTop, akRight]
          PasswordChar = '*'
          TabOrder = 3
        end
        object EProxyUserName: TEdit
          Left = 109
          Top = 71
          Width = 354
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
        Left = 5
        Top = 35
        Width = 440
        Height = 163
        TabOrder = 1
        object Label26: TLabel
          Left = 14
          Top = 34
          Width = 328
          Height = 20
          Alignment = taRightJustify
          Caption = 'Days between checking for Infos on server: '
        end
        object CBInfoCheckStable: TCheckBox
          Left = 20
          Top = 100
          Width = 371
          Height = 20
          Caption = 'Check on server for new stable versions'
          TabOrder = 2
        end
        object EChceckInfoInterval: TEdit
          Left = 375
          Top = 29
          Width = 51
          Height = 21
          TabOrder = 0
          Text = '0'
          OnKeyPress = EChceckInfoIntervalKeyPress
        end
        object CBInfoCheckBeta: TCheckBox
          Left = 20
          Top = 129
          Width = 371
          Height = 20
          Caption = 'Check on server for new beta versions'
          TabOrder = 3
        end
        object CBInfoCheckMessages: TCheckBox
          Left = 20
          Top = 71
          Width = 271
          Height = 20
          Caption = 'Check on server for messages'
          TabOrder = 1
        end
      end
      object CBInfoCheckEnabled: TCheckBox
        Left = 5
        Top = 5
        Width = 446
        Height = 21
        Caption = 'Check Infos on Server on Startup'
        TabOrder = 0
      end
    end
    object TabExternalCutApplication: TTabSheet
      Caption = 'External cut application'
      DesignSize = (
        857
        394)
      object Label18: TLabel
        Left = -4
        Top = 37
        Width = 230
        Height = 20
        Alignment = taRightJustify
        Caption = 'Cut Windows Media Files with:'
      end
      object Label19: TLabel
        Left = 88
        Top = 78
        Width = 138
        Height = 20
        Alignment = taRightJustify
        Caption = 'Cut AVI Files with:'
      end
      object Label20: TLabel
        Left = 54
        Top = 205
        Width = 172
        Height = 20
        Alignment = taRightJustify
        Caption = 'Cut all other Files with:'
      end
      object Label21: TLabel
        Left = 5
        Top = 0
        Width = 471
        Height = 22
        Caption = 'Please select the Cut Application for each File Type:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'Microsoft Sans Serif'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 53
        Top = 163
        Width = 173
        Height = 20
        Alignment = taRightJustify
        Caption = 'Cut MP4 Iso Files with:'
      end
      object Label29: TLabel
        Left = -14
        Top = 249
        Width = 439
        Height = 20
        Alignment = taRightJustify
        Caption = 'Automatically close cutting window after (use 0 to disable):'
      end
      object Label30: TLabel
        Left = 554
        Top = 203
        Width = 9
        Height = 20
        Caption = 's'
      end
      object lblSmartRenderingCodec: TLabel
        Left = 483
        Top = 2
        Width = 331
        Height = 22
        Caption = 'For Smart Rendering use this Codec:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'Microsoft Sans Serif'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label31: TLabel
        Left = 56
        Top = 122
        Width = 170
        Height = 20
        Alignment = taRightJustify
        Caption = 'Cut HQ-AVI Files with:'
      end
      object CBWmvApp: TComboBox
        Left = 235
        Top = 32
        Width = 234
        Height = 28
        Style = csDropDownList
        ItemHeight = 20
        TabOrder = 0
        OnChange = cbCutAppChange
        Items.Strings = (
          '')
      end
      object CBAviApp: TComboBox
        Left = 235
        Top = 74
        Width = 234
        Height = 28
        Style = csDropDownList
        ItemHeight = 20
        TabOrder = 1
        OnChange = cbCutAppChange
        Items.Strings = (
          '')
      end
      object CBOtherApp: TComboBox
        Left = 235
        Top = 200
        Width = 234
        Height = 28
        Style = csDropDownList
        ItemHeight = 20
        TabOrder = 3
        OnChange = cbCutAppChange
        Items.Strings = (
          '')
      end
      object cbMP4App: TComboBox
        Left = 235
        Top = 158
        Width = 234
        Height = 28
        Style = csDropDownList
        ItemHeight = 20
        TabOrder = 4
        OnChange = cbCutAppChange
        Items.Strings = (
          '')
      end
      object spnWaitTimeout: TJvSpinEdit
        Left = 483
        Top = 243
        Width = 100
        Height = 25
        CheckMinValue = True
        Alignment = taRightJustify
        ButtonKind = bkStandard
        Decimal = 0
        Value = 20.000000000000000000
        TabOrder = 20
      end
      object cbxCodecWmv: TComboBox
        Left = 483
        Top = 32
        Width = 211
        Height = 28
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 20
        TabOrder = 5
        OnChange = cbxCodecChange
      end
      object btnCodecConfigWmv: TButton
        Left = 703
        Top = 32
        Width = 100
        Height = 33
        Anchors = [akTop, akRight]
        Caption = 'Config'
        TabOrder = 6
        OnClick = btnCodecConfigClick
      end
      object btnCodecAboutWmv: TButton
        Left = 812
        Top = 32
        Width = 39
        Height = 33
        Anchors = [akTop, akRight]
        Caption = '?'
        TabOrder = 7
        OnClick = btnCodecAboutClick
      end
      object cbxCodecAvi: TComboBox
        Left = 483
        Top = 74
        Width = 211
        Height = 28
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 20
        TabOrder = 8
        OnChange = cbxCodecChange
      end
      object btnCodecConfigAvi: TButton
        Left = 703
        Top = 74
        Width = 100
        Height = 32
        Anchors = [akTop, akRight]
        Caption = 'Config'
        TabOrder = 9
        OnClick = btnCodecConfigClick
      end
      object btnCodecAboutAvi: TButton
        Left = 812
        Top = 74
        Width = 39
        Height = 32
        Anchors = [akTop, akRight]
        Caption = '?'
        TabOrder = 10
        OnClick = btnCodecAboutClick
      end
      object cbxCodecMP4: TComboBox
        Left = 483
        Top = 158
        Width = 211
        Height = 28
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 20
        TabOrder = 14
        OnChange = cbxCodecChange
      end
      object btnCodecConfigMP4: TButton
        Left = 703
        Top = 158
        Width = 100
        Height = 33
        Anchors = [akTop, akRight]
        Caption = 'Config'
        TabOrder = 15
        OnClick = btnCodecConfigClick
      end
      object btnCodecAboutMP4: TButton
        Left = 812
        Top = 158
        Width = 39
        Height = 33
        Anchors = [akTop, akRight]
        Caption = '?'
        TabOrder = 16
        OnClick = btnCodecAboutClick
      end
      object cbxCodecOther: TComboBox
        Left = 483
        Top = 200
        Width = 211
        Height = 28
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 20
        TabOrder = 17
        OnChange = cbxCodecChange
      end
      object btnCodecConfigOther: TButton
        Left = 703
        Top = 200
        Width = 100
        Height = 32
        Anchors = [akTop, akRight]
        Caption = 'Config'
        TabOrder = 18
        OnClick = btnCodecConfigClick
      end
      object btnCodecAboutOther: TButton
        Left = 812
        Top = 200
        Width = 39
        Height = 32
        Anchors = [akTop, akRight]
        Caption = '?'
        TabOrder = 19
        OnClick = btnCodecAboutClick
      end
      object CBHQAviApp: TComboBox
        Left = 235
        Top = 117
        Width = 234
        Height = 28
        Style = csDropDownList
        ItemHeight = 20
        TabOrder = 2
        OnChange = cbCutAppChange
        Items.Strings = (
          '')
      end
      object cbxCodecHQAvi: TComboBox
        Left = 483
        Top = 117
        Width = 211
        Height = 28
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 20
        TabOrder = 11
        OnChange = cbxCodecChange
      end
      object btnCodecConfigHQAvi: TButton
        Left = 703
        Top = 115
        Width = 100
        Height = 33
        Anchors = [akTop, akRight]
        Caption = 'Config'
        TabOrder = 12
        OnClick = btnCodecConfigClick
      end
      object btnCodecAboutHQAvi: TButton
        Left = 811
        Top = 115
        Width = 38
        Height = 33
        Anchors = [akTop, akRight]
        Caption = '?'
        TabOrder = 13
        OnClick = btnCodecAboutClick
      end
    end
    object tsSourceFilter: TTabSheet
      Caption = 'Source Filter'
      ImageIndex = 8
      Constraints.MinHeight = 250
      Constraints.MinWidth = 548
      OnShow = tsSourceFilterShow
      DesignSize = (
        857
        394)
      object lblSourceFilter: TLabel
        Left = 5
        Top = 14
        Width = 171
        Height = 20
        Caption = 'Preferred Source Filter'
      end
      object Label2: TLabel
        Left = 91
        Top = 102
        Width = 87
        Height = 20
        Alignment = taRightJustify
        Caption = 'for AVI files'
      end
      object Label23: TLabel
        Left = 56
        Top = 185
        Width = 122
        Height = 20
        Alignment = taRightJustify
        Caption = 'for MP4 Iso files'
      end
      object Label24: TLabel
        Left = 53
        Top = 228
        Width = 125
        Height = 20
        Alignment = taRightJustify
        Caption = 'for all Other files'
      end
      object Label25: TLabel
        Left = -1
        Top = 58
        Width = 179
        Height = 20
        Alignment = taRightJustify
        Caption = 'for Windows Media files'
      end
      object Label15: TLabel
        Left = 71
        Top = 269
        Width = 107
        Height = 20
        Alignment = taRightJustify
        Caption = 'Filter Blacklist'
      end
      object Label39: TLabel
        Left = 60
        Top = 143
        Width = 118
        Height = 20
        Alignment = taRightJustify
        Caption = 'for HQ AVI files'
      end
      object pnlPleaseWait: TPanel
        Left = 188
        Top = 5
        Width = 455
        Height = 38
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Checking Filters. Please Wait...'
        Color = clGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -18
        Font.Name = 'Microsoft Sans Serif'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Visible = False
      end
      object cbxSourceFilterListAVI: TComboBox
        Left = 188
        Top = 97
        Width = 652
        Height = 28
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = []
        ItemHeight = 20
        ParentFont = False
        TabOrder = 3
        Text = '(none)'
        OnChange = cbxSourceFilterListChange
      end
      object cbxSourceFilterListMP4: TComboBox
        Left = 188
        Top = 180
        Width = 652
        Height = 28
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = []
        ItemHeight = 20
        ParentFont = False
        TabOrder = 5
        Text = '(none)'
        OnChange = cbxSourceFilterListChange
      end
      object cbxSourceFilterListOther: TComboBox
        Left = 188
        Top = 223
        Width = 652
        Height = 28
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = []
        ItemHeight = 20
        ParentFont = False
        TabOrder = 6
        Text = '(none)'
        OnChange = cbxSourceFilterListChange
      end
      object btnRefreshFilterList: TButton
        Left = 652
        Top = 9
        Width = 186
        Height = 33
        Anchors = [akTop, akRight]
        Caption = 'Refresh Filter List'
        TabOrder = 1
        OnClick = btnRefreshFilterListClick
      end
      object cbxSourceFilterListWMV: TComboBox
        Left = 188
        Top = 54
        Width = 652
        Height = 28
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = []
        ItemHeight = 20
        ParentFont = False
        TabOrder = 2
        Text = '(none)'
        OnChange = cbxSourceFilterListChange
      end
      object lbchkBlackList: TCheckListBox
        Left = 188
        Top = 266
        Width = 650
        Height = 103
        OnClickCheck = lbchkBlackListClickCheck
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = []
        ItemHeight = 20
        ParentFont = False
        TabOrder = 7
      end
      object cbxSourceFilterListHQAVI: TComboBox
        Left = 188
        Top = 138
        Width = 652
        Height = 28
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = []
        ItemHeight = 20
        ParentFont = False
        TabOrder = 4
        Text = '(none)'
        OnChange = cbxSourceFilterListChange
      end
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 432
    Width = 865
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      865
      40)
    object Cancel: TButton
      Left = 725
      Top = 0
      Width = 130
      Height = 32
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object OK: TButton
      Left = 585
      Top = 0
      Width = 130
      Height = 32
      Anchors = [akTop, akRight]
      Caption = '&OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
  end
end
