unit UCutApplicationBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls,
  IniFiles, Contnrs,
  JvComponentBase, JvCreateProcess, Utils, JvExStdCtrls, JvCheckBox;

type
  TCutApplicationFrameClass = class of TfrmCutApplicationBase;

  TCutApplicationBase = class;

  TfrmCutApplicationBase = class(TFrame)
    edtPath: TEdit;
    lblAppPath: TLabel;
    btnBrowsePath: TButton;
    edtTempDir: TEdit;
    lblTempDir: TLabel;
    btnBrowseTempDir: TButton;
    selectFileDlg: TOpenDialog;
    cbRedirectOutput: TJvCheckBox;
    cbShowAppWindow: TJvCheckBox;
    cbCleanUp: TJvCheckBox;
    procedure btnBrowsePathClick(Sender: TObject);
    procedure btnBrowseTempDirClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetCutApplication(const Value: TCutApplicationBase);
  protected
    FCutApplication: TCutApplicationBase;
  public
    { Public declarations }
    property CutApplication: TCutApplicationBase read FCutApplication write SetCutApplication;
    procedure Init; virtual;
    procedure Apply; virtual;
  end;

  TCutApplicationCommandLineEvent = procedure(Sender: TObject; const CommandLineIndex: Integer; const CommandLine: string) of object;

  TCutApplicationBase = class(TObject)
  private
    FName: string;
    FPath: string;
    FVersion: string;
    FVersionWords: array [0..3] of word;
    FDefaultExeNames: TStringlist;
    FRedirectOutput: boolean;
    FShowAppWindow: boolean;
    FTempDir: string;

    FOutputMemo: TMemo;
    FCommandLineCounter: Integer;
    FjvcpAppProcess: TJvCreateProcess;
    FProcessAborted: boolean;
    FCleanUp: boolean;
    FRawRead: boolean;
    FOnCuttingTerminate: TJvCPSTerminateEvent;
    FOnCommandLineTerminate: TCutApplicationCommandLineEvent;

    procedure SetPath(const Value: string);
    procedure SetName(const Value: string);
    function GetVersionWords(Index: Integer): word;
    procedure SetRedirectOutput(const Value: boolean);
    procedure SetShowAppWindow(const Value: boolean);
    procedure SetTempDir(const Value: string);
    procedure SetOutputMemo(const Value: TMemo);
    procedure jvcpAppProcessRead(Sender: TObject; const S: string; const StartsOnNewLine: Boolean);
    procedure jvcpAppProcessRawRead(Sender: TObject; const S: String);
    procedure jvcpAppProcessTerminate(Sender: TObject; ExitCode: Cardinal);
    procedure SetCleanUp(const Value: boolean);
    procedure SetRawRead(const Value: boolean);
    procedure SetOnCommandLineTerminate(
      const Value: TCutApplicationCommandLineEvent);
  protected
    FHasSmartRendering: boolean;
    FCommandLines: TStringList;       //ONLY command line parameters WITHOUT path to exe file!!!
    property RawRead: boolean read FRawRead write SetRawRead;
    function ExecuteCutProcess: boolean;
    function GetIniSectionName: string; virtual;
    property CutApplicationProcess: TJvCreateProcess read FjvcpAppProcess;
  public
    CutAppSettings: RCutAppSettings;
    FrameClass: TCutApplicationFrameClass;
    property OutputMemo: TMemo read FOutputMemo write SetOutputMemo;
    property OnCommandLineTerminate: TCutApplicationCommandLineEvent read FOnCommandLineTerminate write SetOnCommandLineTerminate;
    property OnCuttingTerminate: TJvCPSTerminateEvent read FOnCuttingTerminate write FOnCuttingTerminate;
    procedure AbortCutProcess;
    procedure EmergencyTerminateProcess;

    property Name: string read FName write SetName;
    property DefaultExeNames: TStringlist read FDefaultExeNames write FDefaultExeNames;
    property Path: string read FPath write SetPath;
    property TempDir: string read FTempDir write SetTempDir;
    property RedirectOutput: boolean read FRedirectOutput write SetRedirectOutput;
    property ShowAppWindow: boolean read FShowAppWindow write SetShowAppWindow;
    property CleanUp: boolean read FCleanUp write SetCleanUp;
    property Version: string read FVersion;
    property VersionWords[Index: Integer]: word read GetVersionWords;
    property HasSmartRendering: boolean read FHasSmartRendering;

    constructor create; virtual;
    destructor Destroy; override;
    function LoadSettings(IniFile: TCustomIniFile): boolean; virtual;
    function SaveSettings(IniFile: TCustomIniFile): boolean; virtual;
    function InfoString: string; virtual;
    function WriteCutlistInfo(CutlistFile: TCustomIniFile; section: string): boolean; virtual;

    function PrepareCutting(SourceFileName: string; var DestFileName: string; Cutlist: TObjectList): boolean; virtual;
    property CommandLines: TStringList read FCommandLines;
    function StartCutting: boolean; virtual;
    function CleanUpAfterCutting: boolean; virtual;
  end;

