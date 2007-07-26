unit UCutApplicationVirtualDub;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UCutApplicationBase, CodecSettings, StdCtrls, IniFiles, Contnrs, MMSystem,
  ExtCtrls;

const
  VIRTUALDUB_DEFAULT_EXENAME_1 = 'virtualdub.exe';
  //VIRTUALDUB_DEFAULT_EXENAME_2 = 'vdub.exe';

type
  TCutApplicationVirtualDub = class;

  TfrmCutApplicationVirtualDub = class(TfrmCutApplicationBase)
    cbNotClose: TCheckBox;
    cbUseSmartRendering: TCheckBox;
    cbShowProgressWindow: TCheckBox;
  private
    { Private declarations }
    procedure SetCutApplication(const Value: TCutApplicationVirtualDub);
    function GetCutApplication: TCutApplicationVirtualDub;
  public
    { Public declarations }
    property CutApplication: TCutApplicationVirtualDub read GetCutApplication write SetCutApplication;
    procedure Init; override;
    procedure Apply; override;
  end;

  TCutApplicationVirtualDub = class(TCutApplicationBase)
  private
    FFindProgressWindowTimer: TTimer;
    procedure SetShowProgressWindow(const Value: boolean);
    procedure FindProgressWindow(Sender: TObject);
  protected
    FCodecList: TCodecList;
    FNotClose: boolean;
    FUseSmartRendering: boolean;
    FScriptFileName: string;
    FShowProgressWindow: boolean;

    function CreateScript(aCutlist: TObjectList; Inputfile, Outputfile: String; var scriptfile: string): boolean;
  public
    //CommandLineOptions: string;

    constructor Create; override;
    destructor Destroy; override;
    property ShowProgressWindow: boolean read FShowProgressWindow write SetShowProgressWindow;
    //property UseCodec: FOURCC read FUseCodec;
    //function UseCodecString: string;
    //property UseCodecVersion: DWord read FCodecVersion;
    //function UseCodecVersionString: string;
    function CanDoSmartRendering: boolean;
    function UseSmartRendering: boolean;

    function LoadSettings(IniFile: TIniFile): boolean; override;
    function SaveSettings(IniFile: TIniFile): boolean; override;
    function InfoString: string; override;
    function WriteCutlistInfo(CutlistFile: TIniFile; section: string): boolean; override;
    function PrepareCutting(SourceFileName: string; var DestFileName: string; Cutlist: TObjectList): boolean; override;
    function StartCutting: boolean; override;
    function CleanUpAfterCutting: boolean; override;
  end;

var
  frmCutApplicationVirtualDub: TfrmCutApplicationVirtualDub;

implementation

{$R *.dfm}

{$WARN UNIT_PLATFORM OFF}

uses
  FileCtrl, StrUtils, JvCreateProcess,
  DirectShow9, 
  Utils, UCutlist, UfrmCutting, Main;

type
  PFindWindowStruct = ^TFindWindowStruct;
  TFindWindowStruct = record
    Caption: string;
    ClassName: String;
    ProcessID: Cardinal;
    WindowHandle: THandle;
end;

{ TCutApplicationVirtualDub }

constructor TCutApplicationVirtualDub.create;
begin
  inherited;
  FCodecList := TCodecList.Create;
  FCodecList.Fill;
  FrameClass := TfrmCutApplicationVirtualDub;
  Name := 'VirtualDub';
  DefaultExeNames.Add(VIRTUALDUB_DEFAULT_EXENAME_1);
  //DefaultExeNames.Add(VIRTUALDUB_DEFAULT_EXENAME_2);
  RedirectOutput := true;
  ShowAppWindow := true;
  FNotClose := false;
  FUseSmartRendering := true;
  FShowProgressWindow := true;
  FFindProgressWindowTimer := TTimer.Create(Application);
  FFindProgressWindowTimer.OnTimer := FindProgressWindow;
  FFindProgressWindowTimer.Enabled := false;
  FFindProgressWindowTimer.Interval := 1000;
  FHasSmartRendering := true;
end;

destructor TCutApplicationVirtualDub.Destroy;
begin
  //FreeAndNIL(FFindProgressWindowTimer);
  inherited;
