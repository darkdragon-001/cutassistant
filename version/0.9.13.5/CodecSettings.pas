unit CodecSettings;

interface

uses
  Classes, ExtCtrls, DSUtil, MMSystem, vfw, Utils;

type
  TICInfoArray = array of TICInfo;
  PICInfoArray = ^TICInfoArray;

  TICInfoObject = class
  private
    FIsDummy: boolean;
    FICInfo: TICInfo;
    FHasAboutBox,
    FHasConfigureBox: boolean;
    function GetInfos: boolean;
  protected
    constructor Create;
    function ConfigCodec(ParentWindow: THandle; ICInfo: TICInfo; var State: string; var SizeDecoded: Integer): boolean;
  public
    constructor CreateDummy;
    constructor CreateFromICInfo(FromICInfo: TICInfo);
    function HandlerFourCCString: string;
    function Name: string;
    function Description: string;
    function Driver: string;
    function Config(ParentWindow: THandle; var State: string; var SizeDecoded: Integer): boolean;
    function About(ParentWindow: THandle): boolean;
    property IsDummy: boolean read FIsDummy;
    property ICInfo: TICInfo read FICInfo;
    property HasAboutBox: boolean read FHasAboutBox;
    property HasConfigureBox: boolean read FHasConfigureBox;
  end;

  TCodecList = class(TStringList)
  private
    function EnumCodecs(fccType: FOURCC; var ICInfoArray: TICInfoArray): boolean;
    function GetCodecInfo(i: Integer): TICInfo;
    function GetCodecInfoObject(i: Integer): TICInfoObject;
  public
    constructor create;
    destructor Destroy; override;
    procedure ClearAndFreeObjects;
    procedure InsertDummy;
    function Fill: Integer;
    function IndexOfCodec(fccHandler: FOURCC): Integer;
    property CodecInfo[i: Integer]: TICInfo read GetCodecInfo;
    property CodecInfoObject[i: Integer]: TICInfoObject read GetCodecInfoObject;
  end;

  TSourceFilterList = class
  private
    FFilters: TList;
    procedure ClearFilterList;
    function Add: PFilCatNode;
    function GetFilter(Index: Integer): TFilCatNode;
    function CheckFilter(EnumFilters: TSysDevEnum; index: integer; FilterBlackList: TGUIDList): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function Fill(progressLabel: TPanel; FilterBlackList: TGUIDList): Integer;
    function count: Integer;
    property GetFilterInfo[Index: Integer]: TFilCatNode read GetFilter;
    function GetFilterIndexByCLSID(CLSID: TGUID): Integer;
  end;


implementation

uses
  Forms, Controls, StdCtrls, Dialogs,
  Windows, Types, SysUtils, Base64,
  DirectShow9, CAResources;

{ TSourceFilterList }

procedure TSourceFilterList.ClearFilterList;
var
  i: Integer;
begin
  for i := 0 to (FFilters.Count - 1) do
    if assigned(FFilters.Items[i]) then Dispose(FFilters.Items[i]);
  FFilters.Clear;
end;

function TSourceFilterList.GetFilter(Index: Integer): TFilCatNode;
var
  FilterInfo: PFilCatNode;
begin
  FilterINfo := FFilters.Items[Index];
  result := FilterInfo^;
end;

function TSourceFilterList.Add: PFilCatNode;
var
  newFilterINfo: PFilCatNode;
begin
  new(newFilterINfo);
  self.FFilters.Add(newFilterINfo);
  result := newFilterInfo;
end;

function TSourceFilterList.GetFilterIndexByCLSID(CLSID: TGUID): Integer;
var
  i: integer;
begin
  result := -1;
  for i := 0 to self.count -1 do begin
    if isEqualGUID(CLSID, self.GetFilterInfo[i].CLSID) then begin
      result := i;
      break;
    end;
  end;
end;

