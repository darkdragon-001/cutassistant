unit Utils;

interface

uses
  Classes, Forms, StdCtrls, Windows, Graphics,
  SysUtils, IniFiles, MMSystem, DSUtil, madExcept,
  IdMultipartFormData;

const
  Application_name ='Cut_assistant.exe';   //for use in cutlist files etc.

const // Multimedia key codes
  VK_BROWSER_BACK = $A6;
  {$EXTERNALSYM VK_BROWSER_BACK}
  VK_BROWSER_FORWARD = $A7;
  {$EXTERNALSYM VK_BROWSER_FORWARD}
  VK_BROWSER_REFRESH = $A8;
  {$EXTERNALSYM VK_BROWSER_REFRESH}
  VK_BROWSER_STOP = $A9;
  {$EXTERNALSYM VK_BROWSER_STOP}
  VK_BROWSER_SEARCH = $AA;
  {$EXTERNALSYM VK_BROWSER_SEARCH}
  VK_BROWSER_FAVORITES = $AB;
  {$EXTERNALSYM VK_BROWSER_FAVORITES}
  VK_BROWSER_HOME = $AC;
  {$EXTERNALSYM VK_BROWSER_HOME}

  VK_VOLUME_MUTE = $AD;
  {$EXTERNALSYM VK_VOLUME_MUTE}
  VK_VOLUME_DOWN = $AE;
  {$EXTERNALSYM VK_VOLUME_DOWN}
  VK_VOLUME_UP = $AF;
  {$EXTERNALSYM VK_VOLUME_UP}
  VK_MEDIA_NEXT_TRACK = $B0;
  {$EXTERNALSYM VK_MEDIA_NEXT_TRACK}
  VK_MEDIA_PREV_TRACK = $B1;
  {$EXTERNALSYM VK_MEDIA_PREV_TRACK}
  VK_MEDIA_STOP = $B2;
  {$EXTERNALSYM VK_MEDIA_STOP}
  VK_MEDIA_PLAY_PAUSE = $B3;
  {$EXTERNALSYM VK_MEDIA_PLAY_PAUSE}
  VK_LAUNCH_MAIL = $B4;
  {$EXTERNALSYM VK_LAUNCH_MAIL}
  VK_LAUNCH_MEDIA_SELECT = $B5;
  {$EXTERNALSYM VK_LAUNCH_MEDIA_SELECT}
  VK_LAUNCH_APP1 = $B6;
  {$EXTERNALSYM VK_LAUNCH_APP1}
  VK_LAUNCH_APP2 = $B7;
  {$EXTERNALSYM VK_LAUNCH_APP2}


//global Vars
var
  batchmode: boolean;

type
  ARFileVersion = array[0..3] of WORD;

  RCutAppSettings = record
    CutAppName: string;
    PreferredSourceFilter: TGUID;
    CodecName: string;
    CodecFourCC: FOURCC;
    CodecVersion: DWORD;
    CodecSettingsSize: integer;
    CodecSettings: string;
  end;

  THttpRequest = class(TObject)
  private
    FUrl: string;
    FHandleRedirects: boolean;
    FResponse: string;
    FErrorMessage: string;
    FPostData: TIdMultiPartFormDataStream;
    FIsPost: boolean;
  public
    constructor Create(const Url: string; const handleRedirects: boolean; const Error_message: string); overload;
    destructor Destroy; override;
  protected
    procedure SetIsPost(const value: boolean);
  published
    property IsPostRequest: boolean read FIsPost write SetIsPost;
    property Url: string read FUrl write FUrl;
    property HandleRedirects: boolean read FHandleRedirects write FHandleRedirects;
    property Response: string read FResponse write FResponse;
    property ErrorMessage: string read FErrorMessage write FErrorMessage;
    property PostData: TIdMultiPartFormDataStream read FPostData;
  end;

  { TGUIDList - A strong typed list for TGUID }

  TGUIDList = class
  private
    FGUIDList: Array of TGUID;
    FCount: Integer;
    function GetItem(Index: Integer): TGUID;
    procedure SetItem(Index: Integer; const Value: TGUID);
    function GetItemString(Index: Integer): string;
    procedure SetItemString(Index: Integer; const Value: string);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property Item[Index: Integer]: TGUID read GetItem write SetItem; default;
    property ItemString[Index: Integer]: string read GetItemString write SetItemString;
    procedure Clear;
    function Add(aGUID: TGUID): Integer;
    function AddFromString(aGUIDString: string): Integer;
    procedure Delete(Index: Integer); overload;
    procedure Delete(Item: TGUID); overload;
    function IndexOf(aGUID: TGUID): Integer; overload;
    function IndexOf(aGUIDString: string): Integer; overload;
    function IsInList(aGUID: TGUID): boolean; overload;
    function IsInList(aGUIDString: string): boolean; overload;
    property Count: Integer read FCount;
  end;

  { TMemIniFileEx - An enhanced version of TMemIniFile that has more
    strong typed read and write methods. If FileName is empty, the file
    will not get saved to disk. }

  TMemIniFileEx = class(TMemIniFile)
  private
    FFormatSettings: TFormatSettings;
    FVolatile: boolean;
    function GetIsVolatile: boolean;
  published
    property Volatile: boolean read FVolatile write FVolatile default false;
    property IsVolatile: boolean read GetIsVolatile;
  public
    constructor Create(const FileName: string); overload;
    constructor Create(const FileName: string; const formatSettings: TFormatSettings); overload;

    function ReadFloat(const Section, Name: String; Default: Double): Double; override;
    procedure WriteFloat(const Section, Name: String; Value: Double); override;

    function ReadDate (const Section, Name: String; Default: TDateTime): TDateTime; override;
    procedure WriteDate(const Section, Name: String; Value: TDateTime); override;
    function ReadTime (const Section, Name: String; Default: TDateTime): TDateTime; override;
    procedure WriteTime(const Section, Name: String; Value: TDateTime); override;
    function ReadDateTime (const Section, Name: String; Default: TDateTime): TDateTime; override;
    procedure WriteDateTime(const Section, Name: String; Value: TDateTime); override;

    function ReadRect(const Section, Prefix: String; const Default: TRect): TRect; virtual;
    procedure WriteRect(const Section, Prefix: string; const Value: TRect); virtual;

    function ReadGuid(const Section, Name: String; const Default: TGUID): TGUID; virtual;
    procedure WriteGuid(const Section, Name: string; const Value: TGUID); virtual;

    procedure ReadCutAppSettings(const Section: string; var CutAppSettings: RCutAppSettings);
    procedure WriteCutAppSettings(const Section: string; var CutAppSettings: RCutAppSettings);

    procedure UpdateFile; override;

    function GetDataString: string;

    procedure LoadFromStream(const Stream: TStream);
    procedure SaveToStream(const Stream: TStream);
  end;

  procedure PatchINT3;

  function rand_string: string;
  function Get_File_Version(const FileName: string): string; overload;
  function Get_File_Version(const FileName: string; var FileVersionMS, FileVersionLS: DWORD): boolean; overload;
  function Application_version: string;
  function Application_Dir: string;
  function Application_Friendly_Name: string;
  function UploadData_Path(useCSV: boolean): string;
  function cleanURL(aURL: String): String;
  function cleanFileName(const filename: string): string;
  procedure ListBoxToClipboard(ListBox: TListBox; BufferSizePerLine: Integer; CopyAll: Boolean);
  function STO_ShellExecute(const AppName, AppArgs: String; const Wait: Cardinal;
    const Hide: Boolean; var ExitCode: DWORD): Boolean;
  function STO_ShellExecute_Capture(const AppName, AppArgs: String; const Wait: Cardinal;
    const Hide: Boolean; var ExitCode: DWORD; AMemo: TMemo): Boolean;
  function CallApplication(AppPath, Command: string; var ErrorString: String): boolean;
  function secondsToTimeString(t: double): string;
  function fcc2String(fcc: DWord): String;
  function SaveBitmapAsJPEG(ABitmap: TBitmap; FileName: string): boolean;

  function IsPathRooted(const Path: string): boolean;

  function CtrlDown : Boolean;
  function ShiftDown : Boolean;
  function AltDown : Boolean;

  function ValidRect(const ARect: TRect): boolean;

  // Use in Create event of form to fix scaling when screen resolution changes.
  procedure ScaleForm(const F: TForm); overload;
  procedure ScaleForm(const F: TForm; const ScreenWidthDev, ScreenHeightDev: Integer); overload;

  // Fix Borland QC Report 13832: Constraints don't obey form Scaled property
  procedure AdjustFormConstraints (form : TForm);

  //ini.ReadString does work only up to 2047 characters due to restrictions in iniFiles.pas
  function iniReadLargeString(
    const ini: TCustomIniFile;
    const BufferSize: integer;
    const section, name, default: string): string;

  procedure ReadCutAppSettings(
    const ini: TCustomIniFile;
    const section: string;
    var CutAppSettings: RCutAppSettings);
  procedure WriteCutAppSettings(
    const ini: TCustomIniFile;
    const section: string;
    var CutAppSettings: RCutAppSettings);

  function FilterInfoToString(const filterInfo: TFilCatNode): string;
  function StringToFilterGUID(const s: string): TGUID;

  procedure ShowExpectedException(const Header: string);

  function iniReadRect(const ini: TCustomIniFile; const section, name: string; const default: TRect): TRect;
  procedure iniWriteRect(const ini: TCustomIniFile; const section, name: string; const value: TRect);

  Function MakeFourCC(const a,b,c,d: char): DWord;

  function Parse_File_Version(const VersionStr: string): ARFileVersion;

  function FloatToStrInvariant(Value: Extended): string;

  function FilterStringFromExtArray(ExtArray: array of string): string;
  function MakeFilterString(const description: string; const extensions: string): string;

implementation

{$I jedi.inc}

uses
  Messages, Dialogs, ShellAPI, Variants, Clipbrd, StrUtils, jpeg,
  Types, DirectShow9, Math;


const ScreenWidthDev  = 1280;
      ScreenHeightDev = 1024;

var
  invariantFormat: TFormatSettings;

function MakeFilterString(const description: string; const extensions: string): string;
begin
  Result := Format('%s (%s)|%s', [ description, extensions, extensions ]);
end;

function FilterStringFromExtArray(ExtArray: array of string): string;
var
  i: Integer;
begin
  result := '';
  for i := 0 to length(ExtArray) - 1 do begin
    if i> 0 then result := result + ';';
    result := result + '*' + ExtArray[i];
  end;
end;

constructor TMemIniFileEx.Create(const FileName: string);
begin
  inherited Create(FileName);
  FVolatile := false;
  GetLocaleFormatSettings($007F, FFormatSettings);
end;

constructor TMemIniFileEx.Create(const FileName: string; const formatSettings: TFormatSettings);
begin
  inherited Create(FileName);
  FVolatile := false;
  FFormatSettings := formatSettings;
end;

function TMemIniFileEx.GetIsVolatile: boolean;
begin
  Result := FVolatile or (FileName = '');
end;

procedure TMemIniFileEx.UpdateFile;
begin
  if (not Volatile) and (FileName <> '') then
    inherited UpdateFile;
end;

function TMemIniFileEx.ReadFloat(const Section, Name: String; Default: Double): Double;
var
  FloatStr: string;
begin
  FloatStr := ReadString(Section, Name, '');
  Result := Default;
  if FloatStr <> '' then
  try
    Result := StrToFloat(FloatStr, FFormatSettings);
  except
    on EConvertError do
      // Ignore EConvertError exceptions
    else
      raise;
  end;
end;

function TMemIniFileEx.ReadDate(const Section, Name: String; Default: TDateTime): TDateTime;
var
  DateStr: string;
begin
  DateStr := ReadString(Section, Name, '');
  Result := Default;
  if DateStr <> '' then
  try
    Result := StrToDate(DateStr, FFormatSettings);
  except
    on EConvertError do
      // Ignore EConvertError exceptions
    else
      raise;
  end;
end;

function TMemIniFileEx.ReadDateTime(const Section, Name: String; Default: TDateTime): TDateTime;
var
  DateStr: string;
begin
  DateStr := ReadString(Section, Name, '');
  Result := Default;
  if DateStr <> '' then
  try
    Result := StrToDateTime(DateStr, FFormatSettings);
  except
    on EConvertError do
      // Ignore EConvertError exceptions
    else
      raise;
  end;
end;

function TMemIniFileEx.ReadTime(const Section, Name: String; Default: TDateTime): TDateTime;
var
  TimeStr: string;
begin
  TimeStr := ReadString(Section, Name, '');
  Result := Default;
  if TimeStr <> '' then
  try
    Result := StrToTime(TimeStr, FFormatSettings);
  except
    on EConvertError do
      // Ignore EConvertError exceptions
    else
      raise;
  end;
end;

procedure TMemIniFileEx.WriteDate(const Section, Name: String; Value: TDateTime);
begin
  WriteString(Section, Name, DateToStr(Value, FFormatSettings));
end;

procedure TMemIniFileEx.WriteDateTime(const Section, Name: String; Value: TDateTime);
begin
  WriteString(Section, Name, DateTimeToStr(Value, FFormatSettings));
end;

procedure TMemIniFileEx.WriteFloat(const Section, Name: String; Value: Double);
begin
  WriteString(Section, Name, FloatToStr(Value, FFormatSettings));
end;

procedure TMemIniFileEx.WriteTime(const Section, Name: String; Value: TDateTime);
begin
  WriteString(Section, Name, TimeToStr(Value, FFormatSettings));
end;

function TMemIniFileEx.ReadRect(const Section, Prefix: String; const Default: TRect): TRect;
begin
  Result.Left := ReadInteger(Section, Prefix + '_Left', Default.Left);
  Result.Top := ReadInteger(Section, Prefix + '_Top', Default.Top);
  Result.Right := Result.Left + ReadInteger(Section, Prefix + '_Width', Default.Right - Default.Left);
  Result.Bottom := Result.Top + ReadInteger(Section, Prefix + '_Height', Default.Bottom - Default.Top);
end;

procedure TMemIniFileEx.WriteRect(const Section, Prefix: string; const Value: TRect);
begin
  WriteInteger(Section, Prefix + '_Left', Value.Left);
  WriteInteger(Section, Prefix + '_Top', Value.Top);
  WriteInteger(Section, Prefix + '_Width', Value.Right - Value.Left);
  WriteInteger(Section, Prefix + '_Height', Value.Bottom - Value.Top);
end;

function TMemIniFileEx.ReadGuid(const Section, Name: String; const Default: TGUID): TGUID;
var
  GuidStr: string;
begin
  GuidStr := ReadString(Section, Name, '');
  Result := Default;
  if GuidStr <> '' then
  try
    Result := StringToGUID(GuidStr);
  except
    on EConvertError do
      // ignore EConvertError exceptions
    else
      raise
  end;
end;

procedure TMemIniFileEx.WriteGuid(const Section, Name: string; const Value: TGUID);
begin
  WriteString(Section, Name, GUIDToString(Value));
end;

procedure TMemIniFileEx.ReadCutAppSettings(const Section: string; var CutAppSettings: RCutAppSettings);
var
  BufferSize: integer;
begin
  CutAppSettings.CutAppName := ReadString(Section, 'AppName', '');
  CutAppSettings.PreferredSourceFilter := ReadGuid(Section, 'PreferredSourceFilter', GUID_NULL);
  CutAppSettings.CodecName := ReadString(Section, 'CodecName', '');
  CutAppSettings.CodecFourCC := ReadInteger(Section, 'CodecFourCC', 0);
  CutAppSettings.CodecVersion := ReadInteger(Section, 'CodecVersion', 0);
  CutAppSettings.CodecSettingsSize := ReadInteger(Section, 'CodecSettingsSize', 0);
  CutAppSettings.CodecSettings := ReadString(Section, 'CodecSettings', '');

  BufferSize := CutAppSettings.CodecSettingsSize div 3;
  if (CutAppSettings.CodecSettingsSize mod 3) > 0 then
    Inc(BufferSize);
  BufferSize := BufferSize * 4 + 1;        //+1 for terminating #0
  if Length(CutAppSettings.CodecSettings) <> BufferSize - 1 then
  begin
     CutAppSettings.CodecSettings := '';
     CutAppSettings.CodecSettingsSize := 0;
  end;
end;

procedure TMemIniFileEx.WriteCutAppSettings(const Section: string; var CutAppSettings: RCutAppSettings);
begin
  EraseSection(Section);
  WriteString(Section, 'AppName', CutAppSettings.CutAppName);
  WriteGuid(Section, 'PreferredSourceFilter', CutAppSettings.PreferredSourceFilter);
  WriteString(Section, 'CodecName', CutAppSettings.CodecName);
  WriteInteger(Section, 'CodecFourCC', CutAppSettings.CodecFourCC);
  WriteInteger(Section, 'CodecVersion', CutAppSettings.CodecVersion);
  WriteInteger(Section, 'CodecSettingsSize', CutAppSettings.CodecSettingsSize);
  WriteString(Section, 'CodecSettings', CutAppSettings.CodecSettings);
end;

function TMemIniFileEx.GetDataString: string;
var
  List: TStringList;
begin
  List := TStringList.Create;
  try
    GetStrings(List);
    Result := List.Text;
  finally
    FreeAndNil(List);
  end;
end;

procedure TMemIniFileEx.LoadFromStream(const Stream: TStream);
var
  List: TStringList;
begin
  List := TStringList.Create;
  try
    List.LoadFromStream(Stream);
    SetStrings(List);
  finally
    FreeAndNil(List);
  end;
end;

procedure TMemIniFileEx.SaveToStream(const Stream: TStream);
var
  List: TStringList;
begin
  List := TStringList.Create;
  try
    GetStrings(List);
    List.SaveToStream(Stream);
  finally
    FreeAndNil(List);
  end;
end;

function FloatToStrInvariant(Value: Extended): string;
begin
  Result := FloatToStr(Value, invariantFormat);
end;

function Parse_File_Version(const VersionStr: string): ARFileVersion;
var
  s: string;
  FUNCTION NextWord(VAR s: STRING): integer;
  VAR
    delimPos                  : integer;
  BEGIN
    delimPos := Pos('.', s);
    IF delimPos > 0 THEN BEGIN
      Result := StrToIntDef(Copy(s, 1, delimPos - 1), -1);
      Delete(s, 1, delimPos);
    END
    ELSE BEGIN
      Result := 0;
    END;
  END;
begin
  s := Copy(VersionStr, 1, MaxInt);
  Result[0] := NextWord(s);
  Result[1] := NextWord(s);
  Result[2] := NextWord(s);
  Result[3] := NextWord(s);
end;


procedure ShowExpectedException(const Header: string);
var
  msg: string;
begin
  msg := '';
  with NewException(etNormal) do begin
//    SuspendThreads := true;
//    ShowCpuRegisters := false;
//    ShowStackDump := false;
//    CreateScreenShot := false;
//    ShowSetting := ssDetailBox;
//    SendBtnVisible := false;
//    CloseBtnVisible := false;
//    FocusedButton := bContinueApplication;

    if Header <> '' then
      msg := 'Error while ' + Header + ':'#10#13#10#13;

    ShowMessage(msg + '(' + ExceptClass + ') ' + ExceptMessage);
  end;
end;

function iniReadRect(const ini: TCustomIniFile; const section, name: string; const default: TRect): TRect;
begin
  Result.Left := ini.ReadInteger(section, name + '_Left', default.Left);
  Result.Top := ini.ReadInteger(section, name + '_Top', default.Top);
  Result.Right := Result.Left + ini.ReadInteger(section, name + '_Width', default.Right - default.Left);
  Result.Bottom := Result.Top + ini.ReadInteger(section, name + '_Height', default.Bottom - default.Top);
end;

procedure iniWriteRect(const ini: TCustomIniFile; const section, name: string; const value: TRect);
begin
  ini.WriteInteger(section, name + '_Left', value.Left);
  ini.WriteInteger(section, name + '_Top', value.Top);
  ini.WriteInteger(section, name + '_Width', value.Right - value.Left);
  ini.WriteInteger(section, name + '_Height', value.Bottom - value.Top);
end;


function FilterInfoToString(const filterInfo: TFilCatNode): string;
begin
  Result := filterInfo.FriendlyName + '  (' + GUIDToString(filterInfo.CLSID) + ')';
end;

function StringToFilterGUID(const s: string): TGUID;
var
  idx, len: integer;
begin
  idx := LastDelimiter('(', s) + 1;
  len := LastDelimiter(')', s);
  if idx < 0 then Result := GUID_NULL
  else
  begin
    if len <= idx then len := MaxInt;
    Result := StringToGUID(Copy(s, idx, len - idx))
  end;
end;

procedure WriteCutAppSettings(
  const ini: TCustomIniFile;
  const section: string;
  var CutAppSettings: RCutAppSettings);
begin
  ini.WriteString(section, 'AppName', CutAppSettings.CutAppName);
  ini.WriteString(section, 'PreferredSourceFilter', GUIDToString(CutAppSettings.PreferredSourceFilter));
  ini.WriteString(section, 'CodecName', CutAppSettings.CodecName);
  ini.WriteInteger(section, 'CodecFourCC', CutAppSettings.CodecFourCC);
  ini.WriteInteger(section, 'CodecVersion', CutAppSettings.CodecVersion);
  ini.WriteInteger(section, 'CodecSettingsSize', CutAppSettings.CodecSettingsSize);
  ini.WriteString(section, 'CodecSettings', CutAppSettings.CodecSettings);
end;

procedure ReadCutAppSettings(
  const ini: TCustomIniFile;
  const section: string;
  var CutAppSettings: RCutAppSettings);
var
  StrValue: string;
  BufferSize: integer;
begin
  if not Assigned(ini) then exit;

  CutAppSettings.CutAppName := ini.ReadString(section, 'AppName', '');
  StrValue := ini.ReadString(section, 'PreferredSourceFilter', GUIDToString(GUID_NULL));
  try
    CutAppSettings.PreferredSourceFilter := StringToGUID(StrValue);
  except
    on EConvertError do
      CutAppSettings.PreferredSourceFilter := GUID_NULL;
  end;
  CutAppSettings.CodecName := ini.ReadString(section, 'CodecName', '');
  CutAppSettings.CodecFourCC := ini.ReadInteger(section, 'CodecFourCC', 0);
  CutAppSettings.CodecVersion := ini.ReadInteger(section, 'CodecVersion', 0);
  CutAppSettings.CodecSettingsSize := ini.ReadInteger(section, 'CodecSettingsSize', 0);
  BufferSize := CutAppSettings.CodecSettingsSize div 3;
  if (CutAppSettings.CodecSettingsSize mod 3) > 0 then
    Inc(BufferSize);
  BufferSize := BufferSize * 4 + 1;        //+1 for terminating #0
  CutAppSettings.CodecSettings := iniReadLargeString(ini, BufferSize, section, 'CodecSettings', '');
  if Length(CutAppSettings.CodecSettings) <> BufferSize - 1 then
  begin
     CutAppSettings.CodecSettings := '';
     CutAppSettings.CodecSettingsSize := 0;
  end;
end;

//ini.ReadString does work only up to 2047 characters due to restrictions in iniFiles.pas
function iniReadLargeString(
    const ini: TCustomIniFile;
    const BufferSize: integer;
    const section, name, default: string): string;
var
  SizeRead: Integer;
  Buffer: PChar;
begin
  GetMem(Buffer, BufferSize * SizeOf(Char));
  try
    SizeRead := GetPrivateProfileString(PChar(Section), PChar(name), PChar(default), Buffer, BufferSize , PChar(ini.FileName));
    if (SizeRead >= 0) and (SizeRead <= BufferSize-1) then
      SetString(Result, Buffer, SizeRead)
    else Result := default;
  finally
    freemem(Buffer, BufferSize * SizeOf(Char));
  end;
end;

procedure ScaleForm(const F: TForm); overload;
begin
  ScaleForm(F, ScreenWidthDev, ScreenHeightDev);
end;

procedure AdjustFormConstraints (form : TForm);
{IFNDEF RTL180_UP}
var
  FormDPI, ScreenDPI: integer;
{IFEND}
begin
  if not Assigned(form) then
    exit;
{IFNDEF RTL180_UP}
  if not form.Scaled then
    exit;
  FormDPI := form.PixelsPerInch;
  ScreenDPI := Screen.PixelsPerInch;
  if FormDPI <> ScreenDPI then
    with form.Constraints do
    begin
      MinHeight := (MinHeight * ScreenDPI) div FormDPI;
      MinWidth  := (MinWidth  * ScreenDPI) div FormDPI;
      MaxHeight := (MinHeight * ScreenDPI) div FormDPI;
      MaxWidth  := (MinWidth  * ScreenDPI) div FormDPI;
    end;
{IFEND}
end;

procedure ScaleForm(const F: TForm; const ScreenWidthDev, ScreenHeightDev: Integer);
var
  x,y: Integer;
begin
  if not Assigned(F) then
    exit;
  F.Scaled := true;
  x := Screen.Width;
  y := Screen.Height;
  if (x<>ScreenWidthDev) or (y<>ScreenHeightDev) then begin
    F.Height := (F.ClientHeight*y div ScreenHeightDev) + F.Height - F.ClientHeight;
    F.Width :=  (F.ClientWidth*y div ScreenWidthDev)   + F.Width  - F.ClientWidth;
    F.ScaleBy(x, ScreenWidthDev);
  end;
end;

constructor THttpRequest.Create(const Url: string; const handleRedirects: boolean; const Error_message: string);
begin
  self.FUrl := Url;
  self.FHandleRedirects := handleRedirects;
  self.FErrorMessage := Error_message;
  self.FPostData := PostData;
  self.FResponse := '';
  self.IsPostRequest := false;
end;

destructor THttpRequest.Destroy;
begin
  IsPostRequest := false;
end;

procedure THttpRequest.SetIsPost(const value: boolean);
begin
  self.FIsPost := value;
  if not value and Assigned(FPostData) then
    FreeAndNil(FPostData);
  if value and not Assigned(FPostData) then
    FPostData := TIdMultiPartFormDataStream.Create;
end;

function ValidRect(const ARect: TRect): boolean;
begin
  Result := (ARect.Left > -1)
        and (ARect.Right > -1) and (ARect.Right > ARect.Left)
        and (ARect.Top > -1)
        and (ARect.Bottom > -1) and (ARect.Bottom > ARect.Top);
end;

function CtrlDown : Boolean;
var
   State : TKeyboardState;
begin
   GetKeyboardState(State) ;
   Result := ((State[vk_Control] And 128) <> 0) ;
end;

function ShiftDown : Boolean;
var
   State : TKeyboardState;
begin
   GetKeyboardState(State) ;
   Result := ((State[vk_Shift] and 128) <> 0) ;
end;

function AltDown : Boolean;
var
   State : TKeyboardState;
begin
   GetKeyboardState(State) ;
   Result := ((State[vk_Menu] and 128) <> 0) ;
end;

procedure PatchINT3;
  {http://www.delphipraxis.net/topic24054.html
  Es kann vorkommen, dass sich ein Programm einwandfrei kompillieren lässt,
  jedoch beim Start aus Delphi nach einiger Zeit das CPU-Fenster geöffnet wird.
  Dort steht dann häufig:

  ntdll.DbgBreakPoint

  Dies liegt daran, da Microsoft in manchen Dlls die Funktion ntdll.DbgBreakPoint
  vergessen hat. Microsoft hat ein paar Dlls versehentlich mit Debug-Informationen
  ausgeliefert, die noch Breakpoints enthalten, was der Debugger natürlich meldet.
  Man muss in so einem Falle zur Laufzeit den Code patchen.

  Aufruf in der initialization-section.
  }
var
  NOP : Byte;
  NTDLL: THandle; 
  BytesWritten: DWORD; 
  Address: Pointer; 
begin 
  if Win32Platform <> VER_PLATFORM_WIN32_NT then Exit; 
  NTDLL := GetModuleHandle('NTDLL.DLL'); 
  if NTDLL = 0 then Exit; 
  Address := GetProcAddress(NTDLL, 'DbgBreakPoint');
  if Address = nil then Exit; 
  try 
    if Char(Address^) <> #$CC then Exit; 

    NOP := $90; 
    if WriteProcessMemory(GetCurrentProcess, Address, @NOP, 1, BytesWritten) and 
      (BytesWritten = 1) then 
      FlushInstructionCache(GetCurrentProcess, Address, 1); 
  except
    //Do not panic if you see an EAccessViolation here, it is perfectly harmless!
    on EAccessViolation do ;
    else raise;
  end;
end;


function rand_string: string;
var
  i: integer;
begin
  result := '';
  for i := 0 to 19 do begin
    result := result + inttohex(round(random(16)),1);
  end;
end;

function Get_File_Version(const FileName: string): string;
var
 dwFileVersionMS, dwFileVersionLS: DWORD;
begin
{ If filename is not valid, return a string saying so and exit}
 if not fileExists(filename) then
 begin
   result := '[File not found]';
   exit;
 end;

 Result := '';
 if Get_File_Version(FileName, dwFileVersionMS, dwFileVersionLS) then begin
   Result := IntToStr(HiWord(dwFileVersionMS));
   Result := Result + '.' + IntToStr(LoWord(dwFileVersionMS));
   Result := Result + '.' + IntToStr(HiWord(dwFileVersionLS));
   Result := Result + '.' + IntToStr(LoWord(dwFileVersionLS));
 end else begin
   Result := '[Error]';
 end;
end;

function Get_File_Version(const FileName: string; var FileVersionMS, FileVersionLS: DWORD): boolean;
//True if successful
var
 VersionInfoSize, VersionInfoValueSize, Zero: DWord;
 VersionInfo, VersionInfoValue: Pointer;
