unit CodecSettings;

interface

uses
  Classes, ExtCtrls, DSUtil, MMSystem, vfw, Utils;

type
  TICInfoArray = array of TICInfo;
  PICInfoArray = ^TICInfoArray;

  TICInfoObject = class
  private
    function GetInfos: boolean;
  public
    ICInfo: TICInfo;
    HasAboutBox,
    HasConfigureBox: boolean;
    constructor createFromICInfo(FromICInfo: TICInfo);
    constructor create;
    function HandlerFourCCString: string;
    function Name: string;
    function Description: string;
    function Driver: string;
    function Config(ParentWindow: THandle; var State: string; var SizeDecoded: Integer): boolean;
    function About(ParentWindow: THandle): boolean;
  end;

  TCodecList = class(TStringList)
  private
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


function ConfigCodec(ParentWindow: THandle; ICInfo: TICInfo; var State: string; var SizeDecoded: Integer): boolean;
function FillCodecInfo(var Info: TICInfo): boolean;
function EnumCodecs(fccType: FOURCC; var ICInfoArray: TICInfoArray): boolean;

implementation

uses
  Forms, Controls, StdCtrls, Dialogs,
  Windows, Types, SysUtils, Base64,
  DirectShow9;

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
  newFilterINfo^.FriendlyName := '(none)';
  newFilterInfo^.CLSID := GUID_NULL;
  result := 1;

  EnumFilters := TSysDevEnum.Create(CLSID_LegacyAmFilterCategory); //DirectShow Filters
  if not assigned(EnumFilters) then exit;

  ParentForm := progressLabel;
  while (ParentForm <> nil) and not (ParentForm is TCustomForm) do
    ParentForm := ParentForm.Parent;

  UpdateControlCaption(progressLabel, 'Checking Filters. Please wait ...');
  filterCount := EnumFilters.CountFilters;
  try
    For i := 0 to filterCount - 1 do
    begin
      try
        UpdateControlCaption(progressLabel, SysUtils.Format('Checking Filter (%3d/%3d)', [i+1, filterCount]));
        CheckFilter(EnumFilters, i, FilterBlackList);
      except
      on E: exception do
        begin
        showmessage('Error while checking Filter '+EnumFilters.Filters[i].FriendlyName +#13#10
                   +'ClassID: ' + GUIDTOString(EnumFilters.Filters[i].CLSID)+#13#10
                   +'Error: ' + E.Message);
        if ParentForm <> nil then ParentForm.Refresh;
        //raise;
        end;
      end;
    end;
  finally
    UpdateControlCaption(progressLabel, 'Checking Filters. Done.');
    FreeAndNIL(EnumFilters);
    result := self.FFilters.Count;
  end;
end;

{ TSourceFilterList }

function ConfigCodec(ParentWindow: THandle; ICInfo: TICInfo; var State: string; var SizeDecoded: Integer): boolean;
var
  Codec: HIC;
  BufferSize, SizeFromDecoding: DWORD;
  StateBuffer: Pointer;
begin
  result := false;
  Codec := ICOpen(ICInfo.fccType, ICInfo.fccHandler, ICMODE_COMPRESS);
  if Codec = 0 then exit;

  if State <>'' then begin
    //set old state
    Base64ToBuffer(State, StateBuffer, SizeFromDecoding);
    assert(SizeFromDecoding = SizeDecoded, 'Invalid Codec Settings.');
    BufferSize := SizeFromDecoding;
    ICSetState(Codec, StateBuffer, BufferSize);
  end else begin
    bufferSize := ICGetStateSize(Codec);
    Getmem(StateBuffer, BufferSize);
  end;

  try
    if (ICCOnfigure(Codec, ParentWindow) = ICERR_OK) then begin
      if (ICGetState(Codec, StateBuffer, BufferSize) = ICERR_OK) then begin
        state := BufferToBase64(StateBuffer, BufferSize);
        SizeDecoded := Integer(BufferSize);
      end else begin
        state := '';
      end;
    end;
  finally
    freemem(StateBuffer, BufferSize);
  end;
  assert(ICClose(Codec) = ICERR_OK, 'Could not close Compressor.');
  result := true;
end;

function FillCodecInfo(var Info: TICInfo): boolean;
var
  Codec: HIC;