procedure UpdateControlCaption(cntrl: TControl; s: string);
begin
  if cntrl = nil then exit;

  if cntrl is TPanel then
  begin
    with cntrl as TPanel do
    begin
      Caption := s;
      Refresh;
    end;
  end
  else if cntrl is TLabel then
  begin
    with cntrl as TLabel do
    begin
      Caption := s;
      Refresh;
    end;
  end
end;

function TSourceFilterList.count: Integer;
begin
  result := FFilters.Count;
end;

constructor TSourceFilterList.create;
begin
  FFilters := TList.Create;
end;

destructor TSourceFilterList.destroy;
begin
  ClearFilterList;
  FreeAndNil(FFilters);
  inherited;
end;

function TSourceFilterList.CheckFilter(EnumFilters: TSysDevEnum; index: integer; FilterBlackList: TGUIDList): Boolean;
const
  CLS_ID_WMT_LOG_FILTER: TGUID = '{92883667-E95C-443D-AC96-4CACA27BEB6E}';
var
  Filter: IBaseFilter;
  newFilterInfo: PFilCatNode;
  filterInfo: TFilCatNode;
begin
  Result := false;
  filterInfo := EnumFilters.Filters[index];
  //Skip Wmt Log Filter -> causing strange exception
  if not ( IsEqualGUID(filterInfo.CLSID, CLS_ID_WMT_LOG_FILTER)
    or FilterBlackList.IsInList(filterInfo.CLSID) ) then
  begin
    Filter := EnumFilters.GetBaseFilter(index);
    if supports(Filter, IFileSourceFilter) then
    begin
      newFilterInfo := self.Add;
      newFilterINfo^  := filterInfo;
      Result := true;
    end;
    Filter:=nil;
  end;
end;

function TSourceFilterList.Fill(progressLabel: TPanel; FilterBlackList: TGUIDList): Integer;
var
  EnumFilters: TSysDevEnum;
  i, filterCount: Integer;
  newFilterInfo: PFilCatNode;
  ParentForm: TWinControl;
begin
  self.ClearFilterList;
  newFilterInfo := self.Add;
  newFilterINfo^.FriendlyName := '(' + CAResources.RsSourceFilterNone + ')';
  newFilterInfo^.CLSID := GUID_NULL;
  result := 1;

  EnumFilters := TSysDevEnum.Create(CLSID_LegacyAmFilterCategory); //DirectShow Filters
  if not assigned(EnumFilters) then exit;

  ParentForm := progressLabel;
  while (ParentForm <> nil) and not (ParentForm is TCustomForm) do
    ParentForm := ParentForm.Parent;

  UpdateControlCaption(progressLabel, CAResources.RsCheckingSourceFilterStart);
  filterCount := EnumFilters.CountFilters;
  try
    For i := 0 to filterCount - 1 do
    begin
      try
        UpdateControlCaption(progressLabel, SysUtils.Format(CAResources.RsCheckingSourceFilter, [i+1, filterCount]));
        CheckFilter(EnumFilters, i, FilterBlackList);
      except
      on E: exception do
        begin
          ShowMessageFmt(CAResources.RsErrorCheckingSourceFilter, [
            EnumFilters.Filters[i].FriendlyName,
            GUIDTOString(EnumFilters.Filters[i].CLSID),
            E.Message ]);
          if ParentForm <> nil then
            ParentForm.Refresh;
          //raise;
        end;
      end;
    end;
  finally
    UpdateControlCaption(progressLabel, CAResources.RsCheckingSourceFilterEnd);
    FreeAndNIL(EnumFilters);
    result := self.FFilters.Count;
  end;
end;

{ TCodecList }

procedure TCodecList.ClearAndFreeObjects;
var
  i: Integer;
begin
  for i := 0 to self.Count -1 do begin
    if assigned(self.Objects[i]) then begin
      self.Objects[i].Free;
      self.Objects[i] := nil;
    end;
  end;
  self.Clear;
