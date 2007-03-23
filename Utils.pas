unit Utils;

interface

uses
  StdCtrls, Windows, Graphics;

const
  Application_name ='Cut_assistant.exe';   //for use in cutlist files etc.

type

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
    procedure Delete(Index: Integer);
    function IndexOf(aGUID: TGUID): Integer; overload;
    function IndexOf(aGUIDString: string): Integer; overload;
    function IsInList(aGUID: TGUID): boolean; overload;
    function IsInList(aGUIDString: string): boolean; overload;
    property Count: Integer read FCount;
  end;


  procedure PatchINT3;

  function rand_string: string;
  function Get_File_Version(const FileName: string): string; overload;
  function Get_File_Version(const FileName: string; var FileVersionMS, FileVersionLS: DWORD): boolean; overload;
  function Application_version: string;
  function Application_Dir: string;
  function Application_Friendly_Name: string;
  function UploadData_Path: string;
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


//global Vars
var
  batchmode: boolean;


implementation

uses
  Messages, SysUtils, ShellAPI, Variants, Classes, Forms, Clipbrd, StrUtils, jpeg;

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

function UploadData_Path: string;
begin
  result := Application_Dir + 'Upload.xml';
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

function SaveBitmapAsJPEG(ABitmap: TBitmap; FileName: string): boolean;
var
  tempJPEG: TJPEGImage;
begin
  result := false;
  TempJPEG := TJPEGImage.Create;
  try
    TempJPEG.Assign(ABitmap);
    TempJPEG.SaveToFile(FileName);
    result := true;
  finally
    TempJPEG.Free;
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

// nur wenn ein Debugger vorhanden, den Patch ausführen 
//if DebugHook<>0 then PatchINT3; 

end.


