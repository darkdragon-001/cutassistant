object FCutlistSearchResults: TFCutlistSearchResults
  Left = 175
  Top = 316
  AutoScroll = False
  Caption = 'Cutlist Search Results'
  ClientHeight = 288
  ClientWidth = 933
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Microsoft Sans Serif'
  Font.Pitch = fpVariable
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 254
    Width = 933
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      933
      34)
    object BCancel: TButton
      Left = 829
      Top = 6
      Width = 95
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&Cancel'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Microsoft Sans Serif'
      Font.Pitch = fpVariable
      Font.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 0
    end
  end
  object LLinklist: TListView
    Left = 0
    Top = 0
    Width = 933
    Height = 254
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
