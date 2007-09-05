unit UCutApplicationAviDemux;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UCutApplicationBase, StdCtrls, IniFiles, Contnrs;

const
  AVIDEMUX_DEFAULT_EXENAME = 'avidemux2.exe';

type
  TCutApplicationAviDemux = class;

  TfrmCutApplicationAviDemux = class(TfrmCutApplicationBase)
    edtADCommandLineOptions: TEdit;
    CBADRebuildIndex: TCheckBox;
    CBADScanVBR: TCheckBox;
    CBADSmartCopy: TCheckBox;
    CBADNoGUI: TCheckBox;
    CBADAutoSave: TCheckBox;
    CBADNotClose: TCheckBox;
    lblCommandLineOptions: TLabel;
  private
    { Private declarations }
    procedure SetCutApplication(const Value: TCutApplicationAviDemux);
    function GetCutApplication: TCutApplicationAviDemux;
  public
    { Public declarations }
    property CutApplication: TCutApplicationAviDemux read GetCutApplication write SetCutApplication;
    procedure Init; override;
    procedure Apply; override;
  end;

  TCutApplicationAviDemux = class(TCutApplicationBase)
  protected
    FScriptFileName: string;
    function CreateADScript(cutlist: TObjectList; Inputfile, Outputfile: String; var scriptfile: string): boolean;
  public
    CommandLineOptions: string;
    RebuildIndex,
    ScanVBR,
    SmartCopy,
    NoGUI,
    AutoSave,
    NotClose: boolean;

    //TempDir: string;
    constructor create; override;
    function LoadSettings(IniFile: TIniFile): boolean; override;
    function SaveSettings(IniFile: TIniFile): boolean; override;
    function InfoString: string; override;
    function WriteCutlistInfo(CutlistFile: TIniFile; section: string): boolean; override;
    function PrepareCutting(SourceFileName: string; var DestFileName: string; Cutlist: TObjectList): boolean; override;
    function CleanUpAfterCutting: boolean; override;
  end;

var
  frmCutApplicationAviDemux: TfrmCutApplicationAviDemux;

implementation

{$R *.dfm}

{$WARN UNIT_PLATFORM OFF}

uses
  FileCtrl, StrUtils,
  Utils, UCutlist, UfrmCutting, Main;


{ TCutApplicationAviDemux }

constructor TCutApplicationAviDemux.create;
begin
  inherited;
  FrameClass := TfrmCutApplicationAviDemux;
  Name := 'AviDemux';
  DefaultExeNames.Add(AVIDEMUX_DEFAULT_EXENAME);
  RedirectOutput := false;
  ShowAppWindow := true;
end;

function TCutApplicationAviDemux.LoadSettings(IniFile: TIniFile): boolean;
var
  section: string;
  success: boolean;
begin
  //This part only for compatibility issues for versions below 0.9.9
  //This Setting may be overwritten below
  self.TempDir := IniFile.ReadString('AviDemux', 'ScriptsPath', '');


  success := inherited LoadSettings(IniFile);
  section := GetIniSectionName;
  CommandLineOptions := IniFile.ReadString(section, 'CommandLineOptions', CommandLineOptions);

  self.NotClose := IniFile.ReadBool(section, 'NotClose', false);
  self.AutoSave := IniFile.ReadBool(section, 'StartAndRun', true); //only for Compatibility to 0.9.7.x
  self.AutoSave := IniFile.ReadBool(section, 'AutoSave', self.AutoSave);
  self.RebuildIndex := IniFile.ReadBool(section, 'RebuildIndex', false);
  self.ScanVBR := IniFile.ReadBool(section, 'ScanVBR', true);
  self.SmartCopy := IniFile.ReadBool(section, 'SmartCopy', true);
  self.NoGUI := IniFile.ReadBool(section, 'NoGUI', false);
  result := success;
end;

