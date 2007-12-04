object frmClist: TfrmClist
  Left = 233
  Top = 236
  Width = 520
  Height = 411
  Caption = 'Cutlist'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    512
    384)
  PixelsPerInch = 96
  TextHeight = 13
  object Lcutlist: TListView
    Left = 0
    Top = 34
    Width = 250
    Height = 343
    Columns = <
      item
        Caption = '#'
        Width = 30
      end
      item
        Caption = 'From'
        Width = 70
      end
      item
        Caption = 'To'
        Width = 70
      end
      item
        AutoSize = True
        Caption = 'Duration'
      end>
    GridLines = True
    HideSelection = False
    Items.Data = {
      4A0000000100000000000000FFFFFFFFFFFFFFFF030000000000000003313030
      0B303A30303A30302E3030300B303A30303A30302E3030300B303A30303A3030
      2E303030FFFFFFFFFFFF}
    ReadOnly = True
    RowSelect = True
    SortType = stText
    TabOrder = 0
    ViewStyle = vsReport
  end
  object PAuthor: TPanel
    Left = -1
    Top = 1
    Width = 251
    Height = 33
    BevelInner = bvLowered
    TabOrder = 1
    Visible = False
    object LAuthor: TLabel
      Left = 2
      Top = 2
      Width = 247
      Height = 29
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 'Cutlist Author unknown'
      Color = clNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Microsoft Sans Serif'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
  end
  object Panel4: TPanel
    Left = 250
    Top = 0
    Width = 266
    Height = 377
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvLowered
    ParentBackground = False
    TabOrder = 2
    object LResultingDuration: TLabel
      Left = -4
      Top = 16
      Width = 207
      Height = 15
      Alignment = taRightJustify
      Caption = 'Resulting movie duration: 0:00:00.000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -12
      Font.Name = 'Microsoft Sans Serif'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object LTotalCutoff: TLabel
      Left = 3
      Top = 34
      Width = 130
      Height = 15
      Alignment = taRightJustify
      Caption = 'Total cutoff: 0:00:00.000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Microsoft Sans Serif'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblCutApplication: TLabel
      Left = 5
      Top = 64
      Width = 121
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'N/A'
    end
    object lblMovieType: TLabel
      Left = 5
      Top = 95
      Width = 120
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '[None]'
    end
    object lblMovieFPS: TLabel
      Left = 138
      Top = 36
      Width = 120
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '0.00000 fps (F)'
    end
    object ICutlistWarning: TImage
      Left = 211
      Top = 116
      Width = 28
      Height = 28
      Picture.Data = {
        0B544A76474946496D6167651804000047494638396124002300F70000FFFF00
        7F7F00808003EEEEEED2D2D2BFBFBF7F7F7F0303030000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000000000000000021F904
        01000003002C00000000240023000008F50007081C48B0A0C18308132A5CC830
        A180870D2316140000C08003122552AC68F100818C0C37724440E02348842239
        162069F2E4448E30111868E952604A982B4BD61C7833E6CC9D037AE264B953E4
        4A04080A8CFCE93225D2A72A899E74FA14814F9A116F56B51A556746AD556102
        90897561CFAD6273967528164080A701DA92CDDA16C0D1A46DD536143A1669DD
        B14C15F2758B206E5DBD82FFDAC5FB772E5BC56321233E3818F25594968F2AFD
        3B9960E5BE7E153BF66C193457CE527996D66C79B4CDD2B02B92A5F939F66203
        815FDB468D3BB7CD0307B60A1F5EB5B75783257B2B5FCE7CF9F18325A34B9F4E
        7D3AD0930101003B}
      Stretch = True
      Transparent = True
    end
    object BReplaceCut: TButton
      Left = 5
      Top = 150
      Width = 111
      Height = 20
      Caption = 'Replace Selected Cut'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BReplaceCutClick
    end
    object BEditCut: TButton
      Left = 4
      Top = 179
      Width = 111
      Height = 21
      Caption = 'Edit Selected Cut'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = BEditCutClick
    end
    object BDeleteCut: TButton
      Left = 4
      Top = 210
      Width = 111
      Height = 20
      Caption = 'Delete Selected Cut'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = BDeleteCutClick
    end
    object BClearCutlist: TButton
      Left = 4
      Top = 239
      Width = 111
      Height = 20
      Caption = 'Clear Cutlist'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = BClearCutlistClick
    end
    object BConvert: TButton
      Left = 130
      Top = 113
      Width = 47
      Height = 26
      Caption = 'Convert'
      TabOrder = 4
      OnClick = BConvertClick
    end
    object BCutlistInfo: TBitBtn
      Left = 8
      Top = 347
      Width = 77
      Height = 21
      Caption = 'Cutlist &Info'
      TabOrder = 5
      OnClick = BCutlistInfoClick
    end
    object RCutMode: TRadioGroup
      Left = 128
      Top = 51
      Width = 122
      Height = 60
      Hint = 
        'Cut out: New file is everything except cuts. Crop: NEw file is s' +
        'um of cuts.'
      Caption = 'Cut Mode'
      ItemIndex = 0
      Items.Strings = (
        'Cut out'
        'Crop')
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = RCutModeClick
    end
  end
end
