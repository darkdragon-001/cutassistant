object FResultingTimes: TFResultingTimes
  Left = 263
  Top = 283
  Width = 901
  Height = 534
  ActiveControl = BClose
  Caption = 'Check cuts after cutting'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 16
  object LTimeList: TListView
    Left = 608
    Top = 0
    Width = 285
    Height = 448
    Align = alRight
    Columns = <
      item
        Caption = 'Part'
        Width = 40
      end
      item
        Caption = 'From'
        Width = 80
      end
      item
        Caption = 'To'
        Width = 80
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
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = LTimeListDblClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 448
    Width = 893
    Height = 54
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      893
      54)
    object Label1: TLabel
      Left = 618
      Top = 8
      Width = 135
      Height = 32
      Anchors = [akTop, akRight]
      Caption = 'Double Click = jump to end of part -'
      WordWrap = True
    end
    object Label8: TLabel
      Left = 433
      Top = 8
      Width = 23
      Height = 16
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Vol.'
    end
    object Label2: TLabel
      Left = 94
      Top = 8
      Width = 27
      Height = 16
      Alignment = taRightJustify
      Caption = 'Pos.'
    end
    object Label3: TLabel
      Left = 743
      Top = 24
      Width = 25
      Height = 16
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'sec.'
    end
    object BClose: TButton
      Left = 809
      Top = 16
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      ModalResult = 1
      TabOrder = 0
      OnClick = BCloseClick
    end
    object TVolume: TTrackBar
      Left = 458
      Top = 8
      Width = 150
      Height = 33
      Anchors = [akTop, akRight]
      Max = 10000
      Frequency = 1000
      Position = 5000
      TabOrder = 1
      OnChange = TVolumeChange
    end
    object BPause: TButton
      Left = 51
      Top = 8
      Width = 33
      Height = 33
      Hint = 'Pause'
      Caption = 'II'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = BPauseClick
    end
    object BPlay: TButton
      Left = 11
      Top = 8
      Width = 33
      Height = 33
      Hint = 'Play'
      Caption = '>'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = BPlayClick
    end
    object DSTrackBar1: TDSTrackBar
      Left = 120
      Top = 8
      Width = 296
      Height = 33
      Anchors = [akLeft, akTop, akRight]
      Frequency = 300
      TabOrder = 4
      FilterGraph = FilterGraph2
    end
    object ESeconds: TEdit
      Left = 695
      Top = 24
      Width = 25
      Height = 24
      Anchors = [akTop, akRight]
      ReadOnly = True
      TabOrder = 5
      Text = '0'
    end
    object UDSeconds: TUpDown
      Left = 720
      Top = 24
      Width = 18
      Height = 24
      Anchors = [akTop, akRight]
      Associate = ESeconds
      Max = 99
      TabOrder = 6
      OnChanging = UDSecondsChanging
    end
  end
  object PanelVideoWindow2: TPanel
    Left = 0
    Top = 0
    Width = 608
    Height = 448
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    OnResize = PanelVideoWindow2Resize
    object VideoWindow2: TVideoWindow
      Left = 0
      Top = 0
      Width = 600
      Height = 450
      FilterGraph = FilterGraph2
      VMROptions.Mode = vmrWindowed
      Color = clBlack
    end
  end
  object FilterGraph2: TFilterGraph
    GraphEdit = True
    LinearVolume = True
    OnSelectedFilter = FilterGraph2SelectedFilter
    Left = 144
    Top = 160
  end
end