end;

constructor TCodecList.create;
begin
  self.InsertDummy;
end;

destructor TCodecList.destroy;
begin
  self.ClearAndFreeObjects;
  inherited;
end;

function CompareByInfoName(List: TStringList; Index1, Index2: Integer): Integer;
var
  CodecList: TCodecList;
  InfoObject1: TICInfoObject;
  InfoObject2: TICInfoObject;
begin
  if List is TCodecList then begin
    CodecList := List as TCodecList;
    InfoObject1 := CodecList.CodecInfoObject[Index1];
    InfoObject2 := CodecList.CodecInfoObject[Index2];
    if Assigned(InfoObject1) and Assigned(InfoObject2) then begin
      if InfoObject1.IsDummy then
      begin
        if InfoObject2.IsDummy then Result := 0
        else Result := -1;
      end
      else if InfoObject2.IsDummy then Result := 1
      else Result := AnsiCompareText(InfoObject1.Name, InfoObject2.Name);
      Exit;
    end;
  end;
  if List.CaseSensitive then
    Result := AnsiCompareStr(List[Index1], List[Index2])
  else
    Result := AnsiCompareText(List[Index1], List[Index2]);
end;

function TCodecList.EnumCodecs(fccType: FOURCC; var ICInfoArray: TICInfoArray): boolean;
var
  i: integer;
begin
  result := false;
  i := 0;
  while true do begin
    setlength(ICInfoArray, i+1);
    if not ICInfo(fccType, DWord(i), @ICInfoArray[i]) then break;
    inc(i)
  end;
  setlength(ICInfoArray, i);
  if i>0 then result := true;
end;

function TCodecList.Fill: Integer;
var
  Infos: TICInfoArray;
  InfoObject: TICInfoObject;
  i: integer;
begin
  result := 0;
  self.ClearAndFreeObjects;
  self.InsertDummy;

  if not EnumCodecs(ICTYPE_VIDEO, Infos) then
    exit;
  for i := 0 to length(Infos)-1 do
  begin
    InfoObject := TICInfoObject.createFromICInfo(Infos[i]);
    self.AddObject(Format('[%s] %s', [ InfoObject.HandlerFourCCString, InfoObject.Name] ), InfoObject);
  end;
  self.CustomSort(CompareByInfoName);
end;

procedure TCodecList.InsertDummy;
var
  InfoObject: TICInfoObject;
begin
  InfoObject := TICInfoObject.CreateDummy;
  self.AddObject(Format('(%s) %s', [ CAResources.RsCodecUseDefault, InfoObject.Name] ), InfoObject);
end;

function TCodecList.GetCodecInfo(i: Integer): TICInfo;
begin
  result := (self.Objects[i] as TICInfoObject).ICInfo
end;

function TCodecList.GetCodecInfoObject(i: Integer): TICInfoObject;
begin
  result := (self.Objects[i] as TICInfoObject);
end;

function TCodecList.IndexOfCodec(fccHandler: FOURCC): Integer;
var
  i: integer;
begin
  result := -1;
  for i := 0 to self.Count -1 do begin
    if self.CodecInfo[i].fccHandler = fccHandler then begin
      result := i;
      break;
    end;
  end;
end;

{ TICInfoObject }

constructor TICInfoObject.create;
begin
  inherited create;
  FHasAboutBox := false;
  FHasConfigureBox := false;
  FIsDummy := true;
end;

constructor TICInfoObject.CreateDummy;
begin
  Create;
  self.FICInfo.fccType := ICTYPE_VIDEO;
  self.FICInfo.fccHandler := 0;
  self.FICInfo.dwVersion := 0;
  StringToWideChar(CAResources.RsCodecDummyName, self.FICInfo.szName, 16);
  StringToWideChar(CAResources.RsCodecDummyDesc, self.FICInfo.szDescription, 128);
end;

