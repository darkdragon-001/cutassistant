object FCutlistRate: TFCutlistRate
  Left = 841
  Top = 114
  Width = 615
  Height = 303
  Caption = 'Cutlist Info'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    607
    269)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 7
    Top = 7
    Width = 172
    Height = 16
    Caption = 'Send Cutlist Rating to Server:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object RGRatingByAuthor: TRadioGroup
    Left = 7
    Top = 33
    Width = 481
    Height = 156
    Anchors = [akLeft, akTop, akRight]
    Caption = 'How do you rate this cutlist?'
    Items.Strings = (
      
        '0 - Test, do not use, or dummy cutlist to save only information ' +
        'about the movie'
      
        '1 - Trimmed beginning and end, but there are one or more commerc' +
        'ials still in the movie'
      
        '2 - All commercials cut out, but cutting was done very roughly (' +
        '+/- 5 sec.)'
      '3 - ... cutting was done fairly accurate (+/- 1 sec.)'
      '4 - ... cutting was done very accurate (to frame)'
      
        '5 - ... perfect! (Duplicate scenes have been removed if necessar' +
        'y)')
    TabOrder = 0
    OnClick = RGRatingByAuthorClick
  end
  object Button1: TButton
    Left = 429
    Top = 194
    Width = 61
    Height = 21
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object ButtonOK: TButton
    Left = 364
    Top = 194
    Width = 61
    Height = 21
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Enabled = False
    ModalResult = 1
    TabOrder = 2
  end
end