end;

procedure TCutApplicationVirtualDub.SetShowProgressWindow(const Value: boolean);
begin
  FShowProgressWindow := Value;
end;


function TCutApplicationVirtualDub.LoadSettings(IniFile: TIniFile): boolean;
  procedure SetCodecSettings(var s1, s2: RCutAppSettings);
  begin
    if s1.CutAppName <> s2.CutAppName then
      Exit;
    // do not overwrite existing settings ...
    if s1.CodecFourCC <> 0 then
      Exit;
    s1.CodecName := s2.CodecName;
    s1.CodecFourCC := s2.CodecFourCC;
    s1.CodecVersion := s2.CodecVersion;
    s1.CodecSettingsSize := s2.CodecSettingsSize;
    s1.CodecSettings := s2.CodecSettings;
  end;
var
  section: string;
  success: boolean;
  StrValue: string;
  BufferSize: Integer;
  cas: RCutAppSettings;
begin
  cas.PreferredSourceFilter := GUID_NULL;
  
  //This part only for compatibility issues for versions below 0.9.9
  //This Setting may be overwritten below
  section := 'External Cut Application';
  TempDir := IniFile.ReadString(section, 'VirtualDubScriptsPath', '');
  Path := IniFile.ReadString(section, 'VirtualDubPath', '');
  self.FNotClose := IniFile.ReadBool(section, 'VirtualDubNotClose', FNotClose);
  self.FUseSmartRendering := IniFile.ReadBool(section, 'VirtualDubUseSmartRendering', FUseSmartRendering);

  success := inherited LoadSettings(IniFile);
  section := GetIniSectionName;
  //CommandLineOptions := IniFile.ReadString(section, 'CommandLineOptions', CommandLineOptions);
  self.FNotClose := IniFile.ReadBool(section, 'NotClose', FNotClose);
  self.FUseSmartRendering := IniFile.ReadBool(section, 'UseSmartRendering', FUseSmartRendering);
  self.FShowProgressWindow := IniFile.ReadBool(section, 'ShowProgressWindow', FShowProgressWindow);

  //
  // Read old settings ...
  //
  StrValue := IniFile.ReadString(section, 'CodecFourCC', '0x0');
  cas.CodecFourCC := StrToInt64Def(StrValue, $00000000);
  StrValue := IniFile.ReadString(section, 'CodecVersion', '0x0');
  cas.CodecVersion := StrToInt64Def(StrValue, $00000000);
  cas.CodecSettingsSize := IniFile.ReadInteger(section, 'CodecSettingsSize', 0);

  //ini.ReadString does work only up to 2047 characters due to restrictions in iniFiles.pas
  //CodecSettings := ini.ReadString(section, 'CodecSettings', '');
  BufferSize := cas.CodecSettingsSize div 3;
  if (cas.CodecSettingsSize mod 3) > 0 then inc(BufferSize);
  BufferSize := BufferSize * 4 + 1;        //+1 for terminating #0
  cas.CodecSettings := iniReadLargeString(IniFile, BufferSize, section, 'CodecSettings', '');
  if Length(cas.CodecSettings) <> BufferSize - 1 then
  begin
     cas.CodecSettings := '';
     cas.CodecSettingsSize := 0;
  end;

  // Convert old settings if necessary ...
  if (cas.CodecFourCC <> 0) then
  begin
    cas.CutAppName := self.Name;
    cas.CodecName := Settings.GetCodecNameByFourCC(cas.CodecFourCC);
    SetCodecSettings(Settings.CutAppSettingsWmv, cas);
    SetCodecSettings(Settings.CutAppSettingsAvi, cas);
    SetCodecSettings(Settings.CutAppSettingsHQAVI, cas);
    SetCodecSettings(Settings.CutAppSettingsMP4, cas);
    SetCodecSettings(Settings.CutAppSettingsOther, cas);
  end;

  result := success;
end;

function TCutApplicationVirtualDub.SaveSettings(IniFile: TIniFile): boolean;
var
  section: string;
  success: boolean;
