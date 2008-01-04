UNIT ManageFilters;

INTERFACE

USES
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DSPack, DSUtil, DirectShow9, Utils;

TYPE
  TFManageFilters = CLASS(TForm)
    cmdRemove: TButton;
    cmdClose: TButton;
    lvFilters: TListBox;
    cmdCopy: TButton;
    lblClickOnFilter: TLabel;
    PROCEDURE cmdCloseClick(Sender: TObject);
    PROCEDURE FormShow(Sender: TObject);
    PROCEDURE lvFiltersClick(Sender: TObject);
    PROCEDURE FormCreate(Sender: TObject);
    PROCEDURE cmdRemoveClick(Sender: TObject);
    PROCEDURE FormDestroy(Sender: TObject);
    PROCEDURE cmdCopyClick(Sender: TObject);
    PROCEDURE lvFiltersDblClick(Sender: TObject);
    PROCEDURE FormClose(Sender: TObject; VAR Action: TCloseAction);
  PRIVATE
    FilterList: TFIlterList;
    { Private declarations }
    PROCEDURE refresh_FilterList(Graph: TFilterGraph);
  PUBLIC
    { Public declarations }
    SourceGraph: TFilterGraph;
  END;

VAR
  FManageFilters                   : TFManageFilters;

IMPLEMENTATION

{$R *.dfm}

USES Main, ComObj;

PROCEDURE TFManageFilters.cmdCloseClick(Sender: TObject);
BEGIN
  self.Hide;
END;

PROCEDURE TFManageFilters.FormShow(Sender: TObject);
BEGIN
  // Show taskbar button for this form ...
  // SetWindowLong(Handle, GWL_ExStyle, WS_Ex_AppWindow);
  Refresh_Filterlist(self.SourceGraph);
END;

PROCEDURE TFManageFilters.refresh_FilterList(Graph: TFilterGraph);
VAR
  //Filters: IEnumFilters;
  //BaseFilter: IBaseFilter;
  //cFetched: ULONG;
  //FilterInfo: _FilterInfo;

  iFilter                          : Integer;
  guid                             : TGUID;
BEGIN
  IF NOT graph.Active THEN exit;
  graph.Stop;
  FilterList.Assign(Graph AS IFIlterGRaph);

  lvFilters.Clear;
  FOR iFilter := 0 TO FilterList.Count - 1 DO BEGIN
    FilterLIst.Items[iFilter].GetClassID(guid);
    lvFilters.Items.Add(guidtostring(guid) + '   ' + STRING(FilterList.FilterInfo[iFIlter].achName));
  END;


  {try
    OleCheck((Graph as IFilterGraph).EnumFilters(Filters));
    while Filters.Next(1, BaseFilter, nil) = S_OK do begin
      if failed(BaseFilter.QueryFilterInfo(FilterInfo)) then begin
        lvFilters.Items.Add('*** unknown Filter');
      end else begin
        lvFilters.Items.Add(FilterInfo.achName);
//        if filterinfo.pGraph <> nil then filterinfo.pGraph._Release;
      end;
      //BaseFilter._Release;
    end;
    //Filters._Release;
  except
//    filtergraph.ClearGraph;
//    filtergraph.active := false;
    raise;
  end;}

END;

PROCEDURE TFManageFilters.lvFiltersClick(Sender: TObject);
VAR
  iItem                            : Integer;
  sel                              : boolean;
BEGIN
  sel := false;
  FOR iItem := 0 TO lvFilters.Items.count - 1 DO BEGIN
    IF lvFilters.Selected[iItem] THEN sel := true;
  END;
  self.cmdRemove.Enabled := sel;
END;


PROCEDURE TFManageFilters.cmdRemoveClick(Sender: TObject);
VAR
  iItem, iFIlter                   : Integer;
BEGIN
  exit; //*********************** funktioniert noch nicht richtig

  lvFiltersClick(self);
  IF cmdRemove.Enabled = false THEN exit;

  FOR iItem := 0 TO lvFilters.Items.count - 1 DO BEGIN
    IF lvFilters.Selected[iItem] THEN break;
  END;

  CASE (SourceGraph AS IFIlterGRaph).RemoveFilter(filterlist.Items[iItem]) OF
    S_OK: showmessage('Removed.');
  ELSE showmessage('Failed.');
  END;
  FilterList.Update;

  lvFilters.Clear;
  FOR iFilter := 0 TO FilterList.Count - 1 DO BEGIN
    lvFilters.Items.Add(FilterList.FilterInfo[iFIlter].achName);
  END;

END;

PROCEDURE TFManageFilters.FormCreate(Sender: TObject);
BEGIN
  FIlterLIst := TFilterLIst.Create;
END;

PROCEDURE TFManageFilters.FormDestroy(Sender: TObject);
BEGIN
  FreeAndNIL(FilterList);
END;

PROCEDURE TFManageFilters.cmdCopyClick(Sender: TObject);
BEGIN
  ListBoxToClipboard(self.lvFilters, 255, true);
END;

PROCEDURE TFManageFilters.lvFiltersDblClick(Sender: TObject);
VAR
  Index                            : INteger;
BEGIN
  //Index := self.lvFilters.ItemAtPos(Mouse.CursorPos, true);
  Index := self.lvFilters.ItemIndex;
  IF Index >= 0 THEN BEGIN
    ShowFilterPropertyPage(self.Handle, FilterList.Items[Index]);
  END;
END;

PROCEDURE TFManageFilters.FormClose(Sender: TObject;
  VAR Action: TCloseAction);
BEGIN
  Action := caHide;
  ModalResult := mrOk;
END;

END.
