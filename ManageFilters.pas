unit ManageFilters;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DSPack, DSUtil, DirectShow9, Utils;

type
  TFManageFilters = class(TForm)
    BRemove: TButton;
    BClose: TButton;
    LFilters: TListBox;
    BCopy: TButton;
    Label1: TLabel;
    procedure BCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LFiltersClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BRemoveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BCopyClick(Sender: TObject);
    procedure LFiltersDblClick(Sender: TObject);
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

procedure TFManageFilters.BCloseClick(Sender: TObject);
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

  LFilters.Clear;
  For iFilter := 0 to FilterList.Count-1 do begin
    FilterLIst.Items[iFilter].GetClassID(guid);
    LFilters.Items.Add(guidtostring(guid) + '   ' + string(FilterList.FilterInfo[iFIlter].achName));
  end;


  {try
    OleCheck((Graph as IFilterGraph).EnumFilters(Filters));
    while Filters.Next(1, BaseFilter, nil) = S_OK do begin
      if failed(BaseFilter.QueryFilterInfo(FilterInfo)) then begin
        LFilters.Items.Add('*** unknown Filter');
      end else begin
        LFilters.Items.Add(FilterInfo.achName);
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

procedure TFManageFilters.LFiltersClick(Sender: TObject);
var
  iItem: Integer;
  sel: boolean;
begin
  sel := false;
  for iItem := 0 to LFilters.Items.count -1 do begin
    if lFilters.Selected[iItem] then sel := true;
  end;
  self.BRemove.Enabled := sel;
end;


procedure TFManageFilters.BRemoveClick(Sender: TObject);
var
  iItem, iFIlter: Integer;
begin
  exit; //*********************** funktioniert noch nicht richtig

  LFiltersClick(self);
  if BRemove.Enabled = false then exit;

  for iItem := 0 to LFilters.Items.count -1 do begin
    if lFilters.Selected[iItem] then break;
  end;

  Case (SourceGraph as IFIlterGRaph).RemoveFilter(filterlist.Items[iItem]) of
    S_OK: showmessage('Removed.');
    else showmessage('Failed.');
  end;
  FilterList.Update;

  LFilters.Clear;
  For iFilter := 0 to FilterList.Count-1 do begin
    LFilters.Items.Add(FilterList.FilterInfo[iFIlter].achName);
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

procedure TFManageFilters.BCopyClick(Sender: TObject);
begin
  ListBoxToClipboard(self.LFilters, 255, true);
end;

procedure TFManageFilters.LFiltersDblClick(Sender: TObject);
var
  Index: INteger;
begin
  //Index := self.LFilters.ItemAtPos(Mouse.CursorPos, true);
  Index := self.LFilters.ItemIndex;
  if Index >= 0 then begin
    ShowFilterPropertyPage(self.Handle, FilterList.Items[Index]);
  end;
end;

end.
