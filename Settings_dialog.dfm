object FSettings: TFSettings
  Left = 1414
  Top = 101
  Width = 649
  Height = 408
  BorderIcons = []
  Caption = 'Settings'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    641
    376)
  PixelsPerInch = 120
  TextHeight = 16
  object Cancel: TButton
    Left = 480
    Top = 344
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 0
  end
  object OK: TButton
    Left = 560
    Top = 344
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 641
    Height = 337
    ActivePage = TabSheet2
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 2
    object TabSheet2: TTabSheet
      Caption = 'User Data'
      ImageIndex = 4
      object Label8: TLabel
        Left = 16
        Top = 24
        Width = 128
        Height = 16
        Caption = 'User Name (optional)'
      end
      object Label9: TLabel
        Left = 40
        Top = 64
        Width = 102
        Height = 16
        Caption = 'User ID (random)'
      end
      object EUserName: TEdit
        Left = 152
        Top = 16
        Width = 297
        Height = 24
        TabOrder = 0
      end
      object EUserID: TEdit
        Left = 152
        Top = 56
        Width = 297
        Height = 24
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 1
      end
    end
    object TabSaveMovie: TTabSheet
      Caption = 'Save movie'
      ImageIndex = 1
      object Label3: TLabel
        Left = 16
        Top = 96
        Width = 122
        Height = 32
        Caption = 'Automatically insert  before file extension:'
        WordWrap = True
      end
      object SaveCutMovieMode: TRadioGroup
        Left = 8
        Top = 8
        Width = 609
        Height = 73
        Caption = 'Save cut movie:'
        Items.Strings = (
          'with source movie'
          'always in this directory:')
        TabOrder = 0
      end
      object MovieNameAlwaysConfirm: TCheckBox
        Left = 16
        Top = 168
        Width = 257
        Height = 17
        Caption = 'Always confirm filename before cutting'
        TabOrder = 1
      end
      object CutMovieSaveDir: TEdit
        Left = 184
        Top = 48
        Width = 385
        Height = 24
        TabOrder = 2
        Text = 'CutMovieSaveDir'
      end
      object CutMovieExtension: TEdit
        Left = 144
        Top = 104
        Width = 121
        Height = 24
        TabOrder = 3
        Text = 'CutMovieExtension'
      end
      object BCutMovieSaveDir: TButton
        Left = 576
        Top = 48
        Width = 33
        Height = 25
        Caption = '...'
        TabOrder = 4
        OnClick = BCutMovieSaveDirClick
      end
      object CBUseMovieNameSuggestion: TCheckBox
        Left = 16
        Top = 144
        Width = 385
        Height = 17
        Caption = 'Use movie file name suggested by cutlist (if present)'
        TabOrder = 5
      end
    end
    object TabSaveCutlist: TTabSheet
      Caption = 'Save cutlist'
      ImageIndex = 2
      object SaveCutlistMode: TRadioGroup
        Left = 8
        Top = 8
        Width = 609
        Height = 73
        Caption = 'Save cutlist:'
        Items.Strings = (
          'with source movie'
          'always in this directory:')
        TabOrder = 0
      end
      object CutlistNameAlwaysConfirm: TCheckBox
        Left = 16
        Top = 96
        Width = 257
        Height = 17
        Caption = 'Always confirm filename before saving'
        TabOrder = 1
      end
      object CutListSaveDir: TEdit
        Left = 184
        Top = 48
        Width = 385
        Height = 24
        TabOrder = 2
      end
      object CutlistAutoSaveBeforeCutting: TCheckBox
        Left = 16
        Top = 120
        Width = 257
        Height = 17
        Caption = 'Auto save before cutting'
        TabOrder = 3
      end
      object BCUtlistSaveDir: TButton
        Left = 576
        Top = 48
        Width = 33
        Height = 25
        Caption = '...'
        TabOrder = 4
        OnClick = BCUtlistSaveDirClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'URLs'
      ImageIndex = 3
      object Label4: TLabel
        Left = 100
        Top = 16
        Width = 78
        Height = 16
        Alignment = taRightJustify
        Caption = 'Cutlist Server'
      end
      object Label5: TLabel
        Left = 53
        Top = 96
        Width = 125
        Height = 16
        Alignment = taRightJustify
        Caption = 'Cut Assistant Info File'
      end
      object Label6: TLabel
        Left = 120
        Top = 136
        Width = 58
        Height = 16
        Alignment = taRightJustify
        Caption = 'Wiki Help'
      end
      object Label7: TLabel
        Left = 18
        Top = 56
        Width = 160
        Height = 16
        Alignment = taRightJustify
        Caption = 'Cutlist Server Upload Form'
      end
      object EURL_Cutlist_Home: TEdit
        Left = 184
        Top = 8
        Width = 425
        Height = 24
        TabOrder = 0
      end
      object EURL_Info_File: TEdit
        Left = 184
        Top = 88
        Width = 425
        Height = 24
        TabOrder = 1
      end
      object EURL_Cutlist_Upload: TEdit
        Left = 184
        Top = 48
        Width = 425
        Height = 24
        TabOrder = 2
      end
      object EURL_Help: TEdit
        Left = 184
        Top = 128
        Width = 425
        Height = 24
        TabOrder = 3
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 176
        Width = 609
        Height = 113
        Caption = 'Proxy Prameters'
        TabOrder = 4
        object Label10: TLabel
          Left = 130
          Top = 25
          Width = 40
          Height = 16
          Alignment = taRightJustify
          Caption = 'Server'
        end
        object Label12: TLabel
          Left = 514
          Top = 25
          Width = 24
          Height = 16
          Alignment = taRightJustify
          Caption = 'Port'
        end
        object Label13: TLabel
          Left = 382
          Top = 65
          Width = 60
          Height = 16
          Alignment = taRightJustify
          Caption = 'Password'
        end
        object Label11: TLabel
          Left = 101
          Top = 65
          Width = 69
          Height = 16
          Alignment = taRightJustify
          Caption = 'User Name'
        end
        object Label14: TLabel
          Left = 270
          Top = 88
          Width = 331
          Height = 16
          Alignment = taRightJustify
          Caption = 'Warning: Password will be saved in settings in clear text!'
        end
        object EProxyServerName: TEdit
          Left = 176
          Top = 17
          Width = 329
          Height = 24
          TabOrder = 0
        end
        object EProxyPort: TEdit
          Left = 544
          Top = 17
          Width = 57
          Height = 24
          TabOrder = 1
          Text = '0'
          OnKeyPress = EProxyPortKeyPress
        end
        object EProxyPassword: TEdit
          Left = 448
          Top = 57
          Width = 153
          Height = 24
          TabOrder = 2
        end
        object EProxyUserName: TEdit
          Left = 176
          Top = 57
          Width = 185
          Height = 24
          TabOrder = 3
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Info Check'
      ImageIndex = 9
      object GBInfoCheck: TGroupBox
        Left = 24
        Top = 32
        Width = 353
        Height = 169
        TabOrder = 0
        object Label26: TLabel
          Left = 16
          Top = 33
          Width = 257
          Height = 16
          Alignment = taRightJustify
          Caption = 'Days between checking for Infos on server: '
        end
        object CBInfoCheckStable: TCheckBox
          Left = 16
          Top = 104
          Width = 297
          Height = 17
          Caption = 'Check on server for new stable versions'
          TabOrder = 0
        end
        object EChceckInfoInterval: TEdit
          Left = 280
          Top = 25
          Width = 41
          Height = 24
          TabOrder = 1
          Text = '0'
          OnKeyPress = EChceckInfoIntervalKeyPress
        end
        object CBInfoCheckBeta: TCheckBox
          Left = 16
          Top = 136
          Width = 297
          Height = 17
          Caption = 'Check on server for new beta versions'
          TabOrder = 2
        end
        object CBInfoCheckMessages: TCheckBox
          Left = 16
          Top = 72
          Width = 217
          Height = 17
          Caption = 'Check on server for messages'
          TabOrder = 3
        end
      end
      object CBInfoCheckEnabled: TCheckBox
        Left = 32
        Top = 32
        Width = 161
        Height = 17
        Caption = 'Check Infos on Server'
        TabOrder = 1
        OnClick = CBInfoCheckEnabledClick
      end
    end
    object TabExternalCutApplication: TTabSheet
      Caption = 'External cut application'
      object Label18: TLabel
        Left = 39
        Top = 72
        Width = 178
        Height = 16
        Alignment = taRightJustify
        Caption = 'Cut Windows Media Files with:'
      end
      object Label19: TLabel
        Left = 114
        Top = 112
        Width = 103
        Height = 16
        Alignment = taRightJustify
        Caption = 'Cut AVI Files with:'
      end
      object Label20: TLabel
        Left = 88
        Top = 192
        Width = 129
        Height = 16
        Alignment = taRightJustify
        Caption = 'Cut all other Files with:'
      end
      object Label21: TLabel
        Left = 16
        Top = 24
        Width = 309
        Height = 16
        Caption = 'Please select the Cut Application for each File Type:'
      end
      object Label1: TLabel
        Left = 87
        Top = 152
        Width = 130
        Height = 16
        Alignment = taRightJustify
        Caption = 'Cut MP4 Iso Files with:'
      end
      object CBWmvApp: TComboBox
        Left = 224
        Top = 64
        Width = 145
        Height = 24
        Style = csDropDownList
        ItemHeight = 16
        TabOrder = 0
        Items.Strings = (
          '')
      end
      object CBAviApp: TComboBox
        Left = 224
        Top = 104
        Width = 145
        Height = 24
        Style = csDropDownList
        ItemHeight = 16
        TabOrder = 1
        Items.Strings = (
          '')
      end
      object CBOtherApp: TComboBox
        Left = 224
        Top = 184
        Width = 145
        Height = 24
        Style = csDropDownList
        ItemHeight = 16
        TabOrder = 2
        Items.Strings = (
          '')
      end
      object cbMP4App: TComboBox
        Left = 224
        Top = 144
        Width = 145
        Height = 24
        Style = csDropDownList
        ItemHeight = 16
        TabOrder = 3
        Items.Strings = (
          '')
      end
    end
    object tsSourceFilter: TTabSheet
      Caption = 'Source Filter'
      ImageIndex = 8
      OnShow = tsSourceFilterShow
      DesignSize = (
        633
        303)
      object lblSourceFilter: TLabel
        Left = 24
        Top = 32
        Width = 134
        Height = 16
        Caption = 'Preferred Source Filter'
      end
      object Label2: TLabel
        Left = 95
        Top = 128
        Width = 66
        Height = 16
        Alignment = taRightJustify
        Caption = 'for AVI files'
      end
      object Label23: TLabel
        Left = 68
        Top = 168
        Width = 93
        Height = 16
        Alignment = taRightJustify
        Caption = 'for MP4 Iso files'
      end
      object Label24: TLabel
        Left = 67
        Top = 208
        Width = 94
        Height = 16
        Alignment = taRightJustify
        Caption = 'for all Other files'
      end
      object Label25: TLabel
        Left = 20
        Top = 88
        Width = 141
        Height = 16
        Alignment = taRightJustify
        Caption = 'for Windows Media files'
      end
      object pnlPleaseWait: TPanel
        Left = 168
        Top = 24
        Width = 289
        Height = 49
        Caption = 'Checking Filters. Please Wait...'
        Color = clGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clYellow
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        Visible = False
      end
      object cbxSourceFilterListAVI: TComboBox
        Left = 168
        Top = 120
        Width = 449
        Height = 24
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        TabOrder = 0
        Text = '(none)'
      end
      object cbxSourceFilterListMP4: TComboBox
        Left = 168
        Top = 160
        Width = 449
        Height = 24
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        TabOrder = 1
        Text = '(none)'
      end
      object cbxSourceFilterListOther: TComboBox
        Left = 168
        Top = 200
        Width = 449
        Height = 24
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        TabOrder = 2
        Text = '(none)'
      end
      object btnRefreshFilterList: TButton
        Left = 488
        Top = 48
        Width = 129
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Refresh Filter List'
        TabOrder = 3
        OnClick = btnRefreshFilterListClick
      end
      object cbxSourceFilterListWMV: TComboBox
        Left = 168
        Top = 80
        Width = 449
        Height = 24
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 16
        ParentFont = False
        TabOrder = 4
        Text = '(none)'
      end
    end
  end
end