function TCutApplicationAviDemux.SaveSettings(IniFile: TIniFile): boolean;
var
  section: string;
  success: boolean;
begin
  success := inherited SaveSettings(IniFile);

  section := GetIniSectionName;
  IniFile.WriteString(section, 'CommandLineOptions', CommandLineOptions);

  IniFile.WriteBool(section, 'RebuildIndex', self.RebuildIndex);
  IniFile.WriteBool(section, 'ScanVBR', self.ScanVBR);
  IniFile.WriteBool(section, 'AutoSave', self.AutoSave);
  IniFile.WriteBool(section, 'NoGUI', self.NoGUI);
  IniFile.WriteBool(section, 'NotClose', self.NotClose);
  IniFile.WriteBool(section, 'SmartCopy', self.SmartCopy);
  result := success;
end;

function TCutApplicationAviDemux.PrepareCutting(SourceFileName: string;
  var DestFileName: string; Cutlist: TObjectList): boolean;
var
  TempCutlist: TCutlist;
  MustFreeTempCutlist: boolean;
  CommandLine, ExeName, message_string: string;
  //ExitCode: Cardinal;
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
        end else begin
          success := false;
        end;
      end else begin
        success := true;
      end;
      if success then
        FScriptFileName := IncludeTrailingPathDelimiter(TempDir) + extractFileName(SourceFileName) + '.avidemux';
    end;

    CreateADScript(TempCutlist, SourceFileName, DestFileName, FScriptFileName);

    CommandLine := '';
    if NoGUI then CommandLine := '--nogui ';
    CommandLine := CommandLine + '--run "'+FScriptFileName+'"';
    if SmartCopy then CommandLine := CommandLine + ' --force-smart ';
    if AutoSave then CommandLine := CommandLine + ' --save "' + DestFileName + '"';
    if (not NotClose) and AutoSave then CommandLine := CommandLine + ' --quit';
    CommandLine := CommandLine +  ' ' + self.CommandLineOptions;

    self.FCommandLines.Add(CommandLine);
    result := true;
  finally
    if MustFreeTempCutlist then FreeAndNIL(TempCutlist);
  end;
end;


function TCutApplicationAviDemux.InfoString: string;
begin
  result := inherited InfoString
          + 'Options: ' + self.CommandLineOptions + #13#10
          + 'Rebuild Movie Index: ' + booltostr(self.RebuildIndex, true) + #13#10
          + 'Scan Audio for VBR: ' + booltostr(self.ScanVBR, true) + #13#10
          + 'Smart Copy: ' + booltostr(self.SmartCopy, true) + #13#10;
end;

function TCutApplicationAviDemux.WriteCutlistInfo(CutlistFile: TIniFile;
  section: string): boolean;
begin
  result := inherited WriteCutlistInfo(CutlistFile, section);
  if result then begin
    cutlistfile.WriteString(section, 'IntendedCutApplicationOptions', self.CommandLineOptions);
    cutlistfile.WriteBool(section, 'AviDemuxRebuildIndex', self.RebuildIndex);
    cutlistfile.WriteBool(section, 'AviDemuxScanVBR', self.ScanVBR);
    cutlistfile.WriteBool(section, 'AviDemuxSmartCopy', self.SmartCopy);
    result := true;
  end;
end;

