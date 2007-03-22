object frmCutApplicationBase: TfrmCutApplicationBase
  Left = 0
  Top = 0
  Width = 385
  Height = 240
  TabOrder = 0
  DesignSize = (
    385
    240)
  object lblAppPath: TLabel
    Left = 8
    Top = 16
    Width = 27
    Height = 16
    Caption = 'Path'
  end
  object lblTempDir: TLabel
    Left = 8
    Top = 64
    Width = 78
    Height = 16
    Caption = 'Temp Folder'
  end
  object edtPath: TEdit
    Left = 8
    Top = 32
    Width = 329
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 0
  end
  object btnBrowsePath: TButton
    Left = 341
    Top = 32
    Width = 35
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 1
    OnClick = btnBrowsePathClick
  end
  object edtTempDir: TEdit
    Left = 8
    Top = 80
    Width = 329
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 2
  end
  object btnBrowseTempDir: TButton
    Left = 341
    Top = 80
    Width = 35
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 3
    OnClick = btnBrowseTempDirClick
  end
  object cbRedirectOutput: TCheckBox
    Left = 8
    Top = 112
    Width = 369
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Redirect Output to Cut Assistant'
    TabOrder = 4
  end
  object cbShowAppWindow: TCheckBox
    Left = 8
    Top = 136
    Width = 369
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Show original Application Window'
    TabOrder = 5
  end
  object cbCleanUp: TCheckBox
    Left = 8
    Top = 160
    Width = 369
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Delete Temp Files after Cutting'
    TabOrder = 6
  end
end
