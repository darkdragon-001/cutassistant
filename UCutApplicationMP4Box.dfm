inherited frmCutApplicationMP4Box: TfrmCutApplicationMP4Box
  Constraints.MinHeight = 160
  Constraints.MinWidth = 385
  object lblCommandLineOptions: TLabel [2]
    Left = 8
    Top = 184
    Width = 109
    Height = 13
    Caption = 'Command Line Options'
  end
  object edtCommandLineOptions: TEdit [3]
    Left = 8
    Top = 200
    Width = 329
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  inherited edtPath: TEdit
    TabOrder = 2
  end
  inherited btnBrowsePath: TButton
    TabOrder = 0
  end
  inherited edtTempDir: TEdit
    Enabled = False
    TabOrder = 4
  end
  inherited btnBrowseTempDir: TButton
    Enabled = False
    TabOrder = 6
  end
  inherited cbRedirectOutput: TCheckBox
    TabOrder = 5
  end
  inherited cbShowAppWindow: TCheckBox
    TabOrder = 3
  end
  inherited cbCleanUp: TCheckBox
    TabOrder = 7
  end
end