function TCutApplicationAviDemux.CreateADScript(cutlist: TObjectList;
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
  cutlist_tmp: TCutlist;
begin
  cutlist_tmp := TCutlist(cutlist);
  if scriptfile = '' then scriptfile := Inputfile + '.avidemux';
  assignfile(f, scriptfile);
  rewrite(f);
  writeln(f, '//AD  <- Needed to identify//');
  writeln(f, '//--Generated by ' + Application_friendly_name);
  writeln(f, '');
  writeln(f, 'var app = new Avidemux();');
  writeln(f, '');
  writeln(f, '//** Video **');
  writeln(f, 'app.load("' + EscapeString(Inputfile) + '");');
  writeln(f, 'app.clearSegments();');

  cutlist_tmp.sort;
  for i := 0 to cutlist_tmp.Count -1 do begin
    if cutlist_tmp.FramesPresent and not cutlist_tmp.HasChanged then begin
      vdubstart := inttostr(cutlist_tmp.Cut[i].frame_from);
      vdubLength := inttostr(cutlist_tmp.Cut[i].DurationFrames);
    end else begin
      vdubstart := inttostr(round(cutlist_tmp.Cut[i].pos_from / MovieInfo.frame_duration));
      vdubLength := inttostr(round((cutlist_tmp.Cut[i].pos_to - cutlist_tmp.Cut[i].pos_from) / MovieInfo.frame_duration + 1));
    end;
    writeln(f, 'app.addSegment(0,' + vdubstart + ', ' + vdubLength + ');');
  end;

  if RebuildIndex then  writeln(f, 'app.rebuildIndex();');
  writeln(f, '');
  writeln(f, '//** Postproc **');
  writeln(f, 'app.video.setPostProc(3,3,0);');
  writeln(f, 'app.video.codec("Copy","CQ=4","0 ");');
  writeln(f, '');
  writeln(f, '//** Audio **');
  writeln(f, 'app.audio.reset();');
  writeln(f, 'app.audio.codec("copy",128);');
  writeln(f, 'app.audio.normalize=false;');
  writeln(f, 'app.audio.delay=0;');
  if ScanVBR then writeln(f, 'app.audio.scanVBR();');
  writeln(f, '');
  writeln(f, 'app.setContainer("AVI");');
  if SmartCopy then writeln(f, 'app.smartCopyMode();');
  if AutoSave then begin
    writeln(f, 'setSuccess(app.save("' + EscapeString(Outputfile) + '"));');
  end else begin
    writeln(f, 'setSuccess(1);');
  end;

  closefile(f);
  result := true;
end;

function TCutApplicationAviDemux.CleanUpAfterCutting: boolean;
var
  success: boolean;
begin
  result := false;
  if self.CleanUp then begin
    result := inherited CleanUpAfterCutting;
    if FileExists(FScriptFileName) then begin
      success := DeleteFile(FScriptFileName);
      result := result and success;
    end;
  end;    
end;

{ TfrmCutApplicationAviDemux }

procedure TfrmCutApplicationAviDemux.Init;
begin
  inherited;
  self.edtADCommandLineOptions.Text := CutApplication.CommandLineOptions;
  CBADAutoSave.Checked      := CutApplication.AutoSave;
  CBADNotClose.Checked      := CutApplication.NotClose;
  CBADRebuildIndex.Checked  := CutApplication.RebuildIndex;
  CBADScanVBR.Checked       := CutApplication.ScanVBR;
  CBADSmartCopy.Checked     := CutApplication.SmartCopy;
  CBADNoGUI.Checked         := CutApplication.NoGUI;
end;

procedure TfrmCutApplicationAviDemux.Apply;
begin
  inherited;
  CutApplication.CommandLineOptions := edtADCommandLineOptions.Text;

  CutApplication.AutoSave     := CBADAutoSave.Checked   ;
  CutApplication.NotClose     := CBADNotClose.Checked      ;
  CutApplication.RebuildIndex := CBADRebuildIndex.Checked ;
  CutApplication.ScanVBR      := CBADScanVBR.Checked;
  CutApplication.SmartCopy    := CBADSmartCopy.Checked;
  CutApplication.NoGUI        := CBADNoGUI.Checked;
end;

procedure TfrmCutApplicationAviDemux.SetCutApplication(
  const Value: TCutApplicationAviDemux);
begin
  FCutApplication := Value;
end;

function TfrmCutApplicationAviDemux.GetCutApplication: TCutApplicationAviDemux;
begin
  result := (self.FCutApplication as TCutApplicationAviDemux);
end;

end.