implementation

{$WARN UNIT_PLATFORM OFF}

uses
  CAResources,
  FileCtrl;

{$R *.dfm}

{TfrmCutApplicationBase}

procedure TfrmCutApplicationBase.Apply;
begin
  if fileexists(edtPath.Text) then CutApplication.Path := edtPath.Text;
  CutApplication.TempDir := self.edtTempDir.Text;
  CutApplication.RedirectOutput := self.cbRedirectOutput.Checked;
  CutApplication.ShowAppWindow := self.cbShowAppWindow.Checked;
  CutApplication.CleanUp := self.cbCleanUp.Checked;
end;

procedure TfrmCutApplicationBase.btnBrowsePathClick(Sender: TObject);
var
  i: Integer;
begin
    for i := 0 to CutApplication.DefaultExeNames.Count-1 do begin
      selectFileDlg.Filter := CutApplication.DefaultExeNames.Strings[i] + '|'
                            + CutApplication.DefaultExeNames.Strings[i] + '|'
                            + selectFileDlg.Filter;
    end;
    selectFileDlg.Title := Format(CAResources.RsTitleSelectCutApplication, [ CutApplication.Name ]);
    selectFileDlg.InitialDir := ExtractFilePath(self.edtPath.Text);
    selectFileDlg.FileName := ExtractFileName(self.edtPath.Text);
    if selectFileDlg.Execute then begin
      edtPath.Text := selectFileDlg.FileName;
    end else begin
      exit;
    end;
end;

procedure TfrmCutApplicationBase.Init;
begin
  self.edtPath.Text := CutApplication.Path;
  self.edtTempDir.Text := CutApplication.TempDir;
  self.cbRedirectOutput.Checked := CutApplication.RedirectOutput;
  self.cbShowAppWindow.Checked := CutApplication.ShowAppWindow;
  self.cbCleanUp.Checked := CutApplication.CleanUp;
end;

procedure TfrmCutApplicationBase.SetCutApplication(
  const Value: TCutApplicationBase);
var
  i: INteger;
  lbl: string;
  exeNames: TStrings;
  cnt: integer;
begin
  FCutApplication := Value;
  exeNames := FCutApplication.DefaultExeNames;
  cnt := exeNames.Count;
  if cnt = 0 then
    lbl := Format(CAResources.RsCutAppPathTo, [ self.Name ])
  else
    lbl := Format(CAResources.RsCutAppPathTo, [ exeNames[0] ]);

  for i := 0 to cnt - 1 do begin
    lbl := Format(CAResources.RsCutAppPathToMore, [ lbl, exeNames[i] ]);
  end;
end;

procedure TfrmCutApplicationBase.btnBrowseTempDirClick(Sender: TObject);
var
  newDir: String;
begin
  newDir := self.edtTempDir.Text;
  if SelectDirectory(CAResources.RsTitleSelectTemporaryDirectory, '', newDir) then
    self.edtTempDir.Text := newDir;
end;

{ TCutApplicationBase }

procedure TCutApplicationBase.AbortCutProcess;
begin
  if self.FjvcpAppProcess.State <> psReady then begin
    FProcessAborted := true;
    self.FjvcpAppProcess.CloseApplication(true);
  end;
end;

function TCutApplicationBase.CleanUpAfterCutting: boolean;
begin
  result := false;
  if self.CleanUp then begin

    result := true;
  end;
end;

constructor TCutApplicationBase.create;
begin
  inherited;
  FDefaultExeNames := TSTringList.Create;
  FCommandLines := TStringList.Create;
  FjvcpAppProcess := TJvCreateProcess.Create(nil);
  FjvcpAppProcess.OnTerminate := self.jvcpAppProcessTerminate;
  FrameClass := TfrmCutApplicationBase;
  RedirectOutput := false;
  ShowAppWindow := true;
  CleanUp := true;
  RawRead := true;
  FHasSmartRendering := false;
end;

destructor TCutApplicationBase.destroy;
begin
  FreeAndNIL(FjvcpAppProcess);
  FreeAndNIL(FCommandLines);
  FreeAndNIL(FDefaultExeNames);
  inherited;
end;

