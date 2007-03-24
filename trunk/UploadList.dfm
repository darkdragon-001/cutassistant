object FUploadList: TFUploadList
  Left = 1334
  Top = 396
  Caption = 'Uploaded Cutlists'
  ClientHeight = 288
  ClientWidth = 805
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Padding.Left = 3
  Padding.Top = 3
  Padding.Right = 3
  Padding.Bottom = 3
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 3
    Top = 251
    Width = 799
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 0
    ExplicitTop = 254
    ExplicitWidth = 805
    DesignSize = (
      799
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
      ExplicitLeft = 705
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
      ExplicitLeft = 604
    end
  end
  object LLinklist: TListView
    Left = 3
    Top = 3
    Width = 799
    Height = 248
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
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 805
    ExplicitHeight = 254
  end
end
