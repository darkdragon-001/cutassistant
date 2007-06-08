object FUploadList: TFUploadList
  Left = 334
  Top = 396
  Width = 813
  Height = 322
  Caption = 'Uploaded Cutlists'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 254
    Width = 805
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      805
      34)
    object BCancel: TButton
      Left = 699
      Top = 6
      Width = 95
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 0
    end
    object BDelete: TButton
      Left = 598
      Top = 6
      Width = 95
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Delete'
      ModalResult = 1
      TabOrder = 1
    end
  end
  object LLinklist: TListView
    Left = 0
    Top = 0
    Width = 805
    Height = 254
    Align = alClient
    Columns = <
      item
        Caption = '#'
        Width = 41
      end
      item
        Caption = 'File'
        Width = 488
      end
      item
        Caption = 'Date'
        Width = 122
      end>
    GridLines = True
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    SortType = stText
    TabOrder = 1
    ViewStyle = vsReport
  end
end
