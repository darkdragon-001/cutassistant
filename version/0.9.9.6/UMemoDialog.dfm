object frmMemoDialog: TfrmMemoDialog
  Left = 733
  Top = 218
  Width = 437
  Height = 432
  ActiveControl = BClose
  Caption = 'Cut Assistant'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    429
    398)
  PixelsPerInch = 96
  TextHeight = 13
  object BClose: TButton
    Left = 330
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
    Left = 0
    Top = 0
    Width = 429
    Height = 358
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
end
