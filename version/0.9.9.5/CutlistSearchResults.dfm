object FCutlistSearchResults: TFCutlistSearchResults
  Left = 1360
  Top = 312
  Width = 1060
  Height = 322
  Caption = 'Cutlist Search Results'
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
    Width = 1052
    Height = 41
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      1052
      41)
    object BCancel: TButton
      Left = 967
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
    end
  end
  object LLinklist: TListView
    Left = 0
    Top = 0
    Width = 1052
    Height = 249
    Align = alClient
    Columns = <
      item
        Caption = '#'
      end
      item
        Caption = 'File'
        Width = 400
      end
      item
        Caption = 'User Rating'
        Width = 100
      end
      item
        Caption = 'User #'
        Width = 60
      end
      item
        Caption = 'Auth. Rating'
        Width = 80
      end
      item
        Caption = 'Author Name'
        Width = 100
      end
      item
        Caption = 'Comment'
        Width = 150
      end
      item
        Caption = 'Actual Content'
        Width = 200
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
