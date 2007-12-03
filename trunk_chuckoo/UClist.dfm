object frmClist: TfrmClist
  Left = 469
  Top = 186
  Width = 804
  Height = 624
  Caption = 'Cutlist'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    794
    586)
  PixelsPerInch = 144
  TextHeight = 20
  object Lcutlist: TListView
    Left = 0
    Top = 52
    Width = 385
    Height = 528
    Columns = <
      item
        Caption = '#'
        Width = 46
      end
      item
        Caption = 'From'
        Width = 108
      end
      item
        Caption = 'To'
        Width = 108
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
    Left = -2
    Top = 2
    Width = 387
    Height = 50
    BevelInner = bvLowered
    TabOrder = 1
    Visible = False
    object LAuthor: TLabel
      Left = 2
      Top = 2
      Width = 383
      Height = 46
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 'Cutlist Author unknown'
      Color = clNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -24
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
    Left = 385
    Top = -24
    Width = 408
    Height = 605
    Anchors = [akTop, akRight]
    BevelOuter = bvLowered
    ParentBackground = False
    TabOrder = 2
    object LResultingDuration: TLabel
      Left = 10
      Top = 25
      Width = 302
      Height = 22
      Alignment = taRightJustify
      Caption = 'Resulting movie duration: 0:00:00.000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -18
      Font.Name = 'Microsoft Sans Serif'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object LTotalCutoff: TLabel
      Left = 10
      Top = 52
      Width = 195
      Height = 22
      Alignment = taRightJustify
      Caption = 'Total cutoff: 0:00:00.000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -18
      Font.Name = 'Microsoft Sans Serif'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblCutApplication: TLabel
      Left = 7
      Top = 99
      Width = 187
      Height = 20
      Alignment = taCenter
      AutoSize = False
      Caption = 'N/A'
    end
    object lblMovieType: TLabel
      Left = 8
      Top = 146
      Width = 185
      Height = 20
      Alignment = taCenter
      AutoSize = False
      Caption = '[None]'
    end
    object lblMovieFPS: TLabel
      Left = 213
      Top = 55
      Width = 184
      Height = 20
      Alignment = taCenter
      AutoSize = False
      Caption = '0.00000 fps (F)'
    end
    object ICutlistWarning: TImage
      Left = 324
      Top = 179
      Width = 44
      Height = 43
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
      Left = 7
      Top = 231
      Width = 171
      Height = 31
      Caption = 'Replace Selected Cut'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BReplaceCutClick
    end
    object BEditCut: TButton
      Left = 6
      Top = 276
      Width = 171
      Height = 31
      Caption = 'Edit Selected Cut'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = BEditCutClick
    end
    object BDeleteCut: TButton
      Left = 6
      Top = 323
      Width = 171
      Height = 31
      Caption = 'Delete Selected Cut'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = BDeleteCutClick
    end
    object BClearCutlist: TButton
      Left = 6
      Top = 367
      Width = 171
      Height = 31
      Caption = 'Clear Cutlist'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = BClearCutlistClick
    end
    object BConvert: TButton
      Left = 200
      Top = 174
      Width = 73
      Height = 40
      Caption = 'Convert'
      TabOrder = 4
      OnClick = BConvertClick
    end
    object BCutlistInfo: TBitBtn
      Left = 13
      Top = 559
      Width = 117
      Height = 31
      Caption = 'Cutlist &Info'
      TabOrder = 5
      OnClick = BCutlistInfoClick
    end
    object RCutMode: TRadioGroup
      Left = 197
      Top = 79
      Width = 188
      Height = 91
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