constructor TICInfoObject.createFromICInfo(FromICInfo: TICInfo);
begin
  create;
  FIsDummy := false;
  self.FICInfo := FromICInfo;
  self.GetInfos;
end;

function TICInfoObject.GetInfos: boolean;
var
  Codec: HIC;
  returnedInfoSize: Cardinal;
begin
  result := false;
  Codec := ICOpen(FICInfo.fccType, FICInfo.fccHandler, ICMODE_QUERY);
  if codec=0 then exit;
  try
    FHasAboutBox := ICQueryAbout(Codec);
    FHasConfigureBox  := ICQueryConfigure(Codec);
    returnedInfoSize := ICGetInfo(Codec, @FICInfo, sizeof(FICInfo));
    result := (returnedInfoSize= sizeof(FICInfo));
  finally
    assert(ICClose(Codec) = ICERR_OK, CAResources.RsErrorCloseCodec);
  end;
end;

function TICInfoObject.Name: string;
begin
  result := WideCharToString(FICInfo.szName)
end;

function TICInfoObject.Description: string;
begin
  result := WideCharToString(FICInfo.szDescription)
end;

function TICInfoObject.Driver: string;
begin
  result := WideCharToString(FICInfo.szDriver)
end;

function TICInfoObject.HandlerFourCCString: string;
begin
  result := fcc2String(FICInfo.fccHandler)
end;

function TICInfoObject.Config(ParentWindow: THandle; var State: string;
  var SizeDecoded: Integer): boolean;
begin
  result := false;
  if not self.HasConfigureBox then exit;
  result := ConfigCodec(ParentWindow, FICInfo, State, SizeDecoded);
end;

function TICInfoObject.ConfigCodec(ParentWindow: THandle; ICInfo: TICInfo; var State: string; var SizeDecoded: Integer): boolean;
var
  Codec: HIC;
  BufferSize: DWORD;
  StateData: string;
  StateBuffer: Pointer;
begin
  result := false;
  StateBuffer := nil;
  Codec := ICOpen(ICInfo.fccType, ICInfo.fccHandler, ICMODE_COMPRESS);
  if Codec = 0 then exit;

  if (Length(State) > 0) and (Length(State) mod 4 = 0) then begin
    StateData := Base64ToStr(State);
    BufferSize := Length(StateData);
    // set old state
    try
      StringToBuffer(StateData, StateBuffer, BufferSize);
      ICSetState(Codec, StateBuffer, BufferSize);
    finally
      if Assigned(StateBuffer) then
        FreeMem(StateBuffer, BufferSize);
      StateBuffer := nil;
    end;
  end;

  if (ICConfigure(Codec, ParentWindow) = ICERR_OK) then begin
    BufferSize := ICGetStateSize(Codec);
    GetMem(StateBuffer, BufferSize);
    try
      if (ICGetState(Codec, StateBuffer, BufferSize) = ICERR_OK) then begin
        StateData := BufferToString(StateBuffer, BufferSize);
        State := StrTobase64(StateData);
        SizeDecoded := Length(StateData);
      end else begin
        State := '';
        SizeDecoded := 0;
      end;
    finally
      if Assigned(StateBuffer) then
        FreeMem(StateBuffer, BufferSize);
      StateBuffer := nil;
    end;
  end;
  assert(ICClose(Codec) = ICERR_OK, CAResources.RsErrorCloseCodec);
  result := true;
end;

function TICInfoObject.About(ParentWindow: THandle): boolean;
var
  Codec: HIC;
begin
  result := false;
  if not self.HasAboutBox then exit;
  Codec := ICOpen(FICInfo.fccType, FICInfo.fccHandler, ICMODE_QUERY);
  if codec=0 then exit;
  try
    if (ICAbout(Codec, ParentWindow) = ICERR_OK) then result := true;
  finally
    assert(ICClose(Codec) = ICERR_OK, CAResources.RsErrorCloseCodec);
  end;
end;

end.