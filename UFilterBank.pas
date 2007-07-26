(*
From progdigy.com Forum posted by XXX on Mon 2004-11-08 07.50 pm

I created object 'TFilterBank' providing connecting/disconnecting desired filters.
What is this good for? For situations like this:
- I would like to add 'Dedynamic' filter to filtergraph every time I watch video.
- I would like to remove 'DC-DSP filter' from filtergraph (but not from system to get rid of it).

I tested 'TFilterBank' only on filters with one input pin and one output pin.



Example
We want to insert 'DeDynamic' filter and remove 'DC-DSP Filter'.

Create new aplication, rename 'Form1' to 'MainForm' and place DSVideoWindowEx2, 3 buttons, OpenDialog, FilterGraph on it with following names 'DSVideoWindowEx2', 'btnOpen', 'btnStop', 'btnPlay', 'OpenDialog'.
Here is the entire code:
CODE 


unit Unit1;

interface

uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
 Dialogs, StdCtrls, DSPack, FilterBank, DirectShow9;

type
 TMainForm = class(TForm)
   DSVideoWindowEx2: TDSVideoWindowEx2;
   btnOpen: TButton;
   btnStop: TButton;
   btnPlay: TButton;
   OpenDialog: TOpenDialog;
   FilterGraph: TFilterGraph;
   procedure FormCreate(Sender: TObject);
   procedure FormDestroy(Sender: TObject);
   procedure btnOpenClick(Sender: TObject);
   procedure btnPlayClick(Sender: TObject);
   procedure btnStopClick(Sender: TObject);
 private
   { Private declarations }
   FilterBank : TFilterBank;
   procedure LoadAVI(const aviname : TFileName);
 public
   { Public declarations }
 end;

var
 MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
begin
  FilterBank := TFilterBank.Create;
  FilterBank.Enabled := true;
  // 'DeDynamic' will be inserted
  FilterBank.Insert('DirectShow Filters', 'DeDynamic', NilGUID, faInsert);
  // 'DC-DSP Filter' will be removed
  FilterBank.Insert('DirectShow Filters', 'DC-DSP Filter', NilGUID, faRemove);
end;

end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
     FilterGraph.Stop;
     FilterGraph.ClearGraph;
     FilterGraph.Active := false;
     FreeAndNIL(FilterBank);
end;

procedure TMainForm.LoadAVI(const aviname : TFileName);
 procedure WaitForFilterGraph;
 var
   pfs : TFilterState;
   hr : hresult;
 begin
      repeat
        hr := (FilterGraph as IMediaControl).GetState(50, pfs);
      until (hr = S_OK) or (hr = E_FAIL);
 end;
begin
       // usual init sequence
       if not FilterGraph.Active then FilterGraph.Active := true;
       FilterGraph.Stop;
       FilterGraph.ClearGraph;

       FilterBank.FiltersDestroy; // destroy old filters
       FilterBank.FiltersInit;    // init new filters
       FilterBank.FiltersConnectToGraph(FilterGraph); // connect to graph

       FilterGraph.RenderFile(WideString(aviname)); // render file
       WaitForFilterGraph; // little delay

       FilterGraph.Play;   // show first frame
       WaitForFilterGraph; // wait for first frame
       FilterGraph.Stop;   // stop graph for filter manipulation

       WaitForFilterGraph; // little delay
       FilterBank.FiltersDisconnectFromGraph(FilterGraph); // remove unwanted filters
       FilterGraph.Pause;
end;

procedure TMainForm.btnOpenClick(Sender: TObject);
begin
  if OpenDialog.Execute then LoadAVI(OpenDialog.FileName);
end;

procedure TMainForm.btnPlayClick(Sender: TObject);
begin
  if FilterGraph.Active then FilterGraph.Play;
end;

procedure TMainForm.btnStopClick(Sender: TObject);
begin
  if FilterGraph.Active then FilterGraph.Pause;
end;

*)


unit UFilterBank;

interface

uses SysUtils, DirectShow9, DSUtil, DSPack, ActiveX, INIFiles;

const
    NilGUID : TGUID = '{00000000-0000-0000-0000-000000000000}';

