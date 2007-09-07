object frmCutApplicationBase: TfrmCutApplicationBase
  Left = 0
  Top = 0
  Width = 385
  Height = 160
  AutoScroll = False
  Constraints.MinHeight = 160
  Constraints.MinWidth = 385
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Microsoft Sans Serif'
  Font.Pitch = fpVariable
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  TabStop = True
  DesignSize = (
    385
    160)
  object lblAppPath: TLabel
    Left = 6
    Top = 3
    Width = 22
    Height = 13
    Caption = 'Path'
  end
  object lblTempDir: TLabel
    Left = 6
    Top = 49
    Width = 59
    Height = 13
    Caption = 'Temp Folder'
  end
  object edtPath: TEdit
    Left = 6
    Top = 22
    Width = 348
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 0
  end
  object btnBrowsePath: TButton
    Left = 360
    Top = 22
    Width = 22
    Height = 21
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 1
    OnClick = btnBrowsePathClick
  end
  object edtTempDir: TEdit
    Left = 6
    Top = 68
    Width = 348
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 2
  end
  object btnBrowseTempDir: TButton
    Left = 360
    Top = 68
    Width = 22
    Height = 21
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 3
    OnClick = btnBrowseTempDirClick
  end
  object cbRedirectOutput: TCheckBox
    Left = 6
    Top = 95
    Width = 369
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Redirect Output to Cut Assistant'
    TabOrder = 4
  end
  object cbShowAppWindow: TCheckBox
    Left = 6
    Top = 118
    Width = 369
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Show original Application Window'
    TabOrder = 5
  end
  object cbCleanUp: TCheckBox
    Left = 6
    Top = 141
    Width = 369
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Delete Temp Files after Cutting'
    TabOrder = 6
  end
  object selectFileDlg: TOpenDialog
    Filter = 'Executables (*.exe)|*.exe|All files|*.*'
    Options = [ofHideReadOnly, ofNoChangeDir, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 352
    Top = 128
  end
end