function TCutApplicationBase.PrepareCutting(SourceFileName: string; var DestFileName: string; Cutlist: TObjectList): boolean;
begin
  Result := false;
  if not FileExists(self.Path) then begin
    ShowMessageFmt(CAResources.RsCutAppNotFound, [ self.Name, self.Path ]);
    exit;
  end;

  Result := true;
end;

procedure TCutApplicationBase.EmergencyTerminateProcess;
begin
  if self.FjvcpAppProcess.State <> psReady then begin
    FProcessAborted := true;
    self.FjvcpAppProcess.Terminate;
  end;
end;

function TCutApplicationBase.ExecuteCutProcess: boolean;
begin
  FProcessAborted := false;
  result := false;
  if self.FCommandLines.Count < 1 then exit;

  if assigned(FOutputMemo) then
  begin
    FOutputMemo.Clear;
    if not FRedirectOutput then
      FOutputMemo.Lines.Add(CAResources.RsCutAppOutNoOutputRedirection);
  end;

  FCommandLineCounter := 0;
  self.jvcpAppProcessTerminate(self, 0);   //start process with first command line
  result := true;
end;

function TCutApplicationBase.GetIniSectionName: string;
begin
  result := Name;
end;

function TCutApplicationBase.GetVersionWords(Index: Integer): word;
begin
  result := 0;
  if Index in [0..3] then begin
    result := FVersionWords[Index];
  end;
end;

function TCutApplicationBase.InfoString: string;
begin
  Result := Format( CAResources.RsCutAppInfoBase, [
                    self.Name,
                    self.Path,
                    self.Version
                    ]);
end;

procedure TCutApplicationBase.jvcpAppProcessRawRead(Sender: TObject;
  const S: String);
begin
  if assigned(self.FOutputMemo) and FRawRead then begin
    FOutputMemo.Text := FOutputMemo.Text + S;
    SendMessage(FOutputMemo.Handle, WM_VSCROLL, SB_BOTTOM, 0);      //Scroll down
  end;
end;

procedure TCutApplicationBase.jvcpAppProcessRead(Sender: TObject;
  const S: string; const StartsOnNewLine: Boolean);
begin
  if assigned(self.FOutputMemo) and not FRawRead then begin
    if StartsOnNewLine then begin
      FOutputMemo.Lines.Add(S);
      SendMessage(FOutputMemo.Handle, WM_VSCROLL, SB_BOTTOM, 0);      //Scroll down
    end else begin
      FOutputMemo.Lines.Strings[FOutPutMemo.Lines.Count-1] := S;
    end;
  end;
end;

procedure TCutApplicationBase.jvcpAppProcessTerminate(Sender: TObject;
  ExitCode: Cardinal);
begin
  if (FCommandLineCounter > 0) and assigned(FOnCommandLineTerminate) then begin
    FOnCommandLineTerminate(Sender, FCommandLineCounter-1, FCommandLines[FCommandLineCounter-1]);
  end;
  if (FCommandLineCounter >= FCommandLines.Count)
   or (ExitCode <> 0)
   or FProcessAborted then  begin

    if ExitCode=0 then begin
      if assigned(FOutputMemo) then
        FOutputMemo.Lines.Add(CAResources.RsCutAppOutFinished);
    end else begin
      if assigned(FOutputMemo) then begin
        FOutputMemo.Lines.Add(CAResources.RsCutAppOutErrorCommand);
        FOutputMemo.Lines.Add(FCommandLines[FCommandLineCounter-1]);
      end;
    end;
    if FProcessAborted then begin
      if assigned(FOutputMemo) then
        FOutputMemo.Lines.Add(CAResources.RsCutAppOutUserAbort);
      ExitCode := Cardinal(-1);
    end;
    if assigned(FOnCuttingTerminate) then
      FOnCuttingTerminate(Sender, ExitCode);

  end else begin
    //Next Command Line
    self.FjvcpAppProcess.CommandLine := '"' + FPath + '" ' + FCommandLines[FCommandLineCounter];
    inc(FCommandLineCounter);
    self.FjvcpAppProcess.Run;
  end;
end;

function TCutApplicationBase.LoadSettings(IniFile: TCustomIniFile): boolean;
const
  TEMP_DIR = 'temp';
var
  section: string;
begin
  section := GetIniSectionName;
  if Path = '' then begin
    if DefaultExeNames.Count > 0 then
      Path := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + DefaultExeNames.Strings[0];
  end;
  Path := IniFile.ReadString(section, 'Path', Path);
  if TempDir = '' then
    TempDir := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(ExtractFilePath(application.ExeName)) + TEMP_DIR);
  TempDir := IniFile.ReadString(section, 'TempDir', TempDir);
  RedirectOutput := iniFile.ReadBool(Section, 'RedirectOutput', RedirectOutput);
  ShowAppWindow := iniFile.ReadBool(Section, 'ShowAppWindow', ShowAppWindow);
  CleanUp := iniFile.ReadBool(Section, 'CleanUp', CleanUp);
  result := true;
