object FCutlistRate: TFCutlistRate
  Left = -841
  Top = 114
  Width = 615
  Height = 303
  Caption = 'Cutlist Info'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    607
    271)
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 218
    Height = 20
    Caption = 'Send Cutlist Rating to Server:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object RGRatingByAuthor: TRadioGroup
    Left = 8
    Top = 40
    Width = 593
    Height = 193
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
    Left = 528
    Top = 239
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object ButtonOK: TButton
    Left = 448
    Top = 239
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Enabled = False
    ModalResult = 1
    TabOrder = 2
  end
end
