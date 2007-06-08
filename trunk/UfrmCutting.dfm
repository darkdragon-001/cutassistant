object frmCutting: TfrmCutting
  Left = 286
  Top = 124
  Width = 500
  Height = 378
  BorderIcons = [biMaximize]
  Caption = 'Cutting ...'
  Color = clBtnFace
  Constraints.MinHeight = 260
  Constraints.MinWidth = 500
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
    492
    344)
  PixelsPerInch = 96
  TextHeight = 13
  object memOutput: TMemo
    Left = 6
    Top = 6
    Width = 480
    Height = 301
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'System'
    Font.Pitch = fpFixed
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object btnClose: TButton
    Left = 381
    Top = 313
    Width = 105
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Close'
    Enabled = False
    TabOrder = 1
  end
  object btnAbort: TButton
    Left = 270
    Top = 313
    Width = 105
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = '&Abort'
    TabOrder = 2
    OnClick = btnAbortClick
  end
  object btnCopyClipbrd: TButton
    Left = 6
    Top = 313
    Width = 105
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Copy to Clipboard'
    TabOrder = 3
    OnClick = btnCopyClipbrdClick
  end
  object btnEmergencyExit: TButton
    Left = 159
    Top = 313
    Width = 105
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Terminate Now!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btnEmergencyExitClick
  end
end
