object FMain: TFMain
  Left = 203
  Top = 150
  AutoScroll = False
  Caption = 'Cut Assistant'
  ClientHeight = 710
  ClientWidth = 1029
  Color = clBtnFace
  Constraints.MinHeight = 630
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    1029
    710)
  PixelsPerInch = 120
  TextHeight = 16
  object Bevel3: TBevel
    Left = 567
    Top = 360
    Width = 297
    Height = 137
    Anchors = [akTop, akRight]
    ParentShowHint = False
    ShowHint = True
  end
  object Label1: TLabel
    Left = 599
    Top = 256
    Width = 31
    Height = 16
    Anchors = [akTop, akRight]
    Caption = 'From'
  end
  object Label2: TLabel
    Left = 583
    Top = 320
    Width = 50
    Height = 16
    Anchors = [akTop, akRight]
    Caption = 'Duration'
  end
  object Label3: TLabel
    Left = 615
    Top = 288
    Width = 17
    Height = 16
    Anchors = [akTop, akRight]
    Caption = 'To'
  end
  object Label8: TLabel
    Left = 575
    Top = 410
    Width = 46
    Height = 16
    Anchors = [akTop, akRight]
    Caption = 'Volume'
  end
  object LPos: TLabel
    Left = 938
    Top = 591
    Width = 86
    Height = 20
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    Caption = '0:00:00.000'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label11: TLabel
    Left = 16
    Top = 679
    Width = 18
    Height = 16
    Anchors = [akLeft, akBottom]
    Caption = '-50'
  end
  object Label12: TLabel
    Left = 592
    Top = 687
    Width = 21
    Height = 16
    Anchors = [akRight, akBottom]
    Caption = '+50'
  end
  object LDuration: TLabel
    Left = 959
    Top = 655
    Width = 65
    Height = 16
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    Caption = '0:00:00.000'
  end
  object Bevel2: TBevel
    Left = 567
    Top = 64
    Width = 457
    Height = 281
    Anchors = [akTop, akRight]
  end
  object LFinePos: TLabel
    Left = 593
    Top = 655
    Width = 56
    Height = 16
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    Caption = '0 Frames'
  end
  object Label7: TLabel
    Left = 16
    Top = 647
    Width = 7
    Height = 16
    Anchors = [akLeft, akBottom]
    Caption = '0'
  end
  object ICutlistWarning: TImage
    Left = 979
    Top = 204
    Width = 36
    Height = 35
    Anchors = [akTop, akRight]
    Picture.Data = {
      0954474946496D61676547494638396124002300F70000FFFF007F7F00808003
      EEEEEED2D2D2BFBFBF7F7F7F0303030000000000000000000000000000000000
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
      000000000000000000000000000000000000000000000021F90401000003002C
      00000000240023000008F50007081C48B0A0C18308132A5CC830A180870D2316
      140000C08003122552AC68F100818C0C37724440E02348842239162069F2E444
      8E30111868E952604A982B4BD61C7833E6CC9D037AE264B953E44A04080A8CFC
      E93225D2A72A899E74FA14814F9A116F56B51A556746AD55610290897561CFAD
      6273967528164080A701DA92CDDA16C0D1A46DD536143A1669DDB14C15F2758B
      206E5DBD82FFDAC5FB772E5BC56321233E3818F25594968F2AFD3B9960E5BE7E
      153BF66C193457CE527996D66C79B4CDD2B02B92A5F939F66203815FDB468D3B
      B7CD0307B60A1F5EB5B75783257B2B5FCE7CF9F18325A34B9F4E7D3AD0930101
      003B}
    Stretch = True
    Transparent = True
  end
  object LTotalCutoff: TLabel
    Left = 725
    Top = 204
    Width = 136
    Height = 16
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = 'Total cutoff: 0:00:00.000'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LResultingDuration: TLabel
    Left = 643
    Top = 220
    Width = 218
    Height = 16
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = 'Resulting movie duration: 0:00:00.000'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 591
    Top = 450
    Width = 29
    Height = 16
    Anchors = [akTop, akRight]
    Caption = 'Rate'
  end
  object LRate: TLabel
    Left = 781
    Top = 450
    Width = 59
    Height = 25
    Hint = 'Frame Rate (Double click to set to 1.0)'
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = '1.000x'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnDblClick = LRateDblClick
  end
  object LTrueRate: TLabel
    Left = 813
    Top = 474
    Width = 27
    Height = 16
    Hint = 'Actual Frame Rate'
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = '[ ? x]'
  end
  object PanelVideoWindow: TPanel
    Left = 8
    Top = 64
    Width = 551
    Height = 545
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 25
    OnResize = PanelVideoWindowResize
    object VideoWindow: TVideoWindow
      Left = 0
      Top = 0
      Width = 600
      Height = 450
      FilterGraph = FilterGraph
      VMROptions.Mode = vmrWindowless
      VMROptions.Streams = 1
      Color = clBlack
      PopupMenu = MenuVideo
      OnKeyDown = VideoWindowKeyDown
      OnClick = VideoWindowClick
      OnDblClick = VideoWindowDblClick
    end
  end
  object BStop: TButton
    Left = 735
    Top = 368
    Width = 33
    Height = 33
    Hint = 'Stop'
    Anchors = [akTop, akRight]
    Caption = '[ ]'
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = BStopClick
  end
  object BPlayPause: TButton
    Left = 615
    Top = 368
    Width = 33
    Height = 33
    Hint = 'Play'
    Anchors = [akTop, akRight]
    Caption = '>'
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = BPlayPauseClick
  end
  object Lcutlist: TListView
    Left = 575
    Top = 80
    Width = 289
    Height = 121
    Anchors = [akTop, akRight]
    Columns = <
      item
        Caption = '#'
      end
      item
        Caption = 'From'
      end
      item
        Caption = 'To'
      end
      item
        AutoSize = True
        Caption = 'Duration'
      end>
    GridLines = True
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    SortType = stText
    TabOrder = 2
    ViewStyle = vsReport
    OnDblClick = LcutlistDblClick
    OnSelectItem = LcutlistSelectItem
  end
  object BAddCut: TButton
    Left = 871
    Top = 80
    Width = 137
    Height = 25
    Action = AddCut
    Anchors = [akTop, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
  object BDeleteCut: TButton
    Left = 871
    Top = 176
    Width = 137
    Height = 25
    Action = DeleteCut
    Anchors = [akTop, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
  end
  object EFrom: TEdit
    Left = 639
    Top = 248
    Width = 121
    Height = 24
    Anchors = [akTop, akRight]
    ReadOnly = True
    TabOrder = 5
  end
  object EDuration: TEdit
    Left = 639
    Top = 312
    Width = 121
    Height = 24
    Anchors = [akTop, akRight]
    ReadOnly = True
    TabOrder = 6
  end
  object ETo: TEdit
    Left = 639
    Top = 280
    Width = 121
    Height = 24
    Anchors = [akTop, akRight]
    ReadOnly = True
    TabOrder = 7
  end
  object BSetFrom: TButton
    Left = 775
    Top = 248
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Set Current'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = BSetFromClick
  end
  object BSetTo: TButton
    Left = 775
    Top = 280
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Set Current'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = BSetToClick
  end
  object BFromStart: TButton
    Left = 855
    Top = 248
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Set 0:00'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = BFromStartClick
  end
  object BToEnd: TButton
    Left = 855
    Top = 280
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Set End'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = BToEndClick
  end
  object BJumpFrom: TButton
    Left = 935
    Top = 248
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Jump to'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    OnClick = BJumpFromClick
  end
  object BJumpTo: TButton
    Left = 935
    Top = 280
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Jump to'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
    OnClick = BJumpToClick
  end
  object BReplaceCut: TButton
    Left = 871
    Top = 112
    Width = 137
    Height = 25
    Action = ReplaceCut
    Anchors = [akTop, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 14
  end
  object BEditCut: TButton
    Left = 871
    Top = 144
    Width = 137
    Height = 25
    Action = EditCut
    Anchors = [akTop, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
  end
  object RCutMode: TRadioGroup
    Left = 874
    Top = 352
    Width = 150
    Height = 73
    Hint = 
      'Cut out: New file is everything except cuts. Crop: NEw file is s' +
      'um of cuts.'
    Anchors = [akTop, akRight]
    Caption = 'Cut Mode'
    ItemIndex = 0
    Items.Strings = (
      'Cut out'
      'Crop')
    ParentShowHint = False
    ShowHint = True
    TabOrder = 16
    OnClick = RCutModeClick
  end
  object BPrev12: TButton
    Left = 744
    Top = 679
    Width = 137
    Height = 25
    Action = Prev12
    Anchors = [akRight, akBottom]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
  end
  object BStepBack: TButton
    Left = 575
    Top = 368
    Width = 33
    Height = 33
    Hint = 'Previous Frame'
    Action = StepBackward
    Anchors = [akTop, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 18
  end
  object BStepForwards: TButton
    Left = 655
    Top = 368
    Width = 33
    Height = 33
    Hint = 'Next Frame'
    Action = StepForward
    Anchors = [akTop, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 19
  end
  object TVolume: TTrackBar
    Left = 623
    Top = 410
    Width = 150
    Height = 45
    Anchors = [akTop, akRight]
    Max = 10000
    Frequency = 1000
    Position = 5000
    TabOrder = 20
    OnChange = TVolumeChange
  end
  object CBMute: TCheckBox
    Left = 783
    Top = 410
    Width = 57
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Mute'
    TabOrder = 21
    OnClick = CBMuteClick
  end
  object BNext12: TButton
    Left = 888
    Top = 679
    Width = 137
    Height = 25
    Action = Next12
    Anchors = [akRight, akBottom]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 22
  end
  object TFinePos: TtrackBarEx
    Left = 40
    Top = 663
    Width = 553
    Height = 45
    Hint = 'Fine Positioning (in Frames)'
    Anchors = [akLeft, akRight, akBottom]
    Enabled = False
    Max = 50
    Min = -50
    ParentShowHint = False
    PageSize = 5
    ShowHint = True
    TabOrder = 23
    OnChange = TFinePosChange
    OnMOuseUp = TFinePosMOuseUp
  end
  object DSTrackBar1: TDSTrackBarEx
    Left = 8
    Top = 615
    Width = 1017
    Height = 33
    Hint = 'Position (Timeline)'
    Anchors = [akLeft, akRight, akBottom]
    Enabled = False
    ParentShowHint = False
    PageSize = 4
    Frequency = 300
    ShowHint = True
    TabOrder = 24
    OnChange = DSTrackBar1Change
    FilterGraph = FilterGraph
    OnTimer = DSTrackBar1Timer
    OnPositionChangedByMouse = DSTrackBar1PositionChangedByMouse
    OnSelChanged = DSTrackBar1SelChanged
    OnChannelPostPaint = DSTrackBar1ChannelPostPaint
  end
  object B12FromTo: TButton
    Left = 629
    Top = 679
    Width = 108
    Height = 25
    Action = ScanInterval
    Anchors = [akRight, akBottom]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 26
  end
  object BConvert: TButton
    Left = 959
    Top = 376
    Width = 57
    Height = 33
    Anchors = [akTop, akRight]
    Caption = 'Convert'
    TabOrder = 27
    OnClick = BConvertClick
  end
  object ActionMainMenuBar1: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 1029
    Height = 28
    UseSystemFont = False
    ActionManager = ActionManager1
    Caption = 'ActionMainMenuBar1'
    ColorMap.HighlightColor = clBtnHighlight
    ColorMap.UnusedColor = 14673125
    ColorMap.SelectedColor = clHighlight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentShowHint = False
    ShowHint = True
    Spacing = 8
  end
  object ActionToolBar1: TActionToolBar
    Left = 0
    Top = 28
    Width = 1029
    Height = 26
    ActionManager = ActionManager1
    Caption = 'ActionToolBar1'
    ColorMap.HighlightColor = clBtnHighlight
    ColorMap.UnusedColor = 14673125
    ColorMap.SelectedColor = clHighlight
    ParentShowHint = False
    ShowHint = True
    Spacing = 5
  end
  object BCutlistInfo: TBitBtn
    Left = 903
    Top = 208
    Width = 73
    Height = 25
    Action = ACutlistInfo
    Anchors = [akTop, akRight]
    Caption = 'Cutlist Info'
    TabOrder = 30
  end
  object PAuthor: TPanel
    Left = 775
    Top = 312
    Width = 233
    Height = 25
    Anchors = [akTop, akRight]
    BevelInner = bvLowered
    TabOrder = 31
    Visible = False
    object LAuthor: TLabel
      Left = 2
      Top = 0
      Width = 229
      Height = 23
      Align = alBottom
      Alignment = taCenter
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Cutlist Author unknown'
      Color = clNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -17
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
  end
  object TBRate: TtrackBarEx
    Left = 623
    Top = 448
    Width = 150
    Height = 33
    Anchors = [akTop, akRight]
    Max = 16
    Min = -24
    PageSize = 8
    Frequency = 8
    TabOrder = 32
    OnChange = TBRateChange
  end
  object BNextCut: TButton
    Left = 823
    Top = 368
    Width = 33
    Height = 33
    Action = ANextCut
    Anchors = [akTop, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 33
  end
  object BPrevCut: TButton
    Left = 783
    Top = 368
    Width = 33
    Height = 33
    Action = APrevCut
    Anchors = [akTop, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 34
  end
  object BFF: TButton
    Left = 695
    Top = 368
    Width = 33
    Height = 33
    Hint = 'Fast Forward (Click and Hold)'
    Anchors = [akTop, akRight]
    Caption = '>>'
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 35
    OnMouseDown = BFFMouseDown
    OnMouseUp = BFFMouseUp
  end
  object CutListOpenDialog: TOpenDialog
    Filter = 'Cut Lists|*.cutlist|All FIles|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Load Cut List'
    Left = 224
    Top = 288
  end
  object FilterGraph: TFilterGraph
    GraphEdit = True
    LinearVolume = True
    OnGraphStepComplete = FilterGraphGraphStepComplete
    OnSelectedFilter = FilterGraphSelectedFilter
    Left = 184
    Top = 328
  end
  object SampleGrabber1: TSampleGrabber
    OnBuffer = SampleGrabber1Buffer
    FilterGraph = FilterGraph
    MediaType.data = {
      7669647300001000800000AA00389B717DEB36E44F52CE119F530020AF0BA770
      000000000000000001000000809F580556C3CE11BF0100AA0055595A00000000
      0000000000000000}
    Left = 264
    Top = 328
  end
  object TeeFilter: TFilter
    BaseFilter.data = {
      C600000037D415438C5BD011BD3B00A0C911CE86B20000004000640065007600
      6900630065003A00730077003A007B0030003800330038003600330046003100
      2D0037003000440045002D0031003100440030002D0042004400340030002D00
      3000300041003000430039003100310043004500380036007D005C007B004600
      38003300380038004100340030002D0044003500420042002D00310031004400
      30002D0042004500350041002D00300030003800300043003700300036003500
      3600380045007D000000}
    Left = 224
    Top = 328
  end
  object NullRenderer1: TFilter
    BaseFilter.data = {
      C600000037D415438C5BD011BD3B00A0C911CE86B20000004000640065007600
      6900630065003A00730077003A007B0030003800330038003600330046003100
      2D0037003000440045002D0031003100440030002D0042004400340030002D00
      3000300041003000430039003100310043004500380036007D005C007B004300
      31004600340030003000410034002D0033004600300038002D00310031004400
      33002D0039004600300042002D00300030003600300030003800300033003900
      4500330037007D000000}
    Left = 304
    Top = 328
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items.HideUnused = False
        Items = <
          item
            Items.HideUnused = False
            Items = <
              item
                Items.HideUnused = False
                Items = <>
                Action = OpenMovie
                Caption = '&Open Movie...'
                ImageIndex = 13
              end
              item
                Action = AStartCutting
                Caption = '&Start Cutting'
                ImageIndex = 8
              end
              item
                Action = APlayInMPlayerAndSkip
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = ARepairMovie
                Caption = '&Repair Movie'
              end
              item
                Action = ACloseMovie
                Caption = '&Close Movie'
              end
              item
                Items.HideUnused = False
                Items = <>
                Caption = '-'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = File_Exit
                Caption = '&Exit'
                ImageIndex = 3
              end>
            Caption = '&File'
          end
          item
            Items.HideUnused = False
            Items = <
              item
                Items.HideUnused = False
                Items = <>
                Action = OpenCutlist
                Caption = '&Open Cutlist...'
                ImageIndex = 14
              end
              item
                Action = ASearchCutlistByFileSize
                Caption = 'S&earch Cutlists on Server'
                ImageIndex = 17
              end
              item
                Items.HideUnused = False
                Items = <>
                Caption = '-'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = SaveCutlistAs
                Caption = '&Save Cutlist As...'
                ImageIndex = 2
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = ASaveCutlist
                Caption = 'S&ave Cutlist'
                ImageIndex = 1
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = CutlistUpload
                Caption = '&Upload Cutlist to Server'
                ImageIndex = 16
              end
              item
                Action = ADeleteCutlistFromServer
                Caption = '&Delete Cutlist from Server'
                ImageIndex = 4
              end
              item
                Items.HideUnused = False
                Items = <>
                Caption = '-'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = ACutlistInfo
                Caption = '&Cutlist Info'
              end
              item
                Action = ACalculateResultingTimes
                Caption = 'C&heck cut Movie'
                ImageIndex = 20
              end
              item
                Action = ASendRating
                Caption = 'Se&nd Rating'
                ImageIndex = 19
              end>
            Caption = '&Cutlist'
          end
          item
            Items.HideUnused = False
            Items = <
              item
                Items.HideUnused = False
                Items = <>
                Action = AddCut
                Caption = '&Add new cut'
                ImageIndex = 5
                ShortCut = 16449
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = ReplaceCut
                Caption = '&Replace selected cut'
                ImageIndex = 7
                ShortCut = 16470
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = EditCut
                Caption = '&Edit selected cut'
                ImageIndex = 6
                ShortCut = 16451
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = DeleteCut
                Caption = '&Delete selected cut'
                ImageIndex = 4
                ShortCut = 46
              end>
            Caption = '&Edit'
          end
          item
            Items.HideUnused = False
            Items = <
              item
                Items.HideUnused = False
                Items = <>
                Action = ShowFramesForm
                Caption = '&Show Form'
                ImageIndex = 9
              end
              item
                Items.HideUnused = False
                Items = <>
                Caption = '-'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = ScanInterval
                Caption = 'S&can Interval'
                ImageIndex = 12
                ShortCut = 16416
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = Prev12
                Caption = '&Previous 12 Frames'
                ImageIndex = 10
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = Next12
                Caption = '&Next 12 Frames'
                ImageIndex = 11
              end>
            Caption = 'F&rames'
          end
          item
            Items.HideUnused = False
            Items = <
              item
                Items.HideUnused = False
                Items = <>
                Action = MovieMetaData
                Caption = '&Movie Meta Data...'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = UsedFilters
                Caption = '&Used Filters...'
              end
              item
                Action = AAsfbinInfo
                Caption = '&Cut Applications...'
              end>
            Caption = '&Info'
          end
          item
            Items.HideUnused = False
            Items = <
              item
                Items.HideUnused = False
                Items = <>
                Action = EditSettings
                Caption = '&Settings...'
              end
              item
                Items.HideUnused = False
                Items = <>
                Caption = '-'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = WriteToRegisty
                Caption = '&Associate with file extensions'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = RemoveRegistryEntries
                Caption = '&Remove registry entries'
              end>
            Caption = '&Options'
          end
          item
            Items.HideUnused = False
            Items = <
              item
                Items.HideUnused = False
                Items = <>
                Action = BrowseWWWHelp
                Caption = '&Internet Help Pages'
                ImageIndex = 15
                ShortCut = 112
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = OpenCutlistHome
                Caption = '&Cutlist Homepage'
              end
              item
                Items.HideUnused = False
                Items = <>
                Caption = '-'
              end
              item
                Items.HideUnused = False
                Items = <>
                Action = About
                Caption = '&About'
              end>
            Caption = '?'
          end>
        ActionBar = ActionMainMenuBar1
      end
      item
        ContextItems.CaptionOptions = coAll
        ContextItems = <>
        Items.CaptionOptions = coNone
        Items = <
          item
            Action = File_Exit
            Caption = '&Exit'
            ImageIndex = 3
          end
          item
            Action = OpenMovie
            Caption = '&Open Movie...'
            ImageIndex = 13
          end
          item
            Action = OpenCutlist
            Caption = 'O&pen Cutlist...'
            ImageIndex = 14
          end
          item
            Action = ASearchCutlistByFileSize
            ImageIndex = 17
          end
          item
            Action = ASaveCutlist
            Caption = 'S&ave Cutlist'
            ImageIndex = 1
          end
          item
            Action = SaveCutlistAs
            Caption = '&Save Cutlist As...'
            ImageIndex = 2
          end
          item
            Action = CutlistUpload
            ImageIndex = 16
          end
          item
            Action = ASendRating
            Caption = 'Send Ratin&g'
            ImageIndex = 19
          end
          item
            Caption = '-'
          end
          item
            Action = ShowFramesForm
            Caption = 'S&how Form'
            ImageIndex = 9
          end
          item
            Action = ScanInterval
            Caption = 'S&can Interval'
            ImageIndex = 12
            ShortCut = 16416
          end
          item
            Action = Prev12
            Caption = 'P&revious 12 Frames'
            ImageIndex = 10
          end
          item
            Action = Next12
            Caption = '&Next 12 Frames'
            ImageIndex = 11
          end
          item
            Caption = '-'
          end
          item
            Action = AStartCutting
            ImageIndex = 8
          end
          item
            Action = ACalculateResultingTimes
            ImageIndex = 20
          end
          item
            Caption = '-'
          end
          item
            Action = BrowseWWWHelp
            Caption = '&Internet Help Pages'
            ImageIndex = 15
            ShortCut = 112
          end>
        ActionBar = ActionToolBar1
      end>
    Images = ImageList1
    Left = 184
    Top = 368
    StyleName = 'Standard'
    object OpenMovie: TAction
      Category = 'File'
      Caption = 'Open Movie...'
      Hint = 'Open movie file...'
      ImageIndex = 13
      OnExecute = OpenMovieExecute
    end
    object OpenCutlist: TAction
      Category = 'Cutlist'
      Caption = 'Open Cutlist...'
      Enabled = False
      Hint = 'Open cutlist file...'
      ImageIndex = 14
      OnExecute = OpenCutlistExecute
    end
    object ASearchCutlistByFileSize: TAction
      Category = 'Cutlist'
      Caption = 'Search Cutlists on Server'
      Enabled = False
      Hint = 'Search matching cutlists on server'
      ImageIndex = 17
      OnExecute = ASearchCutlistByFileSizeExecute
    end
    object SaveCutlistAs: TAction
      Category = 'Cutlist'
      Caption = 'Save Cutlist As...'
      Enabled = False
      Hint = 'Save cutlist as...'
      ImageIndex = 2
      OnExecute = SaveCutlistAsExecute
    end
    object ASaveCutlist: TAction
      Category = 'Cutlist'
      Caption = 'Save Cutlist'
      Hint = 'Save Cutlist'
      ImageIndex = 1
      OnExecute = ASaveCutlistExecute
    end
    object CutlistUpload: TAction
      Category = 'Cutlist'
      Caption = 'Upload Cutlist to Server'
      Enabled = False
      Hint = 'Upload Cutlist to internet'
      ImageIndex = 16
      OnExecute = CutlistUploadExecute
    end
    object AStartCutting: TAction
      Category = 'File'
      Caption = 'Start Cutting'
      Enabled = False
      Hint = 'Start external cut application...'
      ImageIndex = 8
      OnExecute = AStartCuttingExecute
    end
    object APlayInMPlayerAndSkip: TAction
      Category = 'File'
      Caption = 'Play Movie in MPlayer'
      Hint = 'Play Movie in MPlayer and skip at Cuts'
      OnExecute = APlayInMPlayerAndSkipExecute
    end
    object ARepairMovie: TAction
      Category = 'File'
      Caption = 'Repair Movie'
      Hint = 'Repair Movie using external cut application'
      OnExecute = ARepairMovieExecute
    end
    object ACloseMovie: TAction
      Category = 'File'
      Caption = 'Close Movie'
      OnExecute = ACloseMovieExecute
    end
    object File_Exit: TAction
      Category = 'File'
      Caption = 'Exit'
      Hint = 'Exit application'
      ImageIndex = 3
      OnExecute = File_ExitExecute
    end
    object AddCut: TAction
      Category = 'Edit'
      Caption = 'Add new cut'
      Enabled = False
      ImageIndex = 5
      ShortCut = 16449
      OnExecute = AddCutExecute
    end
    object ReplaceCut: TAction
      Category = 'Edit'
      Caption = 'Replace selected cut'
      Enabled = False
      ImageIndex = 7
      ShortCut = 16470
      OnExecute = ReplaceCutExecute
    end
    object EditCut: TAction
      Category = 'Edit'
      Caption = 'Edit selected cut'
      Enabled = False
      ImageIndex = 6
      ShortCut = 16451
      OnExecute = EditCutExecute
    end
    object DeleteCut: TAction
      Category = 'Edit'
      Caption = 'Delete selected cut'
      Enabled = False
      ImageIndex = 4
      ShortCut = 46
      OnExecute = DeleteCutExecute
    end
    object ShowFramesForm: TAction
      Category = 'Frames'
      Caption = 'Show Form'
      Hint = 'Bring frames form to front'
      ImageIndex = 9
      OnExecute = ShowFramesFormExecute
    end
    object Next12: TAction
      Category = 'Frames'
      Caption = 'Next 12 Frames'
      Enabled = False
      Hint = 'Show next 12 frames from current position'
      ImageIndex = 11
      OnExecute = Next12Execute
    end
    object Prev12: TAction
      Category = 'Frames'
      Caption = 'Previous 12 Frames'
      Enabled = False
      Hint = 'Show last 12 frames before current position'
      ImageIndex = 10
      OnExecute = Prev12Execute
    end
    object ScanInterval: TAction
      Category = 'Frames'
      Caption = 'Scan Interval'
      Enabled = False
      Hint = 'Scans selected interval for 12 frames'
      ImageIndex = 12
      ShortCut = 16416
      OnExecute = ScanIntervalExecute
    end
    object EditSettings: TAction
      Category = 'Options'
      Caption = 'Settings...'
      OnExecute = EditSettingsExecute
    end
    object MovieMetaData: TAction
      Category = 'Info'
      Caption = 'Movie Meta Data...'
      Hint = 'Show Meta Data of original movie file...'
      OnExecute = MovieMetaDataExecute
    end
    object BrowseWWWHelp: TAction
      Category = '?'
      Caption = 'Internet Help Pages'
      Hint = 'Browse Internet Help Pages on OTR Wiki'
      ImageIndex = 15
      ShortCut = 112
      OnExecute = BrowseWWWHelpExecute
    end
    object UsedFilters: TAction
      Category = 'Info'
      Caption = 'Used Filters...'
      Hint = 'Show used filters of current FilterGraph'
      OnExecute = UsedFiltersExecute
    end
    object WriteToRegisty: TAction
      Category = 'Options'
      Caption = 'Associate with file extensions'
      Hint = 'Register this application in the Windows(R) Registry'
      OnExecute = WriteToRegistyExecute
    end
    object RemoveRegistryEntries: TAction
      Category = 'Options'
      Caption = 'Remove registry entries'
      OnExecute = RemoveRegistryEntriesExecute
    end
    object StepForward: TAction
      Caption = '>II'
      Enabled = False
      ShortCut = 39
      SecondaryShortCuts.Strings = (
        'l')
      OnExecute = StepForwardExecute
    end
    object StepBackward: TAction
      Caption = 'II<'
      Enabled = False
      ShortCut = 37
      SecondaryShortCuts.Strings = (
        'j')
      OnExecute = StepBackwardExecute
    end
    object OpenCutlistHome: TAction
      Category = '?'
      Caption = 'Cutlist Homepage'
      Hint = 'Open Homepage of Cutlist Server in Browser'
      OnExecute = OpenCutlistHomeExecute
    end
    object About: TAction
      Category = '?'
      Caption = 'About'
      OnExecute = AboutExecute
    end
    object ADeleteCutlistFromServer: TAction
      Category = 'Cutlist'
      Caption = 'Delete Cutlist from Server'
      ImageIndex = 4
      OnExecute = ADeleteCutlistFromServerExecute
    end
    object ACutlistInfo: TAction
      Category = 'Cutlist'
      Caption = 'Cutlist Info'
      Hint = 'Edit Cutlist Info'
      OnExecute = ACutlistInfoExecute
    end
    object ACalculateResultingTimes: TAction
      Category = 'Cutlist'
      Caption = 'Check cut Movie'
      Enabled = False
      Hint = 'Check Cut Movie'
      ImageIndex = 20
      OnExecute = ACalculateResultingTimesExecute
    end
    object AAsfbinInfo: TAction
      Category = 'Info'
      Caption = 'Cut Applications...'
      OnExecute = AAsfbinInfoExecute
    end
    object ASendRating: TAction
      Category = 'Cutlist'
      Caption = 'Send Rating'
      Hint = 'Send Rating to Server'
      ImageIndex = 19
      OnExecute = ASendRatingExecute
    end
    object ANextCut: TAction
      Caption = '>>|'
      Enabled = False
      Hint = 'Next Cut'
      ShortCut = 16423
      OnExecute = ANextCutExecute
    end
    object APrevCut: TAction
      Caption = '|<<'
      Enabled = False
      Hint = 'Previous Cut'
      ShortCut = 16421
      OnExecute = APrevCutExecute
    end
    object AFullScreen: TAction
      Category = 'Window'
      Caption = 'Full Screen'
      ShortCut = 32781
      OnExecute = AFullScreenExecute
    end
    object ASnapshotCopy: TAction
      Category = 'Video'
      Caption = 'Copy Snapshot to Clipboard'
      Hint = 'Copy Snapshot to Clipboard'
      OnExecute = ASnapshotCopyExecute
    end
    object ASnapshotSave: TAction
      Category = 'Video'
      Caption = 'Save Snapshot as...'
      OnExecute = ASnapshotSaveExecute
    end
  end
  object ImageList1: TImageList
    DrawingStyle = dsTransparent
    Left = 224
    Top = 368
    Bitmap = {
      494C010115001800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000006000000001002000000000000060
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FFFF00FFFFFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF656582FF000000FF6565
      82FF656582FF656582FF656582FF656582FF656582FF000000FF656582FF00FF
      FFFF00FFFFFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF6565
      82FF656582FF656582FF656582FF656582FF656582FF000000FF000000FF0000
      00FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF656582FF000000FF6565
      82FF656582FF656582FF656582FF656582FF656582FF000000FF656582FF00FF
      FFFF00FFFFFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF6565
      82FF656582FF656582FF656582FF656582FF656582FF000000FF000000FF00FF
      FFFF00FFFFFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF656582FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF656582FF00FF
      FFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF6565
      82FF656582FF656582FF656582FF656582FF656582FF000000FF000000FF0000
      00FF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF656582FF000000FF6565
      82FF656582FF656582FF656582FF656582FF656582FF000000FF656582FF0000
      00FF0000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF6565
      82FF656582FF656582FF656582FF656582FF00FFFFFF00FFFFFF000000FF0000
      00FF000000000000000000FFFFFF00FFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF656582FF000000FF6565
      82FF656582FF656582FF656582FF656582FF00FFFFFF00FFFFFF00FFFFFF0000
      00FF000000000000000000FFFFFF00FFFFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF6565
      82FF656582FF656582FF656582FF656582FF656582FF00FFFFFF00FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF656582FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF00FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF6565
      82FF656582FF656582FF656582FF656582FF656582FF000000FF000000FF0000
      00FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF656582FF000000FF6565
      82FF656582FF656582FF656582FF656582FF656582FF000000FF656582FF0000
      00FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF6565
      82FF656582FF656582FF656582FF656582FF656582FF000000FF000000FF0000
      00FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF656582FF000000FF6565
      82FF656582FF656582FF656582FF656582FF656582FF000000FF656582FF0000
      00FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ECF1ECFFECF1ECFFECF1ECFFECF1ECFFFCFCFCFFFCFC
      FCFF000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ECF1ECFFECF1ECFFECF1ECFFECF1ECFFFCFCFCFFFCFC
      FCFF000000000000000000000000000000000000000000000000000000000000
      0000F9F9F9FFF6F6F6FFF2F2F2FFF2F2F2FFF2F2F2FFF2F2F2FFF2F2F2FFF2F2
      F2FFF2F2F2FFF2F2F2FFF9F9F9FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D5E6D9FF417441FF266026FF266026FF386D38FF5D895DFFCAD8CAFFDEE7
      DEFFF9FAF9FF0000000000000000000000000000000000000000000000000000
      0000D5E6D9FF417441FF266026FF266026FF386D38FF5D895DFFCAD8CAFFDEE7
      DEFFF9FAF9FF0000000000000000000000000000000000000000F3F3F3FFE6E6
      E6FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1
      E1FFE1E1E1FFE1E1E1FFE7E7E7FFFBFBFBFF000000000000000000000000FFFF
      FF00FFFFFF00C0C0C00000000000000000008080800080808000808080000000
      0000000000000000000000008000000080000000000000000000EDF4EEFF579D
      66FF3B8C4CFF219921FF129212FF129212FF129212FF129212FF094B09FF2A63
      2AFFD1DDD1FFF6F8F6FF00000000000000000000000000000000EDF4EEFF579D
      66FF3B8C4CFF219921FF129212FF129212FF129212FF129212FF094B09FF2A63
      2AFFD1DDD1FFF6F8F6FF000000000000000000000000F3F3F3FF2727FFFF2727
      FFFF2727FFFF2727FFFF2727FFFF2727FFFF2727FFFF2727FFFF2727FFFF2727
      FFFF2727FFFF2727FFFFD8D8D8FFE7E7E7FF0000000000000000000000000000
      000000000000C0C0C000FFFFFF00C0C0C0000000000000000000808080008080
      80008080800000000000000080000000800000000000000000000F7F1CFF14AA
      14FF14AA14FF14AA14FF14AA14FF118F11FF14AA14FF14AA14FF129212FF0F7B
      0FFF094B09FFD1DDD1FFF9FAF9FF0000000000000000000000000F7F1CFF14AA
      14FF14AA14FF14AA14FF14AA14FF14AA14FF14AA14FF14AA14FF129212FF0F7B
      0FFF094B09FFD1DDD1FFF9FAF9FF00000000000000001818FFFF0000FFFF3E3E
      FFFF6E6EFFFF6E6EFFFF6E6EFFFF6E6EFFFF6E6EFFFF6E6EFFFF6E6EFFFF6E6E
      FFFF3E3EFFFF0000FFFF1818FFFFE0E0E0FF0000000000000000FFFFFF00FFFF
      FF00C0C0C0000000000000000000C0C0C000C0C0C0000000000080808000C0C0
      C0008080800000000000000080000000FF00F9FCF9FF319E34FF14AA14FF14AA
      14FF17BF17FF17BF17FF43CB43FFABE8ABFF44CC44FF14AA14FF14AA14FF1292
      12FF0F7B0FFF2A632AFFE3EAE3FFF9FAF9FFF9FCF9FF319E34FF14AA14FF14AA
      14FF17BF17FF17BF17FF23C223FF81DC81FF2BC52BFF14AA14FF14AA14FF1292
      12FF0F7B0FFF2A632AFFE3EAE3FFF9FAF9FF000000001818FFFF0000FFFFBABA
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEAFFEAEAEAFFFFFFFFFFFFFFFFFFFFFF
      FFFFBABAFFFF0000FFFF1818FFFFDBDBDBFF0000000000000000000000000000
      0000FFFFFF00FFFFFF00C0C0C0000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000000000000000FF0000008000D3EAD3FF118F14FF17BF17FF17BF
      17FF18C818FF18C818FFB9EEB9FFE9FAE9FFC0F0C0FF17BF17FF17BF17FF14AA
      14FF129212FF094B09FFCFDCCFFFF3F6F3FFD3EAD3FF118F14FF17BF17FF17BF
      17FF18C818FF18C818FFECFAECFFFFFFFFFF9EE89EFF17BF17FF17BF17FF14AA
      14FF129212FF094B09FFCFDCCFFFF3F6F3FF00000000D8D8FFFF1414FFFF7272
      FFFFFFFFFFFFFFFFFFFFEAEAEAFF525252FF777777FFEAEAEAFFFFFFFFFFFFFF
      FFFF8585FFFF0E0EFFFF9B9BFFFFF5F5F5FF00000000FFFFFF00FFFFFF00C0C0
      C0000000000000000000C0C0C000C0C0C00000000000C0C0C000FFFFFF00FFFF
      FF00C0C0C000000000000000FF000000FF0034AE34FF14AA14FF17BF17FF18C8
      18FF18C818FF18C818FFDBF6DBFFEFFBEFFFDBF6DBFF18C818FF17BF17FF14AA
      14FF14AA14FF129212FF3F733FFFECF1ECFF34AE34FF14AA14FF17BF17FF18C8
      18FF18C818FFEDFBEDFFFFFFFFFFFFFFFFFFFFFFFFFF9FE89FFF17BF17FF14AA
      14FF14AA14FF129212FF3F733FFFECF1ECFF00000000000000004D4DFFFF0000
      FFFFDCDCFFFFFFFFFFFFEAEAEAFFEAEAEAFFEAEAEAFFEAEAEAFFFFFFFFFFDCDC
      FFFF0000FFFF5B5BFFFFCACAFFFFFAFAFAFF000000000000000000000000FFFF
      FF00C0C0C000C0C0C0000000000000000000C0C0C000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000FF000000FF0023B223FF17BF17FF3DD13DFF59D8
      59FF1AC81AFF18C818FFDEF7DEFFFFFFFFFFD8F6D8FF18C818FF19C819FF4ECE
      4EFF23AF23FF129212FF2B642BFFECF1ECFF23B223FF17BF17FF18C818FF18C8
      18FFEDFBEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FE89FFF17BF
      17FF14AA14FF129212FF2B642BFFECF1ECFF0000000000000000DADAFFFF1818
      FFFF7272FFFFDCDCFFFFEAEAEAFF565656FF7F7F7FFFEAEAEAFFE1E1FFFF7272
      FFFF1111FFFFC6C6FFFFF5F5F5FF0000000000000000C0C0C000C0C0C0000000
      0000C0C0C000C0C0C00000000000C0C0C000FFFFFF00FFFFFF00C0C0C000C0C0
      C00000000000000000000000FF000000FF0025C325FF17BF17FFA6EAA6FFCAF2
      CAFFC1F0C1FF1BC91BFFDEF7DEFFFFFFFFFFD8F6D8FF1BC91BFFB8EEB8FFC8F0
      C8FF84D284FF129212FF2B642BFFECF1ECFF25C325FF17BF17FF17BF17FFEDFB
      EDFFFFFFFFFFBBEFBBFFEBFAEBFFFFFFFFFFE6F9E6FFD4F5D4FFFFFFFFFF9EE4
      9EFF13A313FF129212FF2B642BFFECF1ECFF0000000000000000FCFCFFFF7474
      FFFF0000FFFFB2B2FFFFEAEAEAFF474747FF565656FFEAEAEAFFB2B2FFFF0000
      FFFF5B5BFFFFC9C9FFFF000000000000000000000000FFFFFF00C0C0C000C0C0
      C0000000000000000000C0C0C000FFFFFF00FFFFFF00C0C0C000C0C0C0000000
      00000000000000000000000000000000000025C325FF18C818FF21C121FFE9FA
      E9FFFFFFFFFFDDF7DDFFEBFAEBFFFFFFFFFFE6F9E6FFE8FAE8FFFFFFFFFFE8F9
      E8FF13A313FF129212FF2B642BFFF1F5F1FF25C325FF18C818FFC6F1C6FFCAF2
      CAFFC1F0C1FF1BC91BFFF0FBF0FFFFFFFFFF99E799FF1BC91BFFCAF2CAFFC8F0
      C8FF6CCA6CFF129212FF2B642BFFF1F5F1FF000000000000000000000000E7E7
      FFFF2323FFFF4141FFFFC7C7EAFF494949FF646464FFC7C7EAFF5B5BFFFF2323
      FFFFD7D7FFFFEBEBEBFF00000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00C0C0C000000000000000
      00000000000000000000000000000000000036C736FF39C939FF50D050FF18C8
      18FFE9FAE9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9FAE9FF17BF
      17FF14AA14FF129212FF2A632AFFF8FAF8FF36C736FF39C939FF6CD86CFF59D8
      59FF1AC81AFF18C818FFF1FCF1FFFFFFFFFF99E799FF18C818FF3FD13FFF4FCF
      4FFF23AF23FF129212FF2A632AFFF8FAF8FF0000000000000000000000000000
      0000A9A9FFFF0000FFFF7272FFFFD7D7D7FFD7D7D7FF7272FFFF2727FFFF9F9F
      FFFFD9D9FFFFF5F5F5FF00000000000000000000000000000000000000000000
      00000000000000000000C0C0C000FFFFFF00FFFFFF00C0C0C000000000000000
      000000000000000000000000000000000000D4F3D4FF45CC45FF8DE38DFF39C9
      39FF18C818FFE9FAE9FFFFFFFFFFFFFFFFFFFFFFFFFFE9FAE9FF18C818FF17BF
      17FF14AA14FF1D7138FFDDEAE1FF00000000D4F3D4FF45CC45FF8DE38DFF39C9
      39FF18C818FF18C818FFF0FBF0FFEFFBEFFF9AE79AFF18C818FF18C818FF17BF
      17FF14AA14FF1D7138FFDDEAE1FF000000000000000000000000000000000000
      0000F8F8FFFF5B5BFFFF0000FFFFA4A4FFFF8A8AFFFF0000FFFF5B5BFFFFE4E4
      FFFFEBEBEBFF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00C0C0C000000000000000
      0000000000000000000000000000000000000000000054D054FF8DE38DFFA2EA
      A2FF50D050FF39C939FFE8FAE8FFFFFFFFFFE8FAE8FF18C818FF17BF17FF14AA
      14FF14AA14FF3E944AFF00000000000000000000000054D054FF8DE38DFFA2EA
      A2FF50D050FF39C939FFD4F5D4FFE9FAE9FF88E388FF18C818FF17BF17FF14AA
      14FF14AA14FF3E944AFF00000000000000000000000000000000000000000000
      000000000000F1F1FFFF2C2CFFFF0000FFFF0000FFFF2727FFFFE1E1FFFFEBEB
      EBFF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00C0C0C000000000000000
      00000000000000000000000000000000000000000000000000005AD25AFF98E6
      98FFA2EAA2FF64D664FF59D259FFBFEDBFFF2CCD2CFF17BF17FF17BF17FF14AA
      14FF2F9D3AFFE5F1E6FF000000000000000000000000000000005AD25AFF98E6
      98FFA2EAA2FF64D664FF9BE49BFFB8ECB8FF38D038FF17BF17FF17BF17FF14AA
      14FF2F9D3AFFE5F1E6FF00000000000000000000000000000000000000000000
      00000000000000000000E9E9FFFF0000FFFF0000FFFFCECEFFFFEBEBEBFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00C0C0C000000000000000
      00000000000000000000000000000000000000000000000000000000000054D0
      54FF5AD25AFF98E698FFA2EAA2FF8FDF8FFF17BF17FF1EB01EFF20A026FF3AA8
      42FFF1F9F2FF00000000000000000000000000000000000000000000000054D0
      54FF5AD25AFF98E698FFABECABFFA1E4A1FF17BF17FF1EB01EFF20A026FF3AA8
      42FFF1F9F2FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BEBEFFFFBEBEFFFFEBEBEBFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D4F3D4FF45C445FF39C139FF23B726FF1FB723FF3CB63FFFD5EFD6FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D4F3D4FF45C445FF39C139FF23B726FF1FB723FF3CB63FFFD5EFD6FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF00000000FF000000
      FF000000FF00FFFF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F1DDF1FFF1DDF1FFFAF3FAFF000000000000
      00000000000000000000000000000000000000FFFF0000FFFF0000FFFF00FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF00000000FFFF0000FFFF0000FFFF000000000000A9DA0000A3D20000A3
      D200009DCA00009DCA000097C8000097C8000000000000000000000000000000
      0000000000000000000000000000000000000000000000A9DA0000A3D20000A3
      D200009DCA00009DCA000097C8000097C80000000000FFFF0000808000008080
      000080800000FFFF000000000000000000000000000000000000000000000000
      00000000000000000000E6D3E6FF780078FF780078FFCFA8CFFFE6D3E6FFF2E8
      F2FF0000000000000000000000000000000000FFFF0000FFFF0000FFFF00FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF00000000FFFF0000FFFF0000FFFF0000A9DA0000B4E8002DD0FF007BE1
      FF005FDBFF005FDBFF005FDBFF005FDBFF0000000000FFFF00000000FF000000
      FF000000FF00FFFF0000000000000000000000A9DA0000B4E8002DD0FF007BE1
      FF005FDBFF005FDBFF005FDBFF005FDBFF0000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF000000000000000000000000000000000000000000000000
      000000000000FAF3FAFF730073FF730073FFC0A0C0FF7C007CFF7C007CFFCFA8
      CFFFE6D3E6FFF2E8F2FF0000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF00000000000000000000000000000000A9DA0035D2FF0000B4E8007FE2
      FF007BE1FF007BE1FF007BE1FF007BE1FF00000000000000FF000000FF000000
      FF000000FF000000FF00000000000000000000A9DA0035D2FF0000B4E8007FE2
      FF007BE1FF007BE1FF007BE1FF007BE1FF0000000000FFFF0000808000008080
      000080800000FFFF000000000000000000000000000000000000000000000000
      0000FAF3FAFF730073FFB900B9FF730073FFC0A8C0FFF2E8F2FFD0A8D0FF7C00
      7CFF7C007CFFCFA8CFFFE6D3E6FFF2E8F2FF000000000000FF000000FF000000
      FF000000FF00000000000000FF000000FF000000FF000000FF00000000000000
      FF000000FF000000FF000000FF000000000000A9DA0053D9FF0000A9DA0075E0
      FF007BE1FF007BE1FF007BE1FF007BE1FF0000000000FFFF00000000FF000000
      FF000000FF00FFFF0000000000000000000000A9DA0053D9FF0000A9DA0075E0
      FF007BE1FF007BE1FF007BE1FF007BE1FF0000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF00000000000000000000000000000000000000000000FAF3
      FAFF730073FFB900B9FFC851C0FF730073FF730073FFC5AEC5FFC5AEC5FFF2E8
      F2FFD0A8D0FF7C007CFF7C007CFFCFA8CFFF000000000000FF000000FF000000
      FF000000FF00000000000000FF000000FF000000FF000000FF00000000000000
      FF000000FF000000FF000000FF000000000000A9DA007DE2FF0000A9DA0071DF
      FF00ABECFF008BE5FF008BE5FF008BE5FF000000000000000000000000000000
      00000000000000000000000000000000000000A9DA007DE2FF0000A9DA0071DF
      FF00ABECFF008BE5FF008BE5FF008BE5FF000000000000000000000000008080
      000080800000FFFF000000000000000000000000000000000000FAF3FAFF7300
      73FFB900B9FFC851C0FFD07CC4FFD9ADC8FFCF75C3FF730073FF730073FFC6B4
      C6FFC6B4C6FFF2E8F2FFD0A8D0FFAE82AEFF000000000000FF000000FF000000
      FF000000FF00000000000000FF000000FF000000FF000000FF00000000000000
      FF000000FF000000FF000000FF000000000000AEE0008BE5FF0000B4E80057D9
      FF00C5F3FF00ADEFFF00ABECFF00ABECFF0000000000FFFF00000000FF000000
      FF000000FF00FFFF00000000000000A8D80000AEE0008BE5FF0000B4E80057D9
      FF00C5F3FF00ADEFFF00ABECFF00ABECFF0097E8FF000000000000000000FFFF
      0000FFFF0000FFFF00000000000000A8D80000000000FAF3FAFF730073FFB900
      B9FFC851C0FFD07CC4FFD9ADC8FFCF75C3FFC542BFFFC232BDFFB900B9FF7300
      73FF730073FFC6B4C6FFC6B4C6FFF4D8F4FF0000000000000000000000000000
      000000FFFF0000FFFF000000000000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000000000000000000000000000AEE00097E8FF004DD7FF0000B4
      E80097E8FF00C7F2FF00C7F2FF00C5F2FF00000000000000FF000000FF000000
      FF000000FF000000FF000000FF0000A8D80000AEE00097E8FF004DD7FF0000B4
      E80097E8FF00C7F2FF00C7F2FF00C5F2FF00C5F2FF00AFEDFF00000000000000
      000000000000000000000000000000A8D800FAF3FAFF730073FFB900B9FFC851
      C0FFD07CC4FFD9ADC8FFCF75C3FFC542BFFFC232BDFFB900B9FFB900B9FFB900
      B9FFB900B9FF730073FF730073FFF4D8F4FF000000000000FF000000FF000000
      FF0000FFFF0000FFFF000000FF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000FF000000FF000000000000AEE000A7EDFF008BE5FF0000A9
      DA0041D5FF0071DFFF00B7EFFF00B7EFFF00B7EFFF00B7EFFF00B7EFFF00AFEA
      F500168025007ADDF50033D1FF0000A8D80000AEE000A7EDFF008BE5FF0000A9
      DA0041D5FF0071DFFF00B7EFFF00B7EFFF00B7EFFF00B7EFFF00B7EFFF00AFEA
      F500168025007ADDF50033D1FF0000A8D800730073FFC851C0FFC851C0FFD07C
      C4FFD9ADC8FFCF75C3FFC542BFFFC232BDFFB900B9FFB900B9FFB900B9FFB900
      B9FFB900B9FFB900B9FFAF00AFFF9B009BFF000000000000FF000000FF000000
      FF0000FFFF0000FFFF000000FF000000FF0000FFFF0000FFFF00000000000000
      FF000000FF000000FF000000FF000000000000AEE000C7F4FF00BFF1FF0085E4
      FF0000BCF20000B6EA0000B7EC0000B6EA0000B6EA0000B1E40001AFDE001680
      25001B9A2D001680250001A4CE000000000000AEE000C7F4FF00BFF1FF0085E4
      FF0000BCF20000B6EA0000B7EC0000B6EA0000B6EA0000B1E40001AFDE001680
      25001B9A2D001680250001A4CE0000000000730073FFD07CC4FFD07CC4FFD9AD
      C8FFCF75C3FFC542BFFFC232BDFFB900B9FFB900B9FFB900B9FFB900B9FFB900
      B9FFB900B9FFAF00AFFF9A009AFFE0B4E0FF000000000000FF000000FF000000
      FF0000FFFF0000FFFF000000FF000000FF000000FF0000FFFF0000FFFF000000
      FF000000FF000000FF000000FF000000000000AEE00081E3FF00E3F9FF00E3F9
      FF00D3F6FF00B4E3DB00A5D9CA00D3F6FF00D3F6FF00CDF2F800168025001B9E
      2D001DA52F001B9A2D00168025000000000000AEE00081E3FF00E3F9FF00E3F9
      FF00D3F6FF00B4E3DB00A5D9CA00D3F6FF00D3F6FF00CDF2F800168025001B9E
      2D001DA52F001B9A2D001680250000000000730073FFD07CC4FFD9ADC8FFCF75
      C3FFC542BFFFC232BDFFB900B9FFB900B9FFB900B9FFB900B9FFB900B9FFB900
      B9FFAF00AFFF9A009AFFE0B4E0FF000000000000000000000000000000000000
      000000FFFF0000FFFF000000000000000000000000000000000000FFFF0000FF
      FF00000000000000000000000000000000000000000000AEE00089E5FF00EFFD
      FF00E3F9FF00C1E5DB001680250003A8C80000AEE000118B530016802500188A
      28001DA83000188A280016802500168025000000000000AEE00089E5FF00EFFD
      FF00E3F9FF00C1E5DB001680250003A8C80000AEE000118B530016802500188A
      28001DA83000188A28001680250016802500730073FFD9ADC8FFCF75C3FFC542
      BFFFC232BDFFB900B9FFB900B9FFB900B9FFB900B9FFB900B9FFB900B9FFAF00
      AFFF9A009AFFE0B4E0FF0000000000000000000000000000FF000000FF000000
      FF0000FFFF0000FFFF000000FF000000FF000000FF000000FF000000000000FF
      FF0000FFFF000000FF000000FF0000000000000000000000000000AEE00000AE
      E00000AEE00004A2BC0016802500168025000000000000000000000000001680
      25001EAB3100168025000000000000000000000000000000000000AEE00000AE
      E00000AEE00004A2BC0016802500168025000000000000000000000000001680
      25001EAB3100168025000000000000000000D6B2D6FF7C007CFF800080FFA600
      A6FFB400B4FFB900B9FFB900B9FFB900B9FFB900B9FFB900B9FFAF00AFFF9A00
      9AFFE0B4E0FF000000000000000000000000000000000000FF000000FF0000FF
      FF0000FFFF0000FFFF000000FF0000FFFF0000FFFF000000FF000000000000FF
      FF0000FFFF000000FF000000FF00000000000000000000000000000000000000
      000000000000000000001680250021BE38001B9D2D0016802500168025001EAE
      32001EAA31001680250000000000000000000000000000000000000000000000
      000000000000000000001680250021BE38001B9D2D0016802500168025001EAE
      32001EAA3100168025000000000000000000F8EEF8FFF0DBF0FFD6B2D6FF7C00
      7CFF800080FFA600A6FFB400B4FFB900B9FFB900B9FFAF00AFFF9A009AFFE0B4
      E0FF00000000000000000000000000000000000000000000FF000000FF000000
      FF0000FFFF0000FFFF000000FF000000FF0000FFFF0000FFFF0000FFFF0000FF
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      00000000000000000000000000001A962B001DA6300020BC360020B936001FB0
      3300168025000000000000000000000000000000000000000000000000000000
      00000000000000000000000000001A962B001DA6300020BC360020B936001FB0
      3300168025000000000000000000000000000000000000000000F8EEF8FFF0DB
      F0FFD6B2D6FF800080FF800080FFA600A6FFAB00ABFF9A009AFFE0B4E0FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001680250016802500168025001680
      2500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001680250016802500168025001680
      2500000000000000000000000000000000000000000000000000000000000000
      0000F8EEF8FFF0DBF0FFD6B2D6FF800080FF9A009AFFE0B4E0FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F8E0E0FFF8E0E0FFF8E0E0FFF0F0F0FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000E6E6E6FFF6C1C1FFE43F3FFFDC0000FFE43F3FFFECADADFFECECECFF0000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF000000000000000000000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      000035309FFFDF3A3AFFEA6D6DFFF6C1C1FFEA6D6DFFE43F3FFFF8E0E0FF0000
      00000000000000000000000000000000000000000000FFFF00000000FF000000
      FF000000FF00FFFF00000000FF000000FF000000FF00FFFF00000000FF000000
      FF000000FF00FFFF0000FFFF0000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000050099FFDC0000FFD49B9BFFFEFCFCFFF6C1C1FFDC0000FFF8E0E0FF0000
      0000B0B0B0FF19199EFF000094FF0000000000000000FFFF00000000FF000000
      FF000000FF00FFFF00000000FF000000FF000000FF00FFFF00000000FF000000
      FF000000FF00FFFF0000FFFF00000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000000000
      00000500A6FFB5102DFFCF5252FFECADADFFEA6D6DFFE43F3FFFFEF9F9FFCDA7
      A7FF26007CFF200088FFCACACAFFF5F5F5FF00000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF00000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000000000
      000000000000350081FFBF1A33FFDC0000FFE43F3FFFF6C1C1FFE2ADADFFA500
      2DFFDC0000FFDE3939FFD7C1C1FFE8E8E8FF00000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000000000000000000000FFFF0000FFFF0000FF
      FF000000FF00000000000000FF000000FF000000FF000000FF00000000000000
      FF000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      FF000000FF00000000000000FF000000FF000000FF000000FF00000000000000
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      000000000000191985FF3E3E3EFFBEB9B9FFFEF9F9FFE5E0E0FFA50034FF7400
      44FFE2ADADFFEA6D6DFFE43F3FFFEAD6D6FF00000000FFFF00000000FF000000
      FF000000FF00FFFF00000000FF000000FF000000FF00FFFF00000000FF000000
      FF000000FF00FFFF0000FFFF000000000000000000000000FF0000FFFF0000FF
      FF0000FFFF00000000000000FF000000FF000000FF000000FF00000000000000
      FF000000FF000000FF000000FF0000000000000000000000FF000000FF000000
      FF000000FF00000000000000FF000000FF000000FF000000FF000000000000FF
      FF0000FFFF0000FFFF000000FF00000000000000000000000000000000000000
      000000000000222274FF30305BFF00000000C1C1C1FF3400A0FFDC0000FFC57D
      7DFFF8E2E2FFF6C1C1FFDC0000FFEAD1D1FF00000000FFFF00000000FF000000
      FF000000FF00FFFF00000000FF000000FF000000FF00FFFF00000000FF000000
      FF000000FF00FFFF0000FFFF00000000000000000000000000000000000000FF
      FF0000FFFF00000000000000000000FFFF0000FFFF000000FF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000FFFF0000FFFF000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000D1D1D1FF3E3E3EFF1313A1FF1F1F85FF3E3E3EFF3E3E3EFFDB3636FFBA4C
      4CFFD38B8BFFCC5858FFE43F3FFFEAD6D6FF00000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF000000000000000000000000FF000000FF000000
      FF000000FF00000000000000FF0000FFFF0000FFFF000000FF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000FFFF0000FFFF000000
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      FF000000FF000000FF000000FF0000000000BFBFBFFFA9A9A9FF888888FF5050
      50FF454545FF3E3E3EFF3E3E3EFF2C2C69FF1E1E92FF3434C9FFD19C9CFFE43F
      3FFFDC0000FFE43F3FFFF6C1C1FFF3F3F3FF00000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF000000000000000000000000FF000000FF000000
      FF000000FF00000000000000FF0000FFFF0000FFFF000000FF000000000000FF
      FF0000FFFF000000FF000000FF00000000000000000000FFFF0000FFFF000000
      FF000000FF0000FFFF0000FFFF000000FF000000FF000000FF00000000000000
      FF000000FF000000FF000000FF00000000007A7A7AFF5E5E5EFF505050FF8888
      88FF454545FFAEAEAEFF0F0FB7FF00000000000000000000000000000000CEC9
      C9FFFEF9F9FFFDFAFAFFFBFBFBFF0000000000000000FFFF00000000FF000000
      FF000000FF00FFFF00000000FF000000FF000000FF00FFFF00000000FF000000
      FF000000FF00FFFF0000FFFF000000000000000000000000FF000000FF000000
      FF000000FF00000000000000FF0000FFFF0000FFFF000000FF00000000000000
      FF0000FFFF0000FFFF000000FF00000000000000000000FFFF0000FFFF000000
      FF000000FF000000000000FFFF0000FFFF000000FF000000FF00000000000000
      FF000000FF000000FF000000FF0000000000DDDDDDFFF3F3F3FFF8F8F8FF7B7B
      7BFF454545FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF00000000FF000000
      FF000000FF00FFFF00000000FF000000FF000000FF00FFFF00000000FF000000
      FF000000FF00FFFF0000FFFF0000000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000D3D3D3FF5050
      50FF3C3C70FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF000000000000000000000000FF000000FF000000
      FF000000FF00000000000000FF0000FFFF0000FFFF000000FF00000000000000
      FF000000FF000000FF0000FFFF0000FFFF000000000000FFFF0000FFFF000000
      FF000000FF00000000000000FF000000FF0000FFFF0000FFFF00000000000000
      FF000000FF000000FF000000FF00000000000000000000000000373798FF5E5E
      5EFF7373A7FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF00000000000000000000000000FF000000FF000000
      FF000000FF000000000000FFFF0000FFFF0000FFFF000000FF0000FFFF0000FF
      FF000000FF000000FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      FF0000FFFF0000FFFF000000FF000000FF0000FFFF0000FFFF00000000000000
      FF000000FF000000FF000000FF00000000000000000000000000696985FF8B8B
      A0FFE7E7EDFF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF0000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FFFF
      0000FF000000FFFF0000FF00000000000000000000000000FF000000FF000000
      FF000000FF00000000000000FF0000FFFF0000FFFF000000FF000000000000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000FFFF0000FFFF000000
      FF000000FF0000FFFF0000FFFF0000FFFF0000FFFF000000FF00000000000000
      FF000000FF000000FF000000FF0000000000E5E5E5FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000FFFF0000FFFF000000000000000000000000000000000000FFFF000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E5E5E5FFE5E5E5FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FEFEFEFFFCFCFCFFFBFBFBFFFBFBFBFFF7F7F7FFF7F7
      F7FFF7F7F7FFF7F7F7FFF7F7F7FFFBFBFBFF000000000000000000000000F0F0
      F0FF40CA6DFF40CA6DFFE6E6E6FF000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E8E8F4FF1A1A99FF1A1A
      99FFEAEAEAFF0000000000000000000000000000000000000000000000000000
      000000000000E5E5E5FF3131A3FF3F3FA9FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EBE6DFFFE5DFD7FFE3DACFFFDED6CAFFD3C7B7FFD3C7B7FFD3C7
      B7FFD3C7B7FFD3C7B7FFE0D7CCFFF3F3F3FF0000000000000000F0F0F0FF40CA
      6DFF16E723FF04C631FF34C764FFE6E6E6FF0000000000000000000000000000
      000000000000000000000000000000000000000000001A1A99FF00009DFF0000
      9DFF3131A3FFECECECFF00000000000000000000000000000000000000000000
      0000E5E5E5FF6A6ABCFF00008EFF1A1A99FF0000000000000000000000000000
      00000000000000000000F3F3F3FFF3F3F3FFF3F3F3FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7F7F7FFFF9F15FFFF9F15FFFF9F15FFFF9F15FFFF9F15FFFF9F15FFFF9F
      15FFFF9F15FFFF9F15FFD3C7B7FFF3F3F3FF000000000000000040CA6DFF0AC9
      39FF16E723FF16E723FF04C631FF67D58BFFE6E6E6FF00000000000000000000
      000000000000000000000000000000000000000000003131A3FF00009DFF0000
      9DFF00009DFFA8A8A8FFF3F3F3FF000000000000000000000000000000000000
      0000B9B9B9FF1A1AA6FF00009DFFE5E5E5FF0000000000000000000000000000
      000000000000E9E9E9FF4C810EFF4C810EFF4C810EFFE9E9E9FF000000000000
      0000000000000000000000000000000000000000000000000000FAFAFAFFF8F8
      F8FFF1F1F1FFFFBF6BFFFEDDBBFFFEDDBBFFFEDAB5FFFED7B0FFFED7B0FFFED4
      ABFFFED2A6FFFFB85DFFD3C7B7FFF3F3F3FF00000000EEEEEEFF36C766FF27EF
      3EFF1EEB30FF1EEB30FF16E723FF3ECA6CFFDADADAFF00000000000000000000
      00000000000000000000000000000000000000000000DCDCEFFF4646B7FF0000
      AAFF0000AAFF3F3FB5FFC1C1C1FF00000000000000000000000000000000E5E5
      E5FF0000AAFF0000AAFFE5E5E5FF000000000000000000000000000000000000
      000000000000E9E9E9FF4C810EFF4C810EFF4C810EFFDCDCDCFF000000000000
      00000000000000000000000000000000000000000000EEEBE8FFDCD5CCFFDED6
      CBFFDBD2C7FFF1BB72FFF1BC73FFF1BC73FFF1BC73FFF1BC73FFEEC9A1FFFED7
      B0FFFED4ABFFFFB85DFFD3C7B7FFF3F3F3FFF7F7F7FF3BC969FF1DCD4DFF30F3
      4CFF16D73EFF00B93DFF1EEB30FF0CD32EFF6DD68FFFE6E6E6FF000000000000
      0000000000000000000000000000000000000000000000000000E9E9F6FF4646
      C1FF0000AAFF0000AAFF6A6ACDFFE9E9E9FF0000000000000000E5E5E5FF0000
      B7FF0000B7FFE5E5E5FF00000000000000000000000000000000000000000000
      000000000000E9E9E9FF4C810EFF4C810EFF4C810EFFDCDCDCFF000000000000
      000000000000000000000000000000000000EAEAEAFFFF9F15FFFF9F15FFFF9F
      15FFFF9F15FFFF9F15FFFF9F15FFFF9F15FFFF9F15FFFF9F15FFE1BC91FFFED7
      B0FFFED7B0FFFFB960FFD3C7B7FFF3F3F3FFE0E0E0FF1AC050FF38F75AFF30F3
      4CFF15BE4CFF50CE79FF27EF3EFF1EEB30FF31C662FFDADADAFF000000000000
      0000000000000000000000000000000000000000000000000000FAFAFDFFECEC
      F7FF0000AAFF0000B7FF2C2CC3FFBDBDBDFF00000000E5E5E5FF0000D2FF0000
      C5FFE5E5E5FF0000000000000000000000000000000000000000F3F3F3FFDCDC
      DCFFDCDCDCFFD6D6D6FF4C810EFF518A0FFF4C810EFFDCDCDCFFDCDCDCFFDCDC
      DCFFDCDCDCFFEFEFEFFF0000000000000000EEEEEEFFFFBF6BFFFEDDBBFFFEDD
      BBFFFEDAB5FFFED7B0FFFED7B0FFFED4ABFFFED2A6FFFFB85DFFE1BF9BFFFEDD
      BBFFFEDDBBFFFFBC65FFD3C9BBFFF3F3F3FF40CA6DFF1AD44EFF41FC68FF1FDC
      4DFF62D387FFE6E6E6FF26C359FF27EF3EFF11D536FF6DD68FFFE6E6E6FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ECECFAFF0000B7FF0000C5FF1A1AD6FFCECECEFF0000D2FF1A1AD6FFE5E5
      E5FF0000000000000000000000000000000000000000F6F6F6FF4C810EFF4C81
      0EFF4C810EFF4C810EFF4C810EFF55900FFF4C810EFF4C810EFF4C810EFF4C81
      0EFF4C810EFFDCDCDCFF0000000000000000EEEEEEFFFFC06EFFFEDFC1FFFEDF
      C1FFFEDDBBFFFEDAB5FFFEDAB5FFFED7B0FFFED4ABFFFFB85DFFE1C29FFFFEDF
      C1FFFEDDBBFFFFBE68FFD7CEC1FF0000000040CA6DFF48FF73FF48FF73FF40CA
      6DFFE8E8E8FF000000004CCD76FF13D143FF27EF3EFF31C662FFDADADAFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ECECFAFF0000D2FF0000D2FF0000DEFF3131E4FFD9D9D9FFF4F4
      F4FF0000000000000000000000000000000000000000F6F6F6FF4C810EFF5794
      10FF559110FF55900FFF55900FFF55900FFF518A0FFF518A0FFF518A0FFF518A
      0FFF4C810EFFDCDCDCFF0000000000000000EEEEEEFFFFC06EFFFEE2C7FFFEDF
      C1FFFEDDBBFFFEDDBBFFFEDAB5FFFED7B0FFFED7B0FFFFB960FFE1C4A4FFFEE2
      C7FFFEDFC1FFFFBF6BFFE6E0D9FF00000000F7F7F7FF40CA6DFF28E05BFF75D9
      96FFF6F6F6FF00000000EEEEEEFF24C258FF30F34CFF16D73EFF6DD68FFFE6E6
      E6FF000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ECECFAFF0000DEFF0000E5FF3333EAFFCECECEFF0000
      00000000000000000000000000000000000000000000F6F6F6FF4C810EFF4C81
      0EFF4C810EFF4C810EFF4C810EFF55900FFF4C810EFF4C810EFF4C810EFF4C81
      0EFF4C810EFFDCDCDCFF0000000000000000EEEEEEFFFFC373FFFEE8D2FFFEE5
      CDFFFEE2C7FFFEE2C7FFFEDFC1FFFEDDBBFFFEDDBBFFFFBC65FFE1C9ACFFFAB8
      60FFF5BD83FFF6B677FFF0EBE6FF0000000000000000F6F6F6FFAAE7BEFF0000
      00000000000000000000000000004CCD76FF1FDC4DFF30F34CFF31C662FFDADA
      DAFF000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000DEFF3E3EEBFF6D6DF4FF0000ECFF3131EFFFCECE
      CEFF000000000000000000000000000000000000000000000000F7F7F7FFF2F2
      F2FFF2F2F2FFE5E5E5FF4C810EFF55900FFF4C810EFFCFCFCFFFEFEFEFFFEFEF
      EFFFEFEFEFFFF6F6F6FF0000000000000000EEEEEEFFFFC576FFFEEBD8FFFEE8
      D2FFFEE5CDFFFEE2C7FFFEE2C7FFFEDFC1FFFEDDBBFFFFBE68FFE6CDB2FFFABB
      66FFFDE7D2FFFFD9A6FFF7F7F7FF000000000000000000000000000000000000
      0000000000000000000000000000EEEEEEFF24C258FF38F75AFF1BDA45FF6DD6
      8FFFE6E6E6FF0000000000000000000000000000000000000000000000000000
      0000F6F6FDFF0000DEFF6D6DF0FFEBEBFCFFEDEDFDFF9090F9FF3E3EF5FF0000
      F3FFCECECEFF0000000000000000000000000000000000000000000000000000
      000000000000E5E5E5FF4C810EFF579410FF4C810EFFCFCFCFFF000000000000
      000000000000000000000000000000000000EEEEEEFFFFC679FFFEEBD8FFFEEB
      D8FFFEE8D2FFFEE5CDFFFEE5CDFFFEE2C7FFFEDFC1FFFFBF6BFFEBBD7FFFFFD1
      94FFFFDAA8FFF6ECDEFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000005AD181FF24DF55FF38F75AFF31C6
      62FFDADADAFF000000000000000000000000000000000000000000000000C1C1
      F4FF0000D2FF6D6DECFFEDEDFDFFF6F6FEFF00000000F6F6FEFFC1C1FCFF6D6D
      F8FF0000F3FFCECECEFF00000000000000000000000000000000000000000000
      000000000000E5E5E5FF4C810EFF599710FF4C810EFFCFCFCFFF000000000000
      000000000000000000000000000000000000EEEEEEFFFFC97FFFFFF1E4FFFFF1
      E4FFFFEEDEFFFEEBD8FFFEEBD8FFFAB860FFF5BD83FFF6B677FFD4CDC5FFD9D9
      D9FFF7F7F7FF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ECECECFF2AC45CFF41FC68FF24DF
      55FF6DD68FFFE6E6E6FF000000000000000000000000000000000000D2FF3E3E
      DCFF9090EBFFF6F6FDFF00000000000000000000000000000000F6F6FEFFE5E5
      FDFF3E3EF5FF0000ECFFCECECEFFF2F2F2FF0000000000000000000000000000
      000000000000E5E5E5FF4C810EFF4C810EFF4C810EFFDCDCDCFF000000000000
      000000000000000000000000000000000000EEEEEEFFFFC97FFFFFF4EAFFFFF1
      E4FFFFEEDEFFFFEEDEFFFEEBD8FFFABC69FFFDE7D2FFFFD9A6FFE5E5E5FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005AD181FF28E05BFF41FC
      68FF31C662FFDADADAFF0000000000000000000000002F2FDAFF6D6DE5FFC1C1
      F6FFF6F6FDFF000000000000000000000000000000000000000000000000F6F6
      FEFFEEEEFEFF9292F9FF3E3EEBFFF2F2F2FF0000000000000000000000000000
      00000000000000000000E9E9E9FFE9E9E9FFE9E9E9FFFCFCFCFF000000000000
      000000000000000000000000000000000000EEEEEEFFFFE3BDFFFFCB82FFFFC9
      7FFFFFC87CFFFFC87CFFFFC679FFFFD194FFFFDEB1FFF4EFE9FFF9F9F9FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000040CA6DFF48FF
      73FF28E05BFF80DC9EFF000000000000000000000000FBFBFBFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EEEEEEFFEEEEEEFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCFCFCFFF3F3F3FFF3F3F3FFF3F3
      F3FFF3F3F3FFF3F3F3FFF3F3F3FFFEFEFEFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000027C3
      5AFF24C258FF00000000000000000000000000000000EDEDEDFFCCCCCDFFB5B5
      B6FFB3B3B4FFB3B3B4FFA6A6A7FFA0A0A1FFA0A0A1FFACACADFFAEAEAFFFAEAE
      AFFFB1B1B2FFC1C1C2FF000000000000000000000000F8F8F8FFEEEEEEFFE0E0
      E0FFDEDEDEFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFD8D8D8FFD8D8
      D8FFDBDBDBFFDBDBDBFFE4E4E4FFFBFBFBFF00000000F8F8F8FFEEEEEEFFE0E0
      E0FFDEDEDEFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFDDDDDDFFD8D8D8FFD8D8
      D8FFDBDBDBFFDBDBDBFFE4E4E4FFFBFBFBFF0000000000000000000000000000
      00000000000000000000CECECEFFC6C6C6FFC6C6C6FFD5D5D5FF000000000000
      000000000000000000000000000000000000F7F7F7FF09ABDAFF00A3D2FF00A3
      D2FF009DCAFF009DCAFF0097C8FF0097C8FF0097C8FF008FBEFF008FBEFF008F
      BEFF008CBAFF02A7D7FFCEA8B7FF0000000000000000E8E8E8FFD96A84FFC6AA
      B2FFCB96A3FFD79CABFFE1A1B0FFE0D0D5FFDDCCD0FFD9C6CBFFD55D79FFD55D
      79FFAF3F5AFFD6617CFFEDB8C5FFE8E8E8FF00000000E8E8E8FF34B71FFFACAE
      ACFF9CB397FFA1C29BFFA4CF9EFFCDCFCCFFC8CAC8FFC3C5C3FF28C30FFF28C3
      0FFF24A70FFF2DC515FFA2E597FFE8E8E8FF0000000000000000000000000000
      0000C08E9AFFC28695FFDC0049FFDD4476FFB89AA1FFC5B4B9FF000000000000
      00000000000000000000000000000000000009ABDAFF09B1E4FF2FCEFDFF7BE1
      FFFF5FDBFFFF5FDBFFFF5FDBFFFF5FDBFFFF5FDBFFFF5FDBFFFF5FDBFFFF5FDB
      FFFF03C7FFFF00A6D6FF6F5871FFD9D9D9FFF0F0F0FFDC7890FFD6607CFFC9AF
      B6FFD0627CFFCD7388FFD5A3B0FFEEE4E8FFDFCED3FFDBC9CEFFD35371FFD353
      71FFAA3350FFD35371FFD7647FFFE1E1E1FFF0F0F0FF35AF21FF18A900FFAFB1
      AFFF70B664FF7DB375FFA6BFA1FFDCDFDBFFCACDC9FFC5C7C5FF1BC000FF1BC0
      00FF17A200FF1BC000FF32C61AFFE1E1E1FF000000000000000000000000BFA1
      A8FFDA0C4FFFDC0049FFEF1A5FFFF82065FFDC336AFFC6B6BBFF000000000000
      00000000000000000000000000000000000008A5D6FF37CFFDFF07AEE2FF7FE1
      FEFF7BE1FFFF7BE1FFFF7BE1FFFF7BE1FFFF7BE1FFFF7BE1FFFF7BE1FFFF7BE1
      FFFF1BCCFFFF00C4FCFF2984ABFFC0C5C6FFD05978FFD35476FFD76480FFCFB7
      C0FFD1647FFFCD7087FFC8909EFFD6C2C9FFEEE4E8FFDFCED3FFD35371FFD353
      71FFAA3350FFD35371FFD55B78FFDDDDDDFF2B9E18FF169C00FF17A400FFB6B8
      B6FF73B765FF7DB472FF96AF91FFC0C1BFFFDCDFDBFFCACDC9FF1BC000FF1BC0
      00FF17A200FF1BC000FF26C30DFFDDDDDDFF00000000D15375FFBB385DFFDA15
      56FFEB1E60FFFF3A78FFFF3072FFF8276AFFDC0049FFB2A5A9FFA9425AFFA942
      5AFF882940FFC54D69FF000000000000000008A4D5FF53D8FEFF09A3D4FF76DE
      FEFF7BE1FFFF7BE1FFFF7BE1FFFF7BE1FFFF7BE1FFFF7BE1FFFF7BE1FFFF7BE1
      FFFF2BD0FFFF0FC9FFFF189ECCFF9FB2B7FFC53F64FFCC486AFFD35476FFD2BC
      C3FFD26680FFCF758BFFC68C9BFFC4A8B0FFD6C2C9FFEEE4E8FFD35371FFD353
      71FFAA3350FFD35371FFD55B78FFDDDDDDFF21990EFF159400FF169C00FFBABC
      BAFF75B868FF81B676FF93AC8EFFA9ABA9FFC0C1BFFFCED1CDFF1BC000FF1BC0
      00FF17A200FF1BC000FF26C30DFFDDDDDDFF00000000BB4261FFDE1454FFF333
      70FFFF4D84FFFF447EFFFF3A78FFFF3072FFDC0049FF9E9E9EFF9E9E9EFF9E9E
      9EFF9E9E9EFFA89095FFCC5773FF0000000007A4D4FF7DE2FFFF09A3D4FF72DE
      FEFFABECFFFF8BE5FFFF8BE5FFFF8BE5FFFF8BE5FFFF8BE5FFFF8BE5FFFF8BE5
      FFFF33D1FFFF2BD0FFFF10A1CFFF8CADB6FFB63052FFC2345BFFCC486AFFD7B8
      C1FFD26781FFD2788EFFCC95A3FFC1A3ACFFC4A8B0FFD6C2C9FFD35371FFC33F
      5EFFAA3350FFD35371FFD55B78FFDDDDDDFF159400FF159400FF159400FFB7C2
      B4FF76B969FF83B979FF9AB395FFA5A7A5FFA9ABA9FFC0C1BFFF1BC000FF19B4
      00FF17A200FF1BC000FF26C30DFFDDDDDDFF00000000B23054FFE41758FFF847
      7EFFFF4D84FFFF4D84FFFF447EFFFF3A78FFDC0049FF00DC49FF00DC49FF00B9
      3DFF00B93DFF9E9E9EFFC75570FF0000000007A9DAFF8BE5FFFF09AEE2FF59D6
      FDFFC5F3FFFFADEFFFFFABECFFFFABECFFFF97E8FFFF97E8FFFF97E8FFFF97E8
      FFFF25CEFFFF4BD7FFFF02A7D7FF61A3B6FFBF3558FFB63052FFC2345BFFE792
      A6FFD7B8C1FFD2ABB5FFD099A8FFC9AFB6FFC1A3ACFFCA9EAAFFB83455FFB834
      55FFBB3859FFD35371FFD55B78FFDDDDDDFF169C00FF159400FF159400FF96C2
      8EFFB7C2B4FFADBCAAFFB1C3ADFFAFB1AFFFA5A7A5FFA2B29EFF17A200FF17A2
      00FF19B400FF1BC000FF26C30DFFDDDDDDFF00000000A72C4BFFEB2E67FFFD5C
      8CFFFF578AFFFF4D84FFFF447EFFFF447EFFDC0049FF00B93DFF00DC49FF00DC
      49FF00B93DFF9E9E9EFFC75570FF0000000008A9DBFF97E8FFFF4FD4FDFF0AB0
      E4FF97E8FFFFC7F2FFFFC7F2FFFFC5F2FFFFC5F2FFFFAFEDFFFFAFEDFFFFAFED
      FFFF2BD0FFFF97E8FFFF29CFFFFF1696BBFFC1385AFFBF3558FFB63052FFC438
      5EFFCC486AFFD55C79FFDA7089FFD76480FFD45674FFD35371FFD35371FFD353
      71FFD35371FFD35371FFD55B78FFDDDDDDFF17A300FF169C00FF159400FF1594
      00FF159400FF169C00FF17A400FF18A900FF19AE00FF1BC000FF1BC000FF1BC0
      00FF1BC000FF1BC000FF26C30DFFDDDDDDFF00000000AF3151FFEB2E67FFFF61
      90FFFF6190FFFF578AFFFD6997FFFE4C83FFDC0049FF00B93DFF00DC49FF00DC
      49FF00DC49FF9E9E9EFFC75570FF0000000008A9DBFFA7EDFFFF8BE3FEFF0AA6
      D7FF41D5FFFF71DFFFFFB7EFFFFFB7EFFFFFB7EFFFFFB7EFFFFFB7EFFFFFA7E7
      EDFF168025FF7BDAF1FF33D1FFFF02A8D8FFC33B5DFFC1385AFFDBA8B7FFE8DC
      E2FFE8DDE2FFE8DDE2FFE8DDE2FFE8DDE2FFE8DDE2FFE8DDE2FFE8DDE2FFE8DD
      E2FFE1B2BFFFD35371FFD55B78FFDDDDDDFF18A800FF17A300FFABC6A4FFD6D6
      D6FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6D6FFD6D6
      D6FFB2CEACFF1BC000FF26C30DFFDDDDDDFF00000000B13353FFEB2E67FFFF6A
      95FFFF6190FFFB87ABFFF2F2F2FFFD5C8EFFDC0049FFFFB848FF00B93DFF00B9
      3DFFFFB848FF9E9E9EFFC75570FF0000000008AADBFFC7F4FFFFBFF0FEFF85E4
      FFFF00BCF2FF03B4E9FF00B7ECFF00B6EAFF00B6EAFF00B1E4FF08AFD9FF1680
      25FF1B9A2DFF168025FF09A0CAFF9CCDDCFFCB4767FFC33B5DFFE8DDE2FFF0E8
      ECFFF0E9ECFFF3EDEFFFF3EDEFFFF3EDEFFFF3EDEFFFF3EDEFFFF3EDEFFFF3ED
      EFFFE8DEE3FFD35371FFD55B78FFDDDDDDFF19AE00FF18A800FFD6D6D6FFE0E1
      DFFFE1E1E1FFE4E5E3FFE4E5E3FFE4E5E3FFE4E5E3FFE4E5E3FFE4E5E3FFE4E5
      E3FFD7D7D7FF1BC000FF32C719FFDDDDDDFF00000000B33655FFF34677FFFF74
      9BFFFF6A95FFFF6190FFFD719CFFFE5589FFDC0049FFFFB848FFFFB848FFFFB8
      48FFFFB848FF9E9E9EFFC75570FF0000000008AADBFF81E3FFFFE3F9FFFFE3F9
      FFFFD3F6FFFFBED2D0FFB5C3BFFFD3F6FFFFD3F6FFFFCEF1F4FF168025FF1B9E
      2DFF1DA52FFF1B9A2DFF168025FFDCDCDCFFD35371FFCB4767FFEFE9ECFFE193
      A5FFD96F88FFD96E88FFD86E87FFD86E87FFD86E87FFD86E87FFD86E87FFDE8F
      A3FFE8DEE3FFD35371FFD55B78FFDDDDDDFF19B500FF19AE00FFE0E0E0FF51C1
      59FF159600FF159600FF159600FF159600FF159600FF159600FF159600FF51C0
      59FFD7D7D7FF1BC000FF32C719FFDDDDDDFF00000000BA415FFFF34677FFFD6E
      96FFFF6A95FFFF6A95FFFF6190FFFF578AFFDC0049FFFFE676FFFFE070FFFFD0
      60FFFFB848FF9E9E9EFFC75570FF00000000BC4A65FF00AEE0FF89E5FFFFEFFD
      FFFFE3F9FFFFC9D4D0FF168025FF1F9FC1FF00AEE0FF3C9C5AFF168025FF188A
      28FF1DA830FF188A28FF168025FF6BA774FFD35371FFD35371FFEFE9ECFFF3EE
      F0FFF1EBEFFFF1EAEEFFEFE8EBFFEFE8EBFFEFE8EBFFEFE8EBFFEFE8EBFFEFE8
      EBFFE8DEE3FFD35371FFD55B78FFDDDDDDFF1ABA00FF19B500FFE0E0E0FFE4E4
      E4FFE2E2E2FFE2E3E1FFE0E0E0FFE0E0E0FFE0E0E0FFE0E0E0FFE0E0E0FFE0E0
      E0FFD7D7D7FF1BC000FF26C30DFFDDDDDDFF00000000C24C68FFF85581FFF866
      90FFFF749BFFFF6A95FFFF6190FFFF6190FFDC0049FFFFEB7BFFFFEF7FFFFFE0
      70FFFFB848FF9E9E9EFFC75570FF0000000000000000AD445DFF00AEE0FF00AE
      E0FF00AEE0FF269BB7FF168025FF168025FFE62B63FF000000009C9E9CFF1680
      25FF1EAB31FF168025FFC3576EFFDDDDDDFFD35371FFD35371FFEFE9ECFFE092
      A5FFD96F88FFD96E88FFD96E88FFD96E88FFD96E88FFD96E88FFD96E88FFDF90
      A4FFE8DEE3FFD45674FFD55B78FFDEDEDEFF1BC000FF1ABA00FFE0E0E0FF51C0
      59FF159600FF159600FF159600FF159600FF159600FF159600FF159600FF51C0
      59FFD7D7D7FF19AE00FF26C30DFFDEDEDEFF00000000C24C68FFFB5E87FFF353
      83FFFF7EA1FFFF749BFFFF6A95FFFF6190FFEA2A65FF9E9E9EFF9E9E9EFF9E9E
      9EFF9E9E9EFFA89096FFC95671FF0000000000000000C74E6AFFEA93ABFFEF59
      80FFE1346AFFF36F94FF168025FF21BE38FF1B9D2DFF168025FF168025FF1EAE
      32FF1EAA31FF168025FFD45E7AFF00000000D35371FFD35371FFEFE9ECFFF3EE
      F0FFF2EDEFFFF2EDEFFFF2EDEFFFF2EDEFFFF2EDEFFFF2EDEFFFF0EAEDFFF0E9
      ECFFE8DEE3FFD76480FFD65E7BFFE9E9E9FF1BC000FF1BC000FFE0E0E0FFE4E4
      E4FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE3E3E3FFE1E1E1FFE1E1
      E1FFD7D7D7FF18A900FF24B20DFFE9E9E9FF00000000CA4F6CFFF59AB3FFFA5D
      86FFEB366FFFFF749BFFFF749BFFF85687FFEA2A65FFCDC9CAFFCBC6C9FFCBC5
      C8FFC5BCC0FF0000000000000000000000000000000000000000000000000000
      00000000000000000000D5466BFF1A962BFF1DA630FF20BC36FF20B936FF1FB0
      33FF168025FFC2727DFF0000000000000000D55D79FFD35371FFEFE9ECFFE092
      A5FFD96F88FFD96F88FFD96F88FFD96F88FFD96F88FFD96F88FFD96F88FFE193
      A5FFE8DEE3FFDA7089FFDA708AFFF7F7F7FF29C310FF1BC000FFE0E0E0FF51C0
      59FF159600FF159600FF159600FF159600FF159600FF159600FF159600FF51C1
      59FFD7D7D7FF17A000FF2BB015FFF7F7F7FF000000000000000000000000E587
      9EFFF46589FFF75380FFEF3E75FFF3467BFFEA2A65FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F3547EFFD0345DFF168025FF168025FF168025FF1680
      25FFD6DDD5FFD4657EFF0000000000000000EDBAC6FFD55C78FFF0EAEDFFF0EA
      EDFFF0EAEDFFF0EAEDFFF0EAEDFFF0EAEDFFF0EAEDFFF0EAEDFFF0EAEDFFF0EA
      EDFFF0EAEDFFD76580FFF2CFD8FF00000000A3E599FF27C30EFFE1E1E1FFE1E1
      E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1E1FFE1E1
      E1FFE1E1E1FF209B0CFFB2DFABFF000000000000000000000000000000000000
      0000E0DADDFFF2C4D1FFF75380FFEA2A65FFC4AEB4FF00000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000600000000100010000000000000300000000000000000000
      000000000000000000000000FFFFFF00FFE70000000000000007000000000000
      000F000000000000000700000000000000070000000000000003000000000000
      00010000000000000008000000000000000C000000000000000C000000000000
      00010000000000000003000000000000000F000000000000000F000000000000
      000F000000000000000F000000000000FC0FFC0FF001E018F007F007C000C000
      C003C0038000C000C001C0018000800000000000800080000000000080000000
      00000000C000000000000000C001000000000000C003000800000000E003801F
      00000000F003C01F00010001F007FE1F80038003F80FFE1FC003C003FC1FFE1F
      E007E007FE3FFE1FF01FF01FFFFFFF3FEFF7FF01FF01FE3F000080018001FC0F
      000000010001F803EFF700010001F000842100010001E000842100010001C000
      8421000000008000F20700000000000080010000000000008021000100010000
      8001000100010001F3CF8000800000038021C0E3C0E300078021FC03FC03000F
      8001FE07FE07C01FFB9FFF0FFF0FF03FFC3F0000E7FFFFE7F01F0000C7FFFFE3
      F01F00008FFFFFF1F011000000018000F000000000018000F800000084218421
      F800000084218421F9000000E6009027F0000000840080210000000084218021
      01E100008421842107FF0000FE799E7FC7FF000084208421C7FF000084000021
      C7FF0000842180217FFF0000FF73DCFFFFFCFFFFFC00E1FF87F8FFFFF800C0FF
      83F0FC7FF000C07F81F0F83FC000807F81E1F83F8000003FC0C3F83F0000003F
      C087C0030000001FF00F80030001041FF80F80030001040FFC1F800300019E0F
      FC0FC0030001FE07F007F83F0003FF07E083F83F0007FF03C3C0F83F001FFF83
      87E0FC3F001FFFC3BFF9FFFF00FFFFE7800380008000FC3F000180008000F03F
      000000000000E03F000000000000800300000000000080010000000000008001
      0000000000008001000000000000800100000000000080010000000000008001
      0000000000008001000000000000800180400000000080018001000000008007
      FC0300000000E07FFC0300010001F07F00000000000000000000000000000000
      000000000000}
  end
  object IdHTTP1: TIdHTTP
    MaxLineAction = maException
    ReadTimeout = 0
    AllowCookies = True
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 264
    Top = 288
  end
  object XMLDocument1: TXMLDocument
    Left = 304
    Top = 288
    DOMVendorDesc = 'MSXML'
  end
  object UploadData: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'name'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 255
      end
      item
        Name = 'DateTime'
        Attributes = [faUnNamed]
        DataType = ftDateTime
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 384
    Top = 288
    Data = {
      9C0000009619E0BD0100000018000000030001000000030000007A0002696401
      00490010000100055749445448020002000A00046E616D650200490010000100
      05574944544802000200FF00084461746554696D65080008001000000001000A
      4348414E47455F4C4F4704008200030000000100000000000000040000000400
      05313537333810007465737430352E332E6375746C69737400A8783D9BC8CC42}
    object UploadDataid: TStringField
      FieldName = 'id'
      Size = 10
    end
    object UploadDataname: TStringField
      FieldName = 'name'
      Size = 255
    end
    object UploadDataDateTime: TDateTimeField
      FieldName = 'DateTime'
    end
  end
  object DownloadData: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'name'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 255
      end
      item
        Name = 'DateTime'
        Attributes = [faUnNamed]
        DataType = ftDateTime
      end
      item
        Name = 'MD5'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 32
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 384
    Top = 328
    Data = {
      730000009619E0BD010000001800000004000000000003000000730002696401
      00490010000100055749445448020002000A00046E616D650200490010000100
      05574944544802000200FF00084461746554696D650800080010000000034D44
      3501004900100001000557494454480200020020000000}
    object DownloadDataid: TStringField
      FieldName = 'id'
      Size = 10
    end
    object DownloadDataname: TStringField
      FieldName = 'name'
      Size = 255
    end
    object DownloadDataDateTime: TDateTimeField
      FieldName = 'DateTime'
    end
    object DownloadDataMD5: TStringField
      FieldName = 'MD5'
      Size = 32
    end
  end
  object MenuVideo: TPopupMenu
    Left = 184
    Top = 288
    object FramePopUpNext12Frames: TMenuItem
      Caption = 'Next 12 Frames'
      OnClick = FramePopUpNext12FramesClick
    end
    object FramePopUpPrevious12Frames: TMenuItem
      Caption = 'Previous 12 Frames'
      OnClick = FramePopUpPrevious12FramesClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object CopySnapshottoClipboard1: TMenuItem
      Action = ASnapshotCopy
    end
    object SaveSnapshotas1: TMenuItem
      Action = ASnapshotSave
    end
  end
end