end;

function TCutApplicationBase.SaveSettings(IniFile: TCustomIniFile): boolean;
var
  section: string;
begin
  section := GetIniSectionName;
  IniFile.WriteString(section, 'Path', Path);
  IniFile.WriteString(section, 'TempDir', TempDir);
  IniFile.WriteBool(section, 'RedirectOutput', RedirectOutput);
  IniFile.WriteBool(section, 'ShowAppWindow', ShowAppWindow);
  IniFile.WriteBool(section, 'CleanUp', CleanUp);
  result := true;
end;

function TCutApplicationBase.WriteCutlistInfo(
  CutlistFile: TCustomIniFile; section: string): boolean;
begin
  cutlistfile.WriteString(section, 'IntendedCutApplicationName', Name);
  cutlistfile.WriteString(section, 'IntendedCutApplication', extractfilename(Path));
  cutlistfile.WriteString(section, 'IntendedCutApplicationVersion', Version);
  result := true;
end;

procedure TCutApplicationBase.SetCleanUp(const Value: boolean);
begin
  FCleanUp := Value;
end;

procedure TCutApplicationBase.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TCutApplicationBase.SetOnCommandLineTerminate(
  const Value: TCutApplicationCommandLineEvent);
begin
  FOnCommandLineTerminate := Value;
end;

procedure TCutApplicationBase.SetOutputMemo(const Value: TMemo);
begin
  if Value <> FOutputMemo then begin
    FOutputMemo := Value;
    if assigned(FOutputMemo) then begin
      if FRawRead then begin
        self.FjvcpAppProcess.OnRead := nil;
        self.FjvcpAppProcess.OnRawRead := self.jvcpAppProcessRawRead;
      end else begin
        self.FjvcpAppProcess.OnRead := self.jvcpAppProcessRead;
        self.FjvcpAppProcess.OnRawRead := nil;
      end;
    end else begin
      self.FjvcpAppProcess.OnRead := nil;
      self.FjvcpAppProcess.OnRawRead := nil;
    end;
  end;
end;

procedure TCutApplicationBase.SetPath(const Value: string);
var
 dwFileVersionMS, dwFileVersionLS: DWORD;
begin
  if fileexists(Value) then begin
    FPath := Value;
    if Get_File_Version(Value, dwFileVersionMS, dwFileVersionLS) then begin
      FVersion := Get_File_Version(Value);
      FVersionWords[0] := HiWord(dwFileVersionMS);
      FVersionWords[1] := LoWord(dwFileVersionMS);
      FVersionWords[2] := HiWord(dwFileVersionLS);
      FVersionWords[3] := LoWord(dwFileVersionLS);
    end else begin
      FVersion := '';
      FVersionWords[0] := 0;
      FVersionWords[1] := 0;
      FVersionWords[2] := 0;
      FVersionWords[3] := 0;
    end;
  end;
end;

procedure TCutApplicationBase.SetRawRead(const Value: boolean);
begin
  FRawRead := Value;
  if assigned(FOutputMemo) then begin
    if FRawRead then begin
      self.FjvcpAppProcess.OnRead := nil;
      self.FjvcpAppProcess.OnRawRead := self.jvcpAppProcessRawRead;
    end else begin
      self.FjvcpAppProcess.OnRead := self.jvcpAppProcessRead;
      self.FjvcpAppProcess.OnRawRead := nil;
    end;
  end;
end;

procedure TCutApplicationBase.SetRedirectOutput(const Value: boolean);
begin
  FRedirectOutput := Value;
  if Value then begin
    FjvcpAppProcess.ConsoleOptions := [coRedirect, coOwnerData];
  end else begin
    FjvcpAppProcess.ConsoleOptions := [];
  end;
end;

procedure TCutApplicationBase.SetShowAppWindow(const Value: boolean);
begin
  FShowAppWindow := Value;
  if Value then begin
    FjvcpAppProcess.StartupInfo.ShowWindow := swNormal;
    FjvcpAppProcess.StartupInfo.DefaultWindowState := true;
  end else begin
    FjvcpAppProcess.StartupInfo.ShowWindow := swHide;
    FjvcpAppProcess.StartupInfo.DefaultWindowState := false;
  end;
end;

procedure TCutApplicationBase.SetTempDir(const Value: string);
begin
  FTempDir := Value;
end;

function TCutApplicationBase.StartCutting: boolean;
begin
  result := ExecuteCutProcess;
end;

end.