begin
  result := false;
  Codec := ICOpen(Info.fccType, Info.fccHandler, ICMODE_QUERY);
  if codec=0 then exit;
  try
    result := (ICGetInfo(Codec, @Info, sizeof(Info)) = sizeof(Info));
  finally
    assert(ICClose(Codec) = ICERR_OK, 'Could not close Compressor.');
  end;
end;

function EnumCodecs(fccType: FOURCC; var ICInfoArray: TICInfoArray): boolean;
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

function TCodecList.Fill: Integer;
const
  fccTypeString = 'VIDC';
var
  Infos: TICInfoArray;
  InfoObject: TICInfoObject;
  i: integer;
begin
  result := 0;
  self.ClearAndFreeObjects;
  self.InsertDummy;

  if not EnumCodecs(mmioStringToFourcc(fccTypeString, MMIO_TOUPPER), Infos) then exit;
  for i := 0 to length(Infos)-1 do begin
{    FillCodecInfo(Infos[i]);
    InfoObject := TICInfoObject.Create;
    InfoObject.ICInfo := Infos[i];   }
    InfoObject := TICInfoObject.createFromICInfo(Infos[i]);
    self.AddObject('['+ InfoObject.HandlerFourCCString + '] '
                   + InfoObject.Name, InfoObject);
  end;
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

procedure TCodecList.InsertDummy;
var
  InfoObject: TICInfoObject;
begin
  InfoObject := TICInfoObject.create;
  InfoObject.ICInfo.fccType := ICTYPE_VIDEO;
  InfoObject.ICInfo.fccHandler := 0;
  InfoObject.ICInfo.dwVersion := 0;
  StringToWideChar('(none)', InfoObject.ICInfo.szName, 16);
  StringToWideChar('(Do not include Codec information)', InfoObject.ICInfo.szDescription, 128);
  self.AddObject(InfoObject.Name + ' use default', InfoObject);
end;

{ TICInfoObject }

constructor TICInfoObject.createFromICInfo(FromICInfo: TICInfo);
begin
  create;
  self.ICInfo := FromICInfo;
  self.GetInfos;
end;

function TICInfoObject.Description: string;
begin
  result := WideCharToString(ICInfo.szDescription)
end;

function TICInfoObject.Driver: string;
begin
  result := WideCharToString(ICInfo.szDriver)
end;

function TICInfoObject.HandlerFourCCString: string;
begin
  result := fcc2String(ICInfo.fccHandler)
end;

function TICInfoObject.GetInfos: boolean;
var
  Codec: HIC;
  returnedInfoSize: Cardinal;
begin
  result := false;
  Codec := ICOpen(ICInfo.fccType, ICInfo.fccHandler, ICMODE_QUERY);
  if codec=0 then exit;
  try
    HasAboutBox := ICQueryAbout(Codec);
    HasConfigureBox  := ICQueryConfigure(Codec);
    returnedInfoSize := ICGetInfo(Codec, @ICInfo, sizeof(ICInfo));
    result := (returnedInfoSize= sizeof(ICInfo));
  finally
    assert(ICClose(Codec) = ICERR_OK, 'Could not close Compressor.');
  end;
end;

function TICInfoObject.Name: string;
begin
  result := WideCharToString(ICInfo.szName)
end;

function TICInfoObject.Config(ParentWindow: THandle; var State: string;
  var SizeDecoded: Integer): boolean;
begin
  result := false;
  if not self.HasConfigureBox then exit;
  result := ConfigCodec(ParentWindow, ICInfo, State, SizeDecoded);
end;

function TICInfoObject.About(ParentWindow: THandle): boolean;
var
  Codec: HIC;
begin
  result := false;
  if not self.HasAboutBox then exit;
  Codec := ICOpen(ICInfo.fccType, ICInfo.fccHandler, ICMODE_QUERY);
  if codec=0 then exit;
  try
    if (ICAbout(Codec, ParentWindow) = ICERR_OK) then result := true;
  finally
    assert(ICClose(Codec) = ICERR_OK, 'Could not close Compressor.');
  end;
end;

constructor TICInfoObject.create;
begin
  inherited create;
  HasAboutBox := false;
  HasConfigureBox := false;
end;

end.
