unit CodecSettings;

interface

uses
  classes, MMSystem, vfw;

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
    destructor destroy;
    procedure ClearAndFreeObjects;
    procedure InsertDummy;
    function Fill: Integer;
    function IndexOfCodec(fccHandler: FOURCC): Integer;
    property CodecInfo[i: Integer]: TICInfo read GetCodecInfo;
    property CodecInfoObject[i: Integer]: TICInfoObject read GetCodecInfoObject;
  end;

function ConfigCodec(ParentWindow: THandle; ICInfo: TICInfo; var State: string; var SizeDecoded: Integer): boolean;
function FillCodecInfo(var Info: TICInfo): boolean;
function EnumCodecs(fccType: FOURCC; var ICInfoArray: TICInfoArray): boolean;

implementation

uses
  Forms, Windows, Base64, Utils;

function ConfigCodec(ParentWindow: THandle; ICInfo: TICInfo; var State: string; var SizeDecoded: Integer): boolean;
var
  Codec: HIC;
  bufferSize, SizeFromDecoding: DWORD;
  StateBuffer: Pointer;
begin
  result := false;
  Codec := ICOpen(ICInfo.fccType, ICInfo.fccHandler, ICMODE_COMPRESS);
  if Codec = 0 then exit;

  bufferSize := ICGetStateSize(Codec);
  if State <>'' then begin
    //set old state
    Base64ToBuffer(State, StateBuffer, SizeFromDecoding);
    assert(SizeFromDecoding = SizeDecoded, 'Invalid Codec Settings.');
    if BufferSize = SizeFromDecoding then begin
      ICSetState(Codec, StateBuffer, bufferSize);
    end else begin
      FreeMem(StateBuffer, SizeFromDecoding);
      Getmem(StateBuffer, bufferSize);
    end;
  end else begin
    Getmem(StateBuffer, bufferSize);
  end;

  try
  if (ICCOnfigure(Codec, ParentWindow) = ICERR_OK) then begin
    if (ICGetState(Codec, StateBuffer, bufferSize) = ICERR_OK) then begin
      state := BufferToBase64(StateBuffer, bufferSize);
      SizeDecoded := Integer(bufferSize);
    end else begin
      state := '';
    end;
  end;
  finally
    freemem(StateBuffer, bufferSize);
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
    if assigned(self.Objects[i]) then self.Objects[i].Free;
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
  Info: TICInfo;
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