type
 TFilterAction = (faNone, faInsert, faRemove);

 TFilterItem = record
                 FilterAction : TFilterAction;
                 Category, Name : string;
                 CLSID : TGUID;
             end;

 TFilterBank = class
 private
   FEnabled : boolean;
   FTemp : boolean; // temporary flag (rewrite 'TempFilters' to 'Filters' during next 'Init')
   FFilters : array of TFilterItem; // main filter list
   FTempFilters : array of TFilterItem; // temporary filter list
   FBaseFilters : array of IBaseFilter; // pointers to filters
   function GetCount : integer;
   function GetItem(const index : integer) : TFilterItem;
   function CreateFilter(const CategoryName, FilterName : string; const aFilterCLSID : TGUID):IBaseFilter;
 public
   { Constructor method. }
   constructor Create;
   { Destructor method. }
   destructor Destroy; override;
   { Insert filter (category, name or CLSID) to filter list (temporary). }
   procedure Insert(const aCategory, aName : string; const aCLSID : TGUID; const aFilterAction : TFilterAction);
   { Remove filter from filter list (temporary). }
   procedure Remove(const index : integer);
   { Remove all filters from filter list (temporary). }
   procedure RemoveAll;
   { Initialize/create filters in filter list. Method rewrites all changes in <br>
     temporary filter list to main filter list first.}
   procedure FiltersInit;
   { Free all filters from filter list. }
   procedure FiltersDestroy;
   { Connect filters to filtergraph. }
   procedure FiltersConnectToGraph(var FilterGraph : TFilterGraph);
   { Disconnect filters from filtergraph. }
   procedure FiltersDisconnectFromGraph(var FilterGraph : TFilterGraph);
   { Save filter list to INI.}
   procedure SaveToINI(var IniFile : TMemIniFile; const INISection, INIEnabled,
                            ININame, INICategory, INICLSID, INIState : string);
   { Load filter list from INI. }
   procedure LoadFromINI(var IniFile : TMemIniFile; const INISection, INIEnabled,
                            ININame, INICategory, INICLSID, INIState : string);
 public
   { Get filters count. }
   property Count : integer read GetCount;
   { Enable property. }
   property Enabled : boolean read FEnabled write FEnabled;
   { Filter list. }
   property Filters[const index: integer]:TFilterItem read GetItem;
 end;

implementation

constructor TFilterBank.Create;
// Constructor.
begin
   FEnabled := true;
   FTemp := false; // temporary flag
   SetLength(FFilters, 0);
   SetLength(FTempFilters, 0);
   SetLength(FBaseFilters, 0);
end;

destructor TFilterBank.Destroy;
// Destructor.
begin
   FiltersDestroy;
   SetLength(FTempFilters, 0);
   SetLength(FFilters, 0);
   SetLength(FBaseFilters, 0);
   inherited Destroy;
end;

function TFilterBank.GetCount : integer;
begin
 if FTemp then // are there changes in temporary list? => read from it
   result := Length(FTempFilters)
 else
   result := Length(FFilters);
end;

function TFilterBank.GetItem(const index : integer) : TFilterItem;
// Get filter information.
begin
 result.FilterAction := faNone;
 result.Category := '';
 result.Name := '';
 result.CLSID := NilGUID;

 if FTemp then // are there changes in temporary list? => read from it
   begin
     if (index >= 0) and (index < Length(FTempFilters)) then
       result := FTempFilters[index];
   end
 else
   begin // there are no changes in temporary list => read from main list
     if (index >= 0) and (index < Length(FFilters)) then
       result := FFilters[index];
   end;
end;

function TFilterBank.CreateFilter(const CategoryName, FilterName : string; const aFilterCLSID : TGUID):IBaseFilter;
// Create filter by category and name or by its CLSID.
var
  SysDev : TSysdevEnum;
       i : integer;
begin
  // non nil CLSID? => create filter by its CLSID
 if not IsEqualGUID(aFilterCLSID, NilGUID) then
   if CoCreateInstance(aFilterCLSID, nil, CLSCTX_INPROC_SERVER, IID_IBaseFilter, result) = S_OK then exit;

 result := nil;

 SysDev := TSysDevEnum.Create;

 try
   i := sysdev.CountCategories - 1; // searching in categories
   while i >= 0 do
     begin
       if AnsiCompareText(SysDev.Categories[i].FriendlyName, CategoryName) = 0 then break;
       Dec(i);
     end;

   if i < 0 then exit;  // find anything?

   SysDev.SelectIndexCategory(i);
   i := SysDev.CountFilters - 1; // searching in filter names
   while i >= 0 do
     begin
       if AnsiCompareText(SysDev.Filters[i].FriendlyName, FilterName) = 0 then break;
       Dec(i);
     end;

   if i < 0 then exit;  // find anything?

   result := sysdev.GetBaseFilter(i); // return 'IBaseFilter' interface
 finally
   FreeAndNIL(sysdev);
 end;//try finally
