object FManageFilters: TFManageFilters
  Left = 471
  Top = 363
  Width = 450
  Height = 255
  Caption = 'Filters'
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 250
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    442
    221)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 148
    Top = 187
    Width = 103
    Height = 26
    Anchors = [akLeft, akBottom]
    Caption = 'Double Click on Filter to show properties'
    WordWrap = True
  end
  object BRemove: TButton
    Left = 4
    Top = 185
    Width = 131
    Height = 20
    Anchors = [akLeft, akBottom]
    Caption = 'Remove from FilterGraph'
    Enabled = False
    TabOrder = 0
    Visible = False
    OnClick = BRemoveClick
  end
  object BClose: TButton
    Left = 377
    Top = 185
    Width = 61
    Height = 20
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
    Width = 442
    Height = 179
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 17
    MultiSelect = True
    ParentFont = False
    TabOrder = 2
    OnClick = LFiltersClick
    OnDblClick = LFiltersDblClick
  end
  object BCopy: TButton
    Left = 269
    Top = 185
    Width = 102
    Height = 20
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Copy to clipboard'
    Default = True
    TabOrder = 3
    OnClick = BCopyClick
  end
end