begin
 result := false;
 if not fileExists(filename) then
 begin
   exit;
 end;
{otherwise, let's go!}
 { Obtain size of version info structure }
 VersionInfoSize := GetFileVersionInfoSize(PChar(FileName), Zero);
 if VersionInfoSize = 0 then exit;
  { Allocate memory for the version info structure }
  { This could raise an EOutOfMemory exception }
 GetMem(VersionInfo, VersionInfoSize);
 try
   if GetFileVersionInfo(PChar(FileName), 0, VersionInfoSize, VersionInfo) and VerQueryValue(VersionInfo, '\' { root block }, VersionInfoValue,
     VersionInfoValueSize) and (0 <> LongInt(VersionInfoValueSize)) then
   begin
     FileVersionMS := TVSFixedFileInfo(VersionInfoValue^).dwFileVersionMS;
     FileVersionLS := TVSFixedFileInfo(VersionInfoValue^).dwFileVersionLS;
     result := true;
   end; { then }
 finally
   FreeMem(VersionInfo);
 end; { try }
end;

function Application_version: string;
begin
  Result := Get_File_Version(Application.ExeName);
end;

function Application_Dir: string;
begin
  result := includeTrailingPathDelimiter(extractFileDir(Application.ExeName));
end;

function Application_Friendly_Name: string;
begin
  result := 'Cut Assistant V.' + Application_version;
end;

function UploadData_Path(useCSV: boolean): string;
begin
  result := Application_Dir + 'Upload' + IfThen(useCSV, '.CSV', '.XML');
end;

function cleanURL(aURL: String): String;
var
  iChar: Integer;
  aChar: Char;
begin
  result := '';
  for iChar := 1 to length(aURL) do begin
    aChar := aURL[iChar];
    case aChar of
      '0'..'9', 'A'..'Z', 'a'..'z', '$', '-', '+', '.':  result := result + aChar;
    else
      result := result + '%' + inttohex(ord(aChar), 2);
    end;
  end;
end;

function cleanFileName(const filename: string): string;
Const
  InvalidChars = '\/:*?<>|';
var
  i: integer;
  f, ch: string;
begin
  f := filename;
  for i := 1 to length(InvalidChars) do begin
    ch := midstr(InvalidChars, i, 1);
    f := AnsiReplaceText(f, ch, '_');
  end;
  result := f;
end;

function IsPathRooted(const Path: string): boolean;
begin
  if ExtractFileDrive(Path) <> '' then
    Result := true
  else
    Result := IsPathDelimiter(Path, 1);
end;


procedure ListBoxToClipboard(ListBox: TListBox;
  BufferSizePerLine: Integer;
  CopyAll: Boolean);
var
  Buffer: PChar;
  BufferSize: Integer;
  Ptr: PChar;
  I: Integer;
  Line: string[255];
  Count: Integer;
begin
  if not Assigned(ListBox) then
    Exit;
  BufferSize := BufferSizePerLine * ListBox.Items.Count;
  GetMem(Buffer, BufferSize);
  Ptr   := Buffer;
  Count := 0;
  for I := 0 to ListBox.Items.Count - 1 do
  begin
    Line := ListBox.Items.strings[I];
    if not CopyAll and ListBox.MultiSelect and (not ListBox.Selected[I]) then
      Continue;
    { Check buffer overflow }
    Count := Count + Length(Line) + 3;
    if Count >= BufferSize then
      Break;
    { Append to buffer }
    Move(Line[1], Ptr^, Length(Line));
    Ptr    := Ptr + Length(Line);
    Ptr[0] := #13;
    Ptr[1] := #10;
    Ptr    := Ptr + 2;
  end;
  Ptr[0] := #0;
  ClipBoard.SetTextBuf(Buffer);
  FreeMem(Buffer, BufferSize);
end;

////////////////////////////////////////////////////////////////
// AppName:  name (including path) of the application
// AppArgs:  command line arguments
// Wait:     0 = don't wait on application
//           >0 = wait until application has finished (maximum in milliseconds)
//           <0 = wait until application has started (maximum in milliseconds)
// Hide:     True = application runs invisible in the background
// ExitCode: exitcode of the application (only avaiable if Wait <> 0)
//
function STO_ShellExecute(const AppName, AppArgs: String; const Wait: Cardinal;
  const Hide: Boolean; var ExitCode: DWORD): Boolean;
begin
  result := STO_ShellExecute_Capture(AppName, AppArgs, Wait, Hide, ExitCode, nil)
end;

function STO_ShellExecute_Capture(const AppName, AppArgs: String; const Wait: Cardinal;
  const Hide: Boolean; var ExitCode: DWORD; AMemo: TMemo): Boolean;
const
  ReadBuffer = 2400;
var
  myStartupInfo: TStartupInfo;
  myProcessInfo: TProcessInformation;
  sAppName, sCommandline: String;
  iWaitRes: Integer;

  Security : TSecurityAttributes;
  ReadPipe,WritePipe : THandle;
  Buffer : Pchar;
  BytesRead : DWord;
begin
  result := false;
  Buffer := nil;
  if Assigned(AMemo) then begin
    With Security do begin
      nlength := SizeOf(TSecurityAttributes) ;
      binherithandle := true;
      lpsecuritydescriptor := nil;
    end;
    if not Createpipe (ReadPipe, WritePipe, @Security, 0) then exit;
    Buffer := AllocMem(ReadBuffer + 1) ;
  end;
  try
    // initialize the startupinfo
    FillChar(myStartupInfo, SizeOf(TStartupInfo), 0);
    myStartupInfo.cb := Sizeof(TStartupInfo);
    myStartupInfo.dwFlags := STARTF_USESTDHANDLES + STARTF_USESHOWWINDOW;
    if Hide then // hide application
      myStartupInfo.wShowWindow := SW_HIDE
    else // show application
      myStartupInfo.wShowWindow := SW_SHOWNORMAL;

    // prepare applicationname
    sAppName := AppName;
    if (Length(sAppName) > 0) and (sAppName[1] <> '"') then
      sAppName := '"' + sAppName + '"';

    // start process
    ExitCode := 0;
    sCommandline := sAppName + ' ' + AppArgs;

    Result := CreateProcess(nil, PAnsiChar(sCommandline), nil, nil, False,
                  CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, nil,
                  myStartupInfo, myProcessInfo);

    // could process be started ?
    if Result then begin
      // wait on process ?
      if (Wait <> 0) then
      begin
        if (Wait > 0) then // wait until process terminates
          iWaitRes := WaitForSingleObject(myProcessInfo.hProcess, Wait)
        else // wait until process has been started
          iWaitRes := WaitForInputIdle(myProcessInfo.hProcess, Abs(Wait));
        // timeout reached ?
        if iWaitRes = WAIT_TIMEOUT then
        begin
          Result := False;
          TerminateProcess(myProcessInfo.hProcess, 1);
        end;
        // getexitcode
        GetExitCodeProcess(myProcessInfo.hProcess, ExitCode);
      end;
      if Assigned(AMemo) then begin
        Repeat
          BytesRead := 0;
          ReadFile(ReadPipe,Buffer[0], ReadBuffer,BytesRead,nil) ;
          Buffer[BytesRead]:= #0;
          OemToAnsi(Buffer,Buffer) ;
          AMemo.Text := AMemo.text + String(Buffer) ;
        until (BytesRead < ReadBuffer) ;
        CloseHandle(ReadPipe) ;
        CloseHandle(WritePipe) ;
      end;
      CloseHandle(myProcessInfo.hProcess);
    end else begin
      RaiseLastOSError;
    end;
  finally
    if Assigned(AMemo) then FreeMem(Buffer) ;
  end;
end;

function CallApplication(AppPath, Command: string; var ErrorString: String): boolean;
var
  return_value: cardinal;
  m: string;
begin
  return_value := shellexecute(Application.MainForm.Handle, 'open', pointer(AppPath), pointer(command), '', sw_shownormal);

  if return_value <= 32 then begin
    result := false;
    case return_value of
      0: m := 'The operating system is out of memory or resources.';
      //ERROR_FILE_NOT_FOUND: m := 'The specified file was not found.';    //not necessary, is the same as SE_ERR_FNF
      //ERROR_PATH_NOT_FOUND: m := 'The specified path was not found.';
      ERROR_BAD_FORMAT: m := 'The .EXE file is invalid (non-Win32 .EXE or error in .EXE image).';
      SE_ERR_ACCESSDENIED: m := 'The operating system denied access to the specified file.';
      SE_ERR_ASSOCINCOMPLETE: m := 'The filename association is incomplete or invalid.';
      SE_ERR_DDEBUSY: m := 'The DDE transaction could not be completed because other DDE transactions were being processed.';
      SE_ERR_DDEFAIL: m := 'The DDE transaction failed.';
      SE_ERR_DDETIMEOUT: m := 'The DDE transaction could not be completed because the request timed out.';
      SE_ERR_DLLNOTFOUND: m := 'The specified dynamic-link library was not found.';
      SE_ERR_FNF: m := 'The specified file was not found.';
      SE_ERR_NOASSOC: m := 'There is no application associated with the given filename extension.';
      SE_ERR_OOM: m := 'There was not enough memory to complete the operation.';
      SE_ERR_PNF: m := 'The specified path was not found.';
      SE_ERR_SHARE: m := 'A sharing violation occurred.';
      else m:= 'Unknown Error.';
    end;
    ErrorString := m;
  end else begin
    ErrorString := '';
    result := true;
  end;
end;

function secondsToTimeString(t: double): string;
var
  h, m, s, ms: integer;
  sh, sm, ss, sms: string;
begin
  ms := round(1000*frac(t));
  s := trunc(t);
  m := trunc(s/60);
  s := s mod 60;
  h := trunc(m/60);
  m := m mod 60;

  sh := inttostr(h);
  sm := inttostr(m);
  ss := inttostr(s);
  sms := inttostr(ms);

  if m<10 then sm := '0' + sm;
  if s<10 then ss := '0' + ss;
  if ms<10 then
    sms := '00' + sms
  else
    if ms<100 then sms := '0' + sms;

  result := sh + ':' + sm + ':' + ss + '.' + sms;
end;

Function fcc2String(fcc: DWord): String;
Var
  Buffer: Array[0..3] Of Char;
Begin
  Move(fcc, Buffer, SizeOf(Buffer));
  Result := Buffer;
End;

Function MakeFourCC(const a,b,c,d: char): DWord;
Begin
  Result := Cardinal(a)
         or (Cardinal(b) shl 8)
         or (Cardinal(c) shl 16)
         or (Cardinal(d) shl 24);
End;

function SaveBitmapAsJPEG(ABitmap: TBitmap; FileName: string): boolean;
var
  tempJPEG: TJPEGImage;
begin
  TempJPEG := TJPEGImage.Create;
  try
    TempJPEG.Assign(ABitmap);
    TempJPEG.SaveToFile(FileName);
    Result := true;
  finally
    FreeAndNIL(TempJPEG);
  end;
end;

{ TGUIDList }

function TGUIDList.Add(aGUID: TGUID): Integer;
begin
  inc(FCount);
  setlength(FGUIDList, FCount);
  FGUIDList[FCount-1] := aGUID;
  result := FCount-1;
end;

function TGUIDList.AddFromString(aGUIDString: string): Integer;
begin
  result := Add(StringToGUID(aGUIDString));
end;

procedure TGUIDList.Clear;
begin
  FCount := 0;
  setlength(FGUIDList, FCount);
end;

constructor TGUIDList.Create;
begin
  inherited;
  Clear;
end;

procedure TGUIDList.Delete(Item: TGUID);
var
  idx: integer;
begin
  idx := IndexOf(Item);
  if idx > -1 then
    Delete(idx);
end;

procedure TGUIDList.Delete(Index: Integer);
var
  i: Integer;
begin
  for i := Index to FCount-2 do begin
    FGUIDList[i] := FGUIDList[i+1];
  end;
  dec(FCount);
  setlength(FGUIDList, FCount);
end;

destructor TGUIDList.Destroy;
begin
  Clear;
  inherited;
end;

function TGUIDList.GetItem(Index: Integer): TGUID;
begin
  result := FGUIDList[Index];
end;

function TGUIDList.GetItemString(Index: Integer): string;
begin
  result := GUIDToString(FGuidList[Index]);
end;

function TGUIDList.IndexOf(aGUID: TGUID): Integer;
var
  i: integer;
begin
  result := -1;
  for i := 0 to FCount-1 do begin
    if IsEqualGUID(aGUID, FGUIDList[i]) then begin
      result := i;
      break;
    end;
  end;
end;

function TGUIDList.IndexOf(aGUIDString: string): Integer;
begin
  result := IndexOf(StringToGUID(aGUIDString));
end;

function TGUIDList.IsInList(aGUID: TGUID): boolean;
begin
  result := IndexOf(aGUID) >= 0;
end;

function TGUIDList.IsInList(aGUIDString: string): boolean;
begin
  result := IsInList(StringToGUID(aGUIDString));
end;

procedure TGUIDList.SetItem(Index: Integer; const Value: TGUID);
begin
  FGUIDList[Index] := Value;
end;

procedure TGUIDList.SetItemString(Index: Integer; const Value: string);
begin
  FGUIDList[Index] := StringToGUID(Value);
end;

initialization
  GetLocaleFormatSettings($007F, invariantFormat);

// nur wenn ein Debugger vorhanden, den Patch ausführen
//if DebugHook<>0 then PatchINT3;

end.


