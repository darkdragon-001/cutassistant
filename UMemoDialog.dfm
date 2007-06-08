object frmMemoDialog: TfrmMemoDialog
  Left = 733
  Top = 218
  ActiveControl = BClose
  Caption = 'Cut Assistant'
  ClientHeight = 398
  ClientWidth = 412
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Padding.Left = 3
  Padding.Top = 3
  Padding.Right = 3
  Padding.Bottom = 3
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    412
    398)
  PixelsPerInch = 96
  TextHeight = 13
  object BClose: TButton
    Left = 314
    Top = 367
    Width = 95
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = BCloseClick
  end
  object memInfo: TMemo
    Left = 3
    Top = 3
    Width = 406
    Height = 358
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
end
