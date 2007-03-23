object FCutlistInfo: TFCutlistInfo
  Left = 1535
  Top = 177
  Width = 615
  Height = 672
  Caption = 'Cutlist Info'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  DesignSize = (
    607
    640)
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 158
    Height = 20
    Caption = 'Infos saved in Cutlist:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 544
    Width = 92
    Height = 16
    Caption = 'User Comment:'
  end
  object Label3: TLabel
    Left = 8
    Top = 488
    Width = 277
    Height = 16
    Caption = 'Suggested movie file name (without extension):'
  end
  object RGRatingByAuthor: TRadioGroup
    Left = 8
    Top = 40
    Width = 593
    Height = 193
    Anchors = [akLeft, akTop, akRight]
    Caption = 'How do you rate your cutlist?'
    Items.Strings = (
      
        '0 - Test, do not use, or dummy cutlist to save only information ' +
        'about the movie (see below)'
      
        '1 - I trimmed beginning and end, but there may be one or more co' +
        'mmercials still in the movie'
      
        '2 - All commercials cut out, but I did the cutting very roughly ' +
        '(+/- 5 sec.)'
      '3 - ... I did the cutting fairly accurate (+/- 1 sec.)'
      '4 - ... I did the cutting very accurate (to frame)'
      '5 - ... and I removed duplicate scenes if necessary')
    TabOrder = 0
    OnClick = EnableOK
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 256
    Width = 593
    Height = 217
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Infos about the movie:'
    TabOrder = 1
    DesignSize = (
      593
      217)
    object CBEPGError: TCheckBox
      Left = 8
      Top = 24
      Width = 505
      Height = 17
      Caption = 
        'Wrong content, EPG error (filename does not match content). Actu' +
        'al content:'
      TabOrder = 0
      OnClick = CBEPGErrorClick
    end
    object CBMissingBeginning: TCheckBox
      Left = 8
      Top = 88
      Width = 225
      Height = 17
      Caption = 'Missing Beginning'
      TabOrder = 1
      OnClick = EnableOK
    end
    object CBMissingEnding: TCheckBox
      Left = 8
      Top = 112
      Width = 225
      Height = 17
      Caption = 'Missing Ending'
      TabOrder = 2
      OnClick = EnableOK
    end
    object CBMissingVideo: TCheckBox
      Left = 8
      Top = 136
      Width = 265
      Height = 17
      Caption = 'Missing Video track'
      TabOrder = 3
      OnClick = EnableOK
    end
    object CBMissingAudio: TCheckBox
      Left = 8
      Top = 160
      Width = 265
      Height = 17
      Caption = 'Missing Audio track'
      TabOrder = 4
      OnClick = EnableOK
    end
    object CBOtherError: TCheckBox
      Left = 8
      Top = 192
      Width = 97
      Height = 17
      Caption = 'Other Error:'
      TabOrder = 5
      OnClick = CBOtherErrorClick
    end
    object EOtherErrorDescription: TEdit
      Left = 104
      Top = 184
      Width = 473
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 6
      OnChange = EnableOK
    end
    object EActualContent: TEdit
      Left = 32
      Top = 48
      Width = 545
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 7
      OnChange = EnableOK
    end
  end
  object Button1: TButton
    Left = 528
    Top = 608
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object Button2: TButton
    Left = 448
    Top = 608
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 3
  end
  object EUserComment: TEdit
    Left = 8
    Top = 568
    Width = 593
    Height = 24
    TabOrder = 4
    OnChange = EnableOK
  end
  object Panel1: TPanel
    Left = 8
    Top = 600
    Width = 433
    Height = 33
    BevelInner = bvLowered
    TabOrder = 5
    object LAuthor: TLabel
      Left = 2
      Top = 8
      Width = 429
      Height = 23
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 'Cutlist Author unknown'
      Color = clNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -17
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
  end
  object CBFramesPresent: TCheckBox
    Left = 424
    Top = 8
    Width = 177
    Height = 17
    Caption = 'Frame numbers present'
    Enabled = False
    TabOrder = 6
  end
  object EMovieName: TEdit
    Left = 8
    Top = 512
    Width = 449
    Height = 24
    TabOrder = 7
    OnChange = EnableOK
  end
  object BMovieNameCopy: TButton
    Left = 464
    Top = 512
    Width = 137
    Height = 25
    Caption = 'Copy from Filename'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = BMovieNameCopyClick
  end
end
