object frmMemoDialog: TfrmMemoDialog
  Left = 733
  Top = 218
  Width = 420
  Height = 456
  ActiveControl = BClose
  Caption = 'Cut Assistant'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    412
    424)
  PixelsPerInch = 120
  TextHeight = 16
  object BClose: TButton
    Left = 328
    Top = 396
    Width = 81
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = BCloseClick
  end
  object memInfo: TMemo
    Left = 0
    Top = 0
    Width = 412
    Height = 389
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 1
  end
end
