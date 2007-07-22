object FResultingTimes: TFResultingTimes
  Left = 340
  Top = 318
  ActiveControl = BClose
  AutoScroll = False
  Caption = 'Check cuts after cutting'
  ClientHeight = 396
  ClientWidth = 592
  Color = clBtnFace
  Constraints.MinHeight = 430
  Constraints.MinWidth = 600
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Microsoft Sans Serif'
  Font.Pitch = fpVariable
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LTimeList: TListView
    Left = 360
    Top = 0
    Width = 232
    Height = 352
    Align = alRight
    Columns = <
      item
        Caption = 'Part'
        Width = 33
      end
      item
        Caption = 'From'
        Width = 65
      end
      item
        Caption = 'To'
        Width = 65
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
    Top = 352
    Width = 592
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    Constraints.MinWidth = 360
    TabOrder = 1
    DesignSize = (
      592
      44)
    object Label1: TLabel
      Left = 360
      Top = 7
      Width = 106
      Height = 26
      Anchors = [akTop, akRight]
      Caption = 'Double Click = jump to end of part -'
      WordWrap = True
    end
    object Label8: TLabel
      Left = 214
      Top = 7
      Width = 18
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Vol.'
    end
    object Label2: TLabel
      Left = 77
      Top = 7
      Width = 21
      Height = 13
      Alignment = taRightJustify
      Caption = 'Pos.'
    end
    object Label3: TLabel
      Left = 462
      Top = 20
      Width = 20
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'sec.'
    end
    object BClose: TButton
      Left = 492
      Top = 13
      Width = 95
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      ModalResult = 1
      TabOrder = 0
      OnClick = BCloseClick
    end
    object TVolume: TTrackBar
      Left = 233
      Top = 7
      Width = 122
      Height = 26
      Anchors = [akTop, akRight]
      Max = 10000
      Frequency = 1000
      Position = 5000
      TabOrder = 1
      OnChange = TVolumeChange
    end
    object BPause: TButton
      Left = 41
      Top = 7
      Width = 27
      Height = 26
      Hint = 'Pause'
      Caption = 'II'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = BPauseClick
    end
    object BPlay: TButton
      Left = 9
      Top = 7
      Width = 27
      Height = 26
      Hint = 'Play'
      Caption = '>'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = BPlayClick
    end
    object DSTrackBar1: TDSTrackBar
      Left = 98
      Top = 7
      Width = 112
      Height = 26
      Anchors = [akLeft, akTop, akRight]
      Frequency = 300
      TabOrder = 4
      FilterGraph = FilterGraph2
    end
    object ESeconds: TEdit
      Left = 423
      Top = 20
      Width = 20
      Height = 21
      Anchors = [akTop, akRight]
      ReadOnly = True
      TabOrder = 5
      Text = '0'
    end
    object UDSeconds: TUpDown
      Left = 443
      Top = 20
      Width = 15
      Height = 21
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
    Width = 360
    Height = 352
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    OnResize = PanelVideoWindow2Resize
    DesignSize = (
      360
      352)
    object VideoWindow2: TVideoWindow
      Left = 0
      Top = 0
      Width = 355
      Height = 262
      FilterGraph = FilterGraph2
      VMROptions.Mode = vmrWindowed
      Color = clBlack
      Anchors = [akLeft, akTop, akRight, akBottom]
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