begin
  success := inherited SaveSettings(IniFile);

  section := GetIniSectionName;
  //IniFile.WriteString(section, 'CommandLineOptions', CommandLineOptions);
  IniFile.WriteBool(section, 'NotClose', self.FNotClose);
  IniFile.WriteBool(section, 'UseSmartRendering', self.FUseSmartRendering);
  IniFile.WriteBool(section, 'ShowProgressWindow', self.FShowProgressWindow);
  //IniFile.WriteString(section, 'CodecFourCC', '0x' + IntToHex(self.FUseCodec, 8));
  //IniFile.WriteString(section, 'CodecVersion', '0x' + IntToHex(self.FCodecVersion, 8));
  //IniFile.WriteString(section, 'CodecSettings', FCodecSettings);
  //IniFile.WriteInteger(section, 'CodecSettingsSize', self.FCodecSettingsSize);
  // Remove old settings ...
  IniFile.DeleteKey(section, 'CodecFourCC');
  IniFile.DeleteKey(section, 'CodecVersion');
  IniFile.DeleteKey(section, 'CodecSettings');
  IniFile.DeleteKey(section, 'CodecSettingsSize');
  result := success;
end;


function FindWindowByWindowStructParam(wHandle: HWND; lParam: Cardinal): Bool; stdcall;
var
  Title, ClassName: array[0..255] of char;
  dwProcessId{, dwThreadId}: cardinal;
begin
  Result := True;
  if GetClassName(wHandle, ClassName, 255) <= 0 then
    exit;
  if Pos(PFindWindowStruct(lParam).ClassName, StrPas(ClassName)) = 0 then
    exit;
  if GetWindowText(wHandle, Title, 255) <= 0 then
    exit;
  if Pos(PFindWindowStruct(lParam).Caption, StrPas(Title)) = 0 then
    exit;
  {dwThreadId := }GetWindowThreadProcessId(wHandle, dwProcessId);
  if dwProcessId <> PFindWindowStruct(lParam).ProcessId then
    exit;

  PFindWindowStruct(lParam).WindowHandle := wHandle;
  Result := False;
end;

procedure TCutApplicationVirtualDub.FindProgressWindow(Sender: TObject);
const
  ID_OPTIONS_SHOWSTATUSWINDOW = 40034;
var
  WindowInfo: TFindWindowStruct;
begin
  if CutApplicationProcess.State = psReady then // CutApp not running ...
  begin
    FFindProgressWindowTimer.Enabled := false;
    Exit;
  end;

  with WindowInfo do begin
    Caption := 'VirtualDub Status';
    ClassName := '#32770';
    ProcessID := CutApplicationProcess.ProcessInfo.dwProcessId;
    WindowHandle := 0;
    EnumWindows(@FindWindowByWindowStructParam, LongInt(@WindowInfo));
    if WindowHandle <> 0 then
    begin
      //if not IsWindowVisible(vDubWindow) then
      ShowWindow(WindowHandle, SW_SHOW);
      // Activate progress window
      // WM_COMMAND, lParam=0, wParam=ID_OPTIONS_SHOWSTATUSWINDOW (40034)
      //SendMessage(wnd, WM_COMMAND, ID_OPTIONS_SHOWSTATUSWINDOW, 0);
      FFindProgressWindowTimer.Enabled := false;
    end;
  end;
end;

function TCutApplicationVirtualDub.StartCutting: boolean;
begin
  result := inherited StartCutting;
  if result then
  begin
    WaitForInputIdle(CutApplicationProcess.ProcessInfo.hProcess, 1000);
    if FShowProgressWindow then
      FFindProgressWindowTimer.Enabled := true;
  end;
end;

function TCutApplicationVirtualDub.PrepareCutting(SourceFileName: string;
  var DestFileName: string; Cutlist: TObjectList): boolean;
var
  TempCutlist: TCutlist;
  MustFreeTempCutlist: boolean;
  myFormatSettings: TFormatSettings;
  CommandLine, ExeName, message_string: string;
  success: boolean;
