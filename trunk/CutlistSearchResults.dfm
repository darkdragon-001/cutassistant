object FCutlistSearchResults: TFCutlistSearchResults
  Left = 1360
  Top = 312
  Caption = 'Cutlist Search Results'
  ClientHeight = 288
  ClientWidth = 1052
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
    Width = 1046
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      1046
      34)
    object BCancel: TButton
      Left = 948
      Top = 6
      Width = 95
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 0
    end
  end
  object LLinklist: TListView
    Left = 3
    Top = 3
    Width = 1046
    Height = 248
    Align = alClient
    Columns = <
      item
        Caption = '#'
        Width = 41
      end
      item
        Caption = 'File'
        Width = 325
      end
      item
        Caption = 'User Rating'
        Width = 81
      end
      item
        Caption = 'User #'
        Width = 49
      end
      item
        Caption = 'Auth. Rating'
        Width = 65
      end
      item
        Caption = 'Author Name'
        Width = 81
      end
      item
        Caption = 'Comment'
        Width = 122
      end
      item
        Caption = 'Actual Content'
        Width = 163
      end>
    GridLines = True
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    SortType = stText
    TabOrder = 1
    ViewStyle = vsReport
    OnClick = LLinklistClick
  end
end