end;

procedure TFilterBank.Insert(const aCategory, aName : string; const aCLSID : TGUID; const aFilterAction : TFilterAction);
// Insert filter to temporary list, sets temporary flag.
begin
 SetLength(FTempFilters, Length(FTempFilters)+1); // add item

 with FTempFilters[Length(FTempFilters)-1] do
   begin
     FilterAction := aFilterAction;
     Category := aCategory;
     Name := aName;
     CLSID := aCLSID;
   end;

 FTemp := true; // set temporary flag
end;

procedure TFilterBank.Remove(const index : integer);
// Remove filter from temporary list.
var
     i : integer;
begin
 if (index >= 0) and (index < Length(FTempFilters)) then
   begin

      if index < (Length(FFilters)-1) then
          for i := index to Length(FFilters)-1 do
             FTempFilters[i] := FTempFilters[i+1];

     SetLength(FFilters, Length(FTempFilters)-1);
   end;

 FTemp := true;
end;

procedure TFilterBank.RemoveAll;
// Remove all items from temporary list.
begin
 SetLength(FTempFilters, 0);
 FTemp := true;
end;

procedure TFilterBank.FiltersInit;
// Create filters.
var
 i : integer;
begin
 if not FEnabled then exit;

 if FTemp then // changes in temporary list? => rewrite them to main list
   begin
     FiltersDestroy;
     SetLength(FFilters, Length(FTempFilters)); // allocate space for list
     SetLength(FBaseFilters, Length(FTempFilters)); // allocate space for interfaces

     for i := 0 to Length(FTempFilters) - 1 do // zkopiruju
       begin
           FFilters[i] := FTempFilters[i];
           FBaseFilters[i] := nil;
       end;

     SetLength(FTempFilters, 0); // clear temporary list
     FTemp := false;
   end;

 for i := 0 to Length(FFilters)-1 do
   begin
     // insert this filter? => then must be created first
     if FFilters[i].FilterAction = faInsert then
       FBaseFilters[i] := CreateFilter(FFilters[i].Category, FFilters[i].Name, FFilters[i].CLSID);
   end;
end;

procedure TFilterBank.FiltersDestroy;
// Destroy filters.
var
 i : integer;
begin
  for i := 0 to Length(FBaseFilters) - 1 do
     FBaseFilters[i] := nil;
end;

procedure TFilterBank.FiltersConnectToGraph(var FilterGraph : TFilterGraph);
// Connect filters to 'FilterGraph'.
var
 i : integer;
 BaseFilter : IBaseFilter;
 s : WideString;
 FilterGraph2 : IFilterGraph2;
begin
 if not FEnabled then exit;

try
 if FilterGraph.QueryInterface(IID_IFilterGraph2, FilterGraph2) <> S_OK then exit;

 for i := 0 to Length(FFilters)-1 do
   begin
     // insert this filter?
     if (FFilters[i].FilterAction = faInsert) and assigned(FBaseFilters[i]) then
       begin
         s := FFilters[i].Name; // widestring conversion
         // isn't filter in filtergraph? => insert it
         if FilterGraph2.FindFilterByName(PWideChar(s),BaseFilter) <> S_OK then
           begin
             FilterGraph2.AddFilter(FBaseFilters[i], PWideChar(s));
             BaseFilter := nil;
           end;
       end;
   end;
finally
 FilterGraph2 := nil;
end;

end;

procedure TFilterBank.FiltersDisconnectFromGraph(var FilterGraph : TFilterGraph);
// Remove filter from 'FilterGraph'.
(*
  Picture describing variable names.

 previous filter     removed filter      following filter
             ---      ------------       ---
      OutPrevPin|----|InPin       |     |
                |    |            |     |
                |    |      OutPin|-----|InNextPin
             ---      ------------       ---
*)
var
    BaseFilter : IBaseFilter;
    OutPin, InPin, tmp : IPin;
    OutPrevPin, InNextPin : IPin;
    PinList, OutPinList, InPinList : TPinList;
    i, j : integer;
    FilterGraph2 : IFilterGraph2;
    GraphBuilder : IGraphBuilder;
begin
 if not FEnabled then exit;