begin
  result := false;
  if not fileexists(self.Path) then begin
    ExeName := ExtractFileName(Path);
    if ExeName ='' then ExeName := DefaultExeNames[0];
    if ExeName ='' then ExeName := 'Application';
    showmessage(ExeName + ' not found. Please check settings.');
    exit;
  end;

  MustFreeTempCutlist := false;
  TempCutlist := (Cutlist as TCutlist);
  self.FCommandLines.Clear;

  if TempCutlist.Mode <> clmCrop then begin
    TempCutlist := TempCutlist.convert;
    MustFreeTempCutlist := True;
  end;

  try
    FScriptFileName := '';
    if self.TempDir <>'' then begin
      if (not DirectoryExists(TempDir)) then begin
        message_string := 'Directory does not exist:' + #13#10 + #13#10 + TempDir + #13#10 +  #13#10 + 'Create?' ;
        if application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONWARNING) = IDYES then begin
          success := forceDirectories(TempDir);
          if success then FScriptFileName := IncludeTrailingPathDelimiter(TempDir) + extractFileName(SourceFileName) + '.syl';
        end;
      end else begin
        FScriptFileName := IncludeTrailingPathDelimiter(TempDir) + extractFileName(SourceFileName) + '.syl';
      end;
    end;

    CreateScript(TempCutlist, SourceFileName, DestFileName, FScriptFileName);

    CommandLine :=  '/s"' + FScriptFileName + '"';
    if self.RedirectOutput then
      CommandLine := '/console ' + CommandLine;
    if not self.FNotClose then
      CommandLine := CommandLine + ' /x';

//    CommandLine := CommandLine +  ' ' + self.CommandLineOptions;

    self.FCommandLines.Add(CommandLine);
    result := true;
  finally
    if MustFreeTempCutlist then FreeAndNIL(TempCutlist);
  end;
end;


function TCutApplicationVirtualDub.InfoString: string;
begin
  result := inherited InfoString
         // + 'Options: ' + self.CommandLineOptions + #13#10
          + 'Smart Rendering: ' + booltostr(UseSmartRendering, true) + #13#10
          + 'Codec for Smart Rendering: ' + CutAppSettings.CodecName + #13#10
          + 'Codec Version: '
          + inttostr(HiWord(CutAppSettings.CodecVersion)) +'.' + inttostr(LoWord(CutAppSettings.CodecVersion)) + #13#10;
end;

function TCutApplicationVirtualDub.WriteCutlistInfo(CutlistFile: TIniFile;
  section: string): boolean;
begin
  result := inherited WriteCutlistInfo(CutlistFile, section);
  if result then begin
    //cutlistfile.WriteString(section, 'IntendedCutApplicationOptions', self.CommandLineOptions);
    cutlistfile.WriteBool(section, 'VDUseSmartRendering', self.UseSmartRendering);
    if UseSmartRendering then begin
      cutlistfile.WriteString(section, 'VDSmartRenderingCodecFourCC', '0x' + IntToHex(CutAppSettings.CodecFourCC, 8));
      cutlistfile.WriteString(section, 'VDSmartRenderingCodecVersion', '0x' + IntToHex(CutAppSettings.CodecVersion, 8));
    end;
    result := true;
  end;
end;

function TCutApplicationVirtualDub.CleanUpAfterCutting: boolean;
var
  success: boolean;
begin
  result := false;
  FFindProgressWindowTimer.Enabled := false;
  if self.CleanUp then begin
    result := inherited CleanUpAfterCutting;
    if FileExists(FScriptFileName) then begin
      success := DeleteFile(FScriptFileName);
      result := result and success;
    end;
  end;
end;

{ TfrmCutApplicationVirtualDub }

procedure TfrmCutApplicationVirtualDub.Init;
begin
  inherited;
  //self.edtCommandLineOptions.Text := CutApplication.CommandLineOptions;
  cbNotClose.Checked := CutApplication.FNotClose;
  cbUseSmartRendering.Checked := CutApplication.FUseSmartRendering;
  cbShowProgressWindow.Checked := CutApplication.ShowProgressWindow;
end;

