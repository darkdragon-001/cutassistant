object FCutlistInfo: TFCutlistInfo
  Left = 535
  Top = 177
  Width = 615
  Height = 672
  Caption = 'Cutlist Info'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  DesignSize = (
    607
    638)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 7
    Top = 7
    Width = 123
    Height = 16
    Caption = 'Infos saved in Cutlist:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 7
    Top = 442
    Width = 72
    Height = 13
    Caption = 'User Comment:'
  end
  object Label3: TLabel
    Left = 7
    Top = 397
    Width = 221
    Height = 13
    Caption = 'Suggested movie file name (without extension):'
  end
  object RGRatingByAuthor: TRadioGroup
    Left = 7
    Top = 33
    Width = 481
    Height = 156
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
    Left = 7
    Top = 208
    Width = 481
    Height = 176
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Infos about the movie:'
    TabOrder = 1
    DesignSize = (
      481
      176)
    object CBEPGError: TCheckBox
      Left = 7
      Top = 20
      Width = 410
      Height = 13
      Caption = 
        'Wrong content, EPG error (filename does not match content). Actu' +
        'al content:'
      TabOrder = 0
      OnClick = CBEPGErrorClick
    end
    object CBMissingBeginning: TCheckBox
      Left = 7
      Top = 72
      Width = 182
      Height = 13
      Caption = 'Missing Beginning'
      TabOrder = 1
      OnClick = EnableOK
    end
    object CBMissingEnding: TCheckBox
      Left = 7
      Top = 91
      Width = 182
      Height = 14
      Caption = 'Missing Ending'
      TabOrder = 2
      OnClick = EnableOK
    end
    object CBMissingVideo: TCheckBox
      Left = 7
      Top = 111
      Width = 215
      Height = 13
      Caption = 'Missing Video track'
      TabOrder = 3
      OnClick = EnableOK
    end
    object CBMissingAudio: TCheckBox
      Left = 7
      Top = 130
      Width = 215
      Height = 14
      Caption = 'Missing Audio track'
      TabOrder = 4
      OnClick = EnableOK
    end
    object CBOtherError: TCheckBox
      Left = 7
      Top = 156
      Width = 78
      Height = 14
      Caption = 'Other Error:'
      TabOrder = 5
      OnClick = CBOtherErrorClick
    end
    object EOtherErrorDescription: TEdit
      Left = 85
      Top = 150
      Width = 384
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 6
      OnChange = EnableOK
    end
    object EActualContent: TEdit
      Left = 26
      Top = 39
      Width = 443
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 7
      OnChange = EnableOK
    end
  end
  object Button1: TButton
    Left = 429
    Top = 494
    Width = 61
    Height = 20
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object Button2: TButton
    Left = 364
    Top = 494
    Width = 61
    Height = 20
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 3
  end
  object EUserComment: TEdit
    Left = 7
    Top = 462
    Width = 481
    Height = 21
    TabOrder = 4
    OnChange = EnableOK
  end
  object Panel1: TPanel
    Left = 7
    Top = 488
    Width = 351
    Height = 26
    BevelInner = bvLowered
    TabOrder = 5
    object LAuthor: TLabel
      Left = 2
      Top = 6
      Width = 347
      Height = 18
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 'Cutlist Author unknown'
      Color = clNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
  end
  object CBFramesPresent: TCheckBox
    Left = 345
    Top = 7
    Width = 143
    Height = 13
    Caption = 'Frame numbers present'
    Enabled = False
    TabOrder = 6
  end
  object EMovieName: TEdit
    Left = 7
    Top = 416
    Width = 364
    Height = 21
    TabOrder = 7
    OnChange = EnableOK
  end
  object BMovieNameCopy: TButton
    Left = 377
    Top = 416
    Width = 111
    Height = 20
    Caption = 'Copy from Filename'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = BMovieNameCopyClick
  end
end