try
 if FilterGraph.QueryInterface(IID_IFilterGraph2, FilterGraph2) <> S_OK then exit;
 if FilterGraph.QueryInterface(IID_IGraphBuilder, GraphBuilder) <> S_OK then exit;

 for j := 0 to Length(FFilters) - 1 do
   begin
     if FFilters[j].FilterAction = faRemove then // remove this filter?
       begin
       // is filter in filtergraph? => exit if not
       if FilterGraph2.FindFilterByName(StringToOleStr(FFilters[j].Name),BaseFilter) <> S_OK then Exit;

       PinList := TPinList.Create(BaseFilter); // get all pins
       InPinList := TPinList.Create; // create list for input pins
       OutPinList := TPinList.Create; // create list for output pins

       try
         for i := 0 to PinList.Count - 1 do // pass through all pins
           begin
             // is pin connected? => save it to the list
             if PinList.Items[i].ConnectedTo(tmp) = S_OK then
               begin
                 tmp := nil;
                 case PinList.PinInfo[i].dir of
                   PINDIR_INPUT  : InPinList.Add(PinList.Items[i]);
                   PINDIR_OUTPUT : OutPinList.Add(PinList.Items[i]);
                 end;
               end;
           end;

         // check - input and output pins count must agree
         if OutPinList.Count = InPinList.Count then
           begin
              for i := 0 to InPinList.Count-1 do // reconnect all pins
                begin
                  InPin := InPinList.First;  // get next pin
                  OutPin := OutPinList.First;  // get next pin
                  InPinList.Delete(0);
                  OutPinList.Delete(0);

                  // get previous and following filter pin
                  InPin.ConnectedTo(OutPrevPin);
                  OutPin.ConnectedTo(InNextPin);

                  // disconnect pins
                  GraphBuilder.Disconnect(OutPrevPin);
                  GraphBuilder.Disconnect(InPin);
                  GraphBuilder.Disconnect(OutPin);
                  GraphBuilder.Disconnect(InNextPin);

                  // connect previous filter pin to following filter pin
                  GraphBuilder.Connect(OutPrevPin, InNextPin);
                end;

              // remove filter
              (FilterGraph as IGraphBuilder).RemoveFilter(BaseFilter);

              InPin := nil;
              OutPin := nil;
              InNextPin := nil;
              OutPrevPin := nil;
              BaseFilter := nil;
           end;

       finally
         FreeAndNIL(PinList);
         FreeAndNIL(OutPinList);
         FreeAndNIL(InPinList);
       end;

       end; // if FFilters[j].FilterAction = faRemove
   end; // for j := 0 ...

finally
 FilterGraph2 := nil;
 GraphBuilder := nil;
end;

end;

procedure TFilterBank.SaveToINI(var IniFile : TMemIniFile; const INISection,
                INIEnabled, ININame, INICategory, INICLSID, INIState : string);
// Save filter info to INI.
var
 i : integer;
begin
 IniFile.WriteBool(INISection, INIEnabled, FEnabled);

 for i := 0 to Count - 1 do
   begin
     IniFile.WriteString(INISection, IntToStr(i+1)+ININame, Filters[i].Name);
     IniFile.WriteString(INISection, IntToStr(i+1)+INICategory, Filters[i].Category);
     IniFile.WriteString(INISection, IntToStr(i+1)+INICLSID, GUIDToString(Filters[i].CLSID));
     IniFile.WriteInteger(INISection, IntToStr(i+1)+INIState, integer(Filters[i].FilterAction));
   end;
end;

procedure TFilterBank.LoadFromINI(var IniFile : TMemIniFile; const INISection,
                INIEnabled, ININame, INICategory, INICLSID, INIState : string);
// Load filter information from INI.
var
 i, filtact : integer;
 filtname, filtcat, filtclsid : string;
 filtguid : TGUID;
begin
   RemoveAll;
   FEnabled := IniFile.ReadBool(INISection, INIEnabled, false);

   i := 1;
   repeat
      filtname := IniFile.ReadString(INISection, IntToStr(i)+ININame, '??');
      filtcat := IniFile.ReadString(INISection, IntToStr(i)+INICategory, '??');
      filtclsid := IniFile.ReadString(INISection, IntToStr(i)+INICLSID, '??');
      filtact := IniFile.ReadInteger(INISection, IntToStr(i)+INIState, ord(faNone));

      if (filtname <> '??') and (filtcat <> '??') then
        begin
          try
            filtguid := StringToGUID(filtclsid); // trying to convert
          except
            filtguid := NilGUID; // use nil if conversion failed
          end;
          Insert(filtcat, filtname, filtguid, TFilterAction(filtact));
        end;
     Inc(i);
   until (filtname = '??') or (filtcat = '??');
end;

end.
 
