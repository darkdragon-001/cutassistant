object FManageFilters: TFManageFilters
  Left = 372
  Top = 359
  AutoScroll = False
  Caption = 'Filters'
  ClientHeight = 221
  ClientWidth = 666
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 250
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Microsoft Sans Serif'
  Font.Pitch = fpVariable
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    666
    221)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 148
    Top = 188
    Width = 103
    Height = 26
    Anchors = [akLeft, akBottom]
    Caption = 'Double Click on Filter to show properties'
    WordWrap = True
  end
  object BRemove: TButton
    Left = 4
    Top = 192
    Width = 131
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Remove from FilterGraph'
    Enabled = False
    TabOrder = 0
    Visible = False
    OnClick = BRemoveClick
  end
  object BClose: TButton
    Left = 601
    Top = 192
    Width = 61
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Close'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = BCloseClick
  end
  object LFilters: TListBox
    Left = 0
    Top = 0
    Width = 666
    Height = 179
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = []
    ItemHeight = 16
    MultiSelect = True
    ParentFont = False
    TabOrder = 2
    OnClick = LFiltersClick
    OnDblClick = LFiltersDblClick
  end
  object BCopy: TButton
    Left = 493
    Top = 192
    Width = 102
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Copy to clipboard'
    Default = True
    TabOrder = 3
    OnClick = BCopyClick
  end
end
