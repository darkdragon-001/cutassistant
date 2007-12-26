unit ManageFilters;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DSPack, DSUtil, DirectShow9, Utils;

type
  TFManageFilters = class(TForm)
    cmdRemove: TButton;
    cmdClose: TButton;
    lvFilters: TListBox;
    cmdCopy: TButton;
    lblClickOnFilter: TLabel;
    procedure cmdCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvFiltersClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdRemoveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmdCopyClick(Sender: TObject);
    procedure lvFiltersDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FilterList: TFIlterList;
    { Private declarations }
    procedure refresh_FilterList(Graph: TFilterGraph);
  public
    { Public declarations }
    SourceGraph: TFilterGraph;
  end;

var
  FManageFilters: TFManageFilters;

implementation

{$R *.dfm}

uses Main, ComObj;

procedure TFManageFilters.cmdCloseClick(Sender: TObject);
begin
  self.Hide;
end;

procedure TFManageFilters.FormShow(Sender: TObject);
begin
  // Show taskbar button for this form ...
  // SetWindowLong(Handle, GWL_ExStyle, WS_Ex_AppWindow);
  Refresh_Filterlist(self.SourceGraph);
end;

procedure TFManageFilters.refresh_FilterList(Graph: TFilterGraph);
var
  //Filters: IEnumFilters;
  //BaseFilter: IBaseFilter;
  //cFetched: ULONG;
  //FilterInfo: _FilterInfo;

  iFilter: Integer;
  guid: TGUID;
begin
  if not graph.Active then exit;
  graph.Stop;
  FilterList.Assign(Graph as IFIlterGRaph);

  lvFilters.Clear;
  For iFilter := 0 to FilterList.Count-1 do begin
    FilterLIst.Items[iFilter].GetClassID(guid);
    lvFilters.Items.Add(guidtostring(guid) + '   ' + string(FilterList.FilterInfo[iFIlter].achName));
  end;


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

end;

procedure TFManageFilters.lvFiltersClick(Sender: TObject);
var
  iItem: Integer;
  sel: boolean;
begin
  sel := false;
  for iItem := 0 to lvFilters.Items.count -1 do begin
    if lvFilters.Selected[iItem] then sel := true;
  end;
  self.cmdRemove.Enabled := sel;
end;


procedure TFManageFilters.cmdRemoveClick(Sender: TObject);
var
  iItem, iFIlter: Integer;
begin
  exit; //*********************** funktioniert noch nicht richtig

  lvFiltersClick(self);
  if cmdRemove.Enabled = false then exit;

  for iItem := 0 to lvFilters.Items.count -1 do begin
    if lvFilters.Selected[iItem] then break;
  end;

  Case (SourceGraph as IFIlterGRaph).RemoveFilter(filterlist.Items[iItem]) of
    S_OK: showmessage('Removed.');
    else showmessage('Failed.');
  end;
  FilterList.Update;

  lvFilters.Clear;
  For iFilter := 0 to FilterList.Count-1 do begin
    lvFilters.Items.Add(FilterList.FilterInfo[iFIlter].achName);
  end;

end;

procedure TFManageFilters.FormCreate(Sender: TObject);
begin
  FIlterLIst := TFilterLIst.Create;
end;

procedure TFManageFilters.FormDestroy(Sender: TObject);
begin
  FreeAndNIL(FilterList);
end;

procedure TFManageFilters.cmdCopyClick(Sender: TObject);
begin
  ListBoxToClipboard(self.lvFilters, 255, true);
end;

procedure TFManageFilters.lvFiltersDblClick(Sender: TObject);
var
  Index: INteger;
begin
  //Index := self.lvFilters.ItemAtPos(Mouse.CursorPos, true);
  Index := self.lvFilters.ItemIndex;
  if Index >= 0 then begin
    ShowFilterPropertyPage(self.Handle, FilterList.Items[Index]);
  end;
end;

procedure TFManageFilters.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caHide;
  ModalResult := mrOk;
end;

end.
