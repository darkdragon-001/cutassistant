object frmCutting: TfrmCutting
  Left = 286
  Top = 124
  AutoScroll = False
  BorderIcons = [biMinimize, biMaximize]
  Caption = 'Cutting...'
  ClientHeight = 503
  ClientWidth = 618
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    618
    503)
  PixelsPerInch = 120
  TextHeight = 16
  object memOutput: TMemo
    Left = 0
    Top = 0
    Width = 618
    Height = 462
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'System'
    Font.Pitch = fpFixed
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object btnClose: TButton
    Left = 536
    Top = 469
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    Enabled = False
    TabOrder = 1
  end
  object btnAbort: TButton
    Left = 456
    Top = 469
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Abort'
    TabOrder = 2
    OnClick = btnAbortClick
  end
  object btnCopyClipbrd: TButton
    Left = 8
    Top = 469
    Width = 129
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Copy to Clipboard'
    TabOrder = 3
    OnClick = btnCopyClipbrdClick
  end
  object btnEmergencyExit: TButton
    Left = 336
    Top = 469
    Width = 113
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Terminate Now!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btnEmergencyExitClick
  end
end
