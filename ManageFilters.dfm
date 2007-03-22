object FManageFilters: TFManageFilters
  Left = 471
  Top = 363
  Width = 582
  Height = 282
  Caption = 'Filters'
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 250
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    574
    250)
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 200
    Top = 216
    Width = 137
    Height = 33
    Caption = 'Double Click on Filter to show properties'
    WordWrap = True
  end
  object BRemove: TButton
    Left = 0
    Top = 220
    Width = 161
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Remove from FilterGraph'
    Enabled = False
    TabOrder = 0
    Visible = False
    OnClick = BRemoveClick
  end
  object BClose: TButton
    Left = 499
    Top = 220
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Close'
    Default = True
    TabOrder = 1
    OnClick = BCloseClick
  end
  object LFilters: TListBox
    Left = 0
    Top = 0
    Width = 574
    Height = 213
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 20
    MultiSelect = True
    ParentFont = False
    TabOrder = 2
    OnClick = LFiltersClick
    OnDblClick = LFiltersDblClick
  end
  object BCopy: TButton
    Left = 360
    Top = 220
    Width = 126
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Copy to clipboard'
    Default = True
    TabOrder = 3
    OnClick = BCopyClick
  end
end