procedure TfrmCutApplicationVirtualDub.Apply;
begin
  inherited;
  //CutApplication.CommandLineOptions := edtCommandLineOptions.Text;
  CutApplication.FNotClose := cbNotClose.Checked;
  CutApplication.FUseSmartRendering := cbUseSmartRendering.Checked;
  CutApplication.ShowProgressWindow := self.cbShowProgressWindow.Checked;
end;

procedure TfrmCutApplicationVirtualDub.SetCutApplication(
  const Value: TCutApplicationVirtualDub);
begin
  FCutApplication := Value;
end;

function TfrmCutApplicationVirtualDub.GetCutApplication: TCutApplicationVirtualDub;
begin
  result := (self.FCutApplication as TCutApplicationVirtualDub);
end;

function TCutApplicationVirtualDub.CreateScript(aCutlist: TObjectList;
  Inputfile, Outputfile: String; var scriptfile: string): boolean;

  function EscapeString(s: string): string;
  begin
    result := AnsiReplaceStr(s, '\', '\\');
    result := AnsiReplaceStr(Result, '''', '\''');
  end;

var
  f: Textfile;
  i: integer;
  vdubStart, vdubLength: string;
  cutlist: TCutlist;
begin
  result := false;
  if not (aCutlist is TCutlist) then exit;
  cutlist := (aCutlist as TCutlist);
  if not (cutlist.Mode = clmCrop) then exit;

  if scriptfile = '' then scriptfile := Inputfile + '.syl';
  assignfile(f, scriptfile);
  rewrite(f);
  writeln(f, '// Virtual Dub Sylia Script');
  writeln(f, '// Generated by ' + Application_friendly_name);
  writeln(f, 'VirtualDub.Open("' + EscapeString(Inputfile) + '",0,0);');
  writeln(f, 'VirtualDub.audio.SetMode(0);');
  if self.UseSmartRendering then begin
    writeln(f, 'VirtualDub.video.SetMode(1);');      //fast Recompression
    writeln(f, 'VirtualDub.video.SetSmartRendering(1);');
    if CutAppSettings.CodecFourCC <> 0 then begin
      writeln(f, 'VirtualDub.video.SetCompression(0x' + IntToHex(CutAppSettings.CodecFourCC, 8) + ',0,10000,0);');
      if CutAppSettings.CodecSettings <> '' then begin
        writeln(f, 'VirtualDub.video.SetCompData(' + inttostr(CutAppSettings.CodecSettingsSize) + ',"' + CutAppSettings.CodecSettings + '");');
      end;
    end;
  end else begin
    writeln(f, 'VirtualDub.video.SetMode(0);');
  end;
  writeln(f, 'VirtualDub.subset.Clear();');

  cutlist.sort;
  for i := 0 to cutlist.Count -1 do begin
    if cutlist.FramesPresent and not cutlist.HasChanged then begin
      vdubstart := inttostr(cutlist.Cut[i].frame_from);
      vdubLength := inttostr(cutlist.Cut[i].DurationFrames);
    end else begin
      vdubstart := inttostr(round(cutlist.Cut[i].pos_from / MovieInfo.frame_duration));
      vdubLength := inttostr(round((cutlist.Cut[i].pos_to - cutlist.Cut[i].pos_from) / MovieInfo.frame_duration + 1));
    end;
    writeln(f, 'VirtualDub.subset.AddRange(' + vdubstart + ', ' + vdubLength + ');');
  end;

  writeln(f, 'VirtualDub.SaveAVI(U"'+OutputFile+'");');   //For OUTPUT use undecorated string!
  if not FNotClose then writeln(f, 'VirtualDub.Close();');

  closefile(f);
  result := true;
end;

function TCutApplicationVirtualDub.CanDoSmartRendering: boolean;
const
  //only VD 1.7.0 or later can do smart rendering
  MinVersion: DWORD = $00010007;
var
  VersionMS: DWORD;
begin
  result := false;
  VersionMS := MakeLong(self.VersionWords[1], self.VersionWords[0]);
  if VersionMS >= MinVersion then
      result := true;
end;

function TCutApplicationVirtualDub.UseSmartRendering: boolean;
begin
  result := (self.FUseSmartRendering and self.CanDoSmartRendering);
end;

end.
