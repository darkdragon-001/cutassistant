inherited frmCutApplicationMP4Box: TfrmCutApplicationMP4Box
  Height = 210
  Constraints.MinHeight = 210
  object lblCommandLineOptions: TLabel [2]
    Left = 8
    Top = 164
    Width = 109
    Height = 13
    Caption = 'Command Line Options'
  end
  object edtCommandLineOptions: TEdit [3]
    Left = 8
    Top = 180
    Width = 344
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  inherited edtPath: TEdit
    Width = 344
    TabOrder = 2
  end
  inherited btnBrowsePath: TButton
    Left = 356
    TabOrder = 0
  end
  inherited edtTempDir: TEdit
    Width = 344
    Enabled = False
    TabOrder = 4
  end
  inherited btnBrowseTempDir: TButton
    Left = 356
    Enabled = False
    TabOrder = 6
  end
  inherited cbRedirectOutput: TCheckBox
    Width = 365
    TabOrder = 5
  end
  inherited cbShowAppWindow: TCheckBox
    Width = 365
    TabOrder = 3
  end
  inherited cbCleanUp: TCheckBox
    Width = 365
    TabOrder = 7
  end
end
