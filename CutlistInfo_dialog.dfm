object FCutlistInfo: TFCutlistInfo
  Left = 371
  Top = 200
  BorderStyle = bsSingle
  Caption = 'Cutlist Info'
  ClientHeight = 520
  ClientWidth = 494
  Color = clBtnFace
  Constraints.MinHeight = 553
  Constraints.MinWidth = 502
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Microsoft Sans Serif'
  Font.Pitch = fpVariable
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  DesignSize = (
    494
    520)
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
    Font.Height = -13
    Font.Name = 'Microsoft Sans Serif'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 7
    Top = 442
    Width = 72
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'User Comment:'
  end
  object Label3: TLabel
    Left = 7
    Top = 397
    Width = 221
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Suggested movie file name (without extension):'
  end
  object lblFrameRate: TLabel
    Left = 249
    Top = 12
    Width = 88
    Height = 13
    Alignment = taRightJustify
    Anchors = [akLeft, akBottom]
    Caption = 'Frame rate: N/A (-)'
    Layout = tlCenter
  end
  object RGRatingByAuthor: TRadioGroup
    Left = 7
    Top = 33
    Width = 481
    Height = 156
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'How do you rate your cutlist?'
    Items.Strings = (
      
        '&0 - Test, do not use, or dummy cutlist to save only information' +
        ' about the movie (see below)'
      
        '&1 - I trimmed beginning and end, but there may be one or more c' +
        'ommercials still in the movie'
      
        '&2 - All commercials cut out, but I did the cutting very roughly' +
        ' (+/- 5 sec.)'
      '&3 - ... I did the cutting fairly accurate (+/- 1 sec.)'
      '&4 - ... I did the cutting very accurate (to frame)'
      '&5 - ... and I removed duplicate scenes if necessary')
    TabOrder = 0
    OnClick = EnableOK
  end
  object grpDetails: TGroupBox
    Left = 7
    Top = 208
    Width = 481
    Height = 176
    Anchors = [akLeft, akRight, akBottom]
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
      TabOrder = 2
      OnClick = EnableOK
    end
    object CBMissingEnding: TCheckBox
      Left = 7
      Top = 91
      Width = 182
      Height = 14
      Caption = 'Missing Ending'
      TabOrder = 3
      OnClick = EnableOK
    end
    object CBMissingVideo: TCheckBox
      Left = 7
      Top = 111
      Width = 215
      Height = 13
      Caption = 'Missing Video track'
      TabOrder = 4
      OnClick = EnableOK
    end
    object CBMissingAudio: TCheckBox
      Left = 7
      Top = 130
      Width = 215
      Height = 14
      Caption = 'Missing Audio track'
      TabOrder = 5
      OnClick = EnableOK
    end
    object CBOtherError: TCheckBox
      Left = 7
      Top = 153
      Width = 78
      Height = 14
      Caption = 'Other Error:'
      TabOrder = 6
      OnClick = CBOtherErrorClick
    end
    object EOtherErrorDescription: TEdit
      Left = 85
      Top = 149
      Width = 384
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 7
      OnChange = EnableOK
    end
    object EActualContent: TEdit
      Left = 26
      Top = 39
      Width = 443
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      OnChange = EnableOK
    end
  end
  object cmdCancel: TButton
    Left = 402
    Top = 491
    Width = 85
    Height = 20
    Anchors = [akRight, akBottom]
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 8
  end
  object cmdOk: TButton
    Left = 312
    Top = 491
    Width = 85
    Height = 20
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    ModalResult = 1
    TabOrder = 7
  end
  object EUserComment: TEdit
    Left = 7
    Top = 462
    Width = 481
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 4
    OnChange = EnableOK
  end
  object pnlAuthor: TPanel
    Left = 7
    Top = 488
    Width = 298
    Height = 26
    Anchors = [akLeft, akRight, akBottom]
    BevelInner = bvLowered
    TabOrder = 6
    object LAuthor: TLabel
      Left = 2
      Top = 6
      Width = 294
      Height = 18
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 'Cutlist Author unknown'
      Color = clNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Microsoft Sans Serif'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
  end
  object CBFramesPresent: TCheckBox
    Left = 345
    Top = 12
    Width = 143
    Height = 13
    TabStop = False
    Anchors = [akTop, akRight]
    Caption = 'Frame numbers present'
    Enabled = False
    TabOrder = 5
  end
  object EMovieName: TEdit
    Left = 7
    Top = 416
    Width = 364
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 2
    OnChange = EnableOK
  end
  object BMovieNameCopy: TButton
    Left = 377
    Top = 416
    Width = 111
    Height = 20
    Anchors = [akRight, akBottom]
    Caption = 'Copy from Filename'
    TabOrder = 3
    OnClick = BMovieNameCopyClick
  end
end
