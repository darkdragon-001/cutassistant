object FUploadList: TFUploadList
  Left = 1334
  Top = 396
  Width = 813
  Height = 322
  Caption = 'Uploaded Cutlists'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 249
    Width = 805
    Height = 41
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      805
      41)
    object BCancel: TButton
      Left = 720
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
    end
    object BDelete: TButton
      Left = 12
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Delete'
      ModalResult = 1
      TabOrder = 1
    end
  end
  object LLinklist: TListView
    Left = 0
    Top = 0
    Width = 805
    Height = 249
    Align = alClient
    Columns = <
      item
        Caption = '#'
      end
      item
        Caption = 'File'
        Width = 600
      end
      item
        Caption = 'Date'
        Width = 150
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
