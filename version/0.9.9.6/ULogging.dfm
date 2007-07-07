object FLogging: TFLogging
  Left = 334
  Top = 370
  Width = 729
  Height = 241
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'Logging messages'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object reMessages: TRichEdit
    Left = 0
    Top = 0
    Width = 721
    Height = 207
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Pitch = fpFixed
    Font.Style = []
    HideScrollBars = False
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    WantReturns = False
    WordWrap = False
  end
  object JvFormMagnet1: TJvFormMagnet
    Active = True
    ScreenMagnet = False
    FormGlue = False
    MainFormMagnet = True
    Left = 36
    Top = 12
  end
  object timScroll: TTimer
    Interval = 250
    OnTimer = timScrollTimer
    Left = 36
    Top = 64
  end
end
