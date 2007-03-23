unit UCutApplicationVirtualDub;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UCutApplicationBase, CodecSettings, StdCtrls, IniFiles, Contnrs, MMSystem;

const
  VIRTUALDUB_DEFAULT_EXENAME_1 = 'virtualdub.exe';
  VIRTUALDUB_DEFAULT_EXENAME_2 = 'vdub.exe';

type
  TCutApplicationVirtualDub = class;

  TfrmCutApplicationVirtualDub = class(TfrmCutApplicationBase)
    cbNotClose: TCheckBox;
    cbUseSmartRendering: TCheckBox;
    lblSmartRenderingCodec: TLabel;
    cbxCodec: TComboBox;
    BConfigCodec: TButton;
    btnCodecAbout: TButton;
    procedure BConfigCodecClick(Sender: TObject);
    procedure cbxCodecChange(Sender: TObject);
    procedure btnCodecAboutClick(Sender: TObject);
  private
    { Private declarations }
    CodecState: String;
    CodecStateSize: Integer;
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
    FSelectedCodecIndex: Integer;
    FUseCodec: FOURCC;
    FCodecVersion: DWORD;
    FCodecSettings: string;
    FCodecSettingsSize: Integer;
    procedure SetSelectedCodecIndex(const Value: Integer);
  protected
    FCodecList: TCodecList;

    FNotClose: boolean;
    FUseSmartRendering: boolean;
    FScriptFileName: string;

    function SetUseCodec(const fccHandler: FOURCC; Version: DWORD; SettingsSize: Integer; Settings: String): boolean;
    property SelectedCodecIndex: Integer read FSelectedCodecIndex write SetSelectedCodecIndex;

    function CreateScript(aCutlist: TObjectList; Inputfile, Outputfile: String; var scriptfile: string): boolean;
  public
    //CommandLineOptions: string;

    constructor create; override;
    property UseCodec: FOURCC read FUseCodec;
    function UseCodecString: string;
    property UseCodecVersion: DWord read FCodecVersion;
    function UseCodecVersionString: string;
    function CanDoSmartRendering: boolean;
    function UseSmartRendering: boolean;

    function LoadSettings(IniFile: TIniFile): boolean; override;
    function SaveSettings(IniFile: TIniFile): boolean; override;
    function InfoString: string; override;
    function WriteCutlistInfo(CutlistFile: TIniFile; section: string): boolean; override;
    function PrepareCutting(SourceFileName: string; var DestFileName: string; Cutlist: TObjectList): boolean; override;
    function CleanUpAfterCutting: boolean; override;
  end;

var
  frmCutApplicationVirtualDub: TfrmCutApplicationVirtualDub;

implementation

{$R *.dfm}

uses
  FileCtrl, StrUtils,
  Utils, UCutlist, UfrmCutting, Main;


{ TCutApplicationVirtualDub }

constructor TCutApplicationVirtualDub.create;
begin
  inherited;
  FCodecList := TCodecList.Create;
  FCodecList.Fill;
  FrameClass := TfrmCutApplicationVirtualDub;
  Name := 'VirtualDub';
  DefaultExeNames.Add(VIRTUALDUB_DEFAULT_EXENAME_1);
  DefaultExeNames.Add(VIRTUALDUB_DEFAULT_EXENAME_2);
  RedirectOutput := false;
  ShowAppWindow := true;
  FNotClose := false;
  FUseSmartRendering := true;
end;

function TCutApplicationVirtualDub.LoadSettings(IniFile: TIniFile): boolean;
var
  section: string;
  success: boolean;
  default, StrValue: string;
  fccHandler: FOURCC;
  CodecVersion: DWORD;
  CodecSettingsBuffer: PChar;
  CodecSettings: String;
  CodecSettingsSize, CodecSettingsSizeRead, BufferSize: Integer;
begin
  result := false;

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

  StrValue := IniFile.ReadString(section, 'CodecFourCC', '0x0');
  fccHandler := StrToInt64Def(StrValue, $00000000);
  StrValue := IniFile.ReadString(section, 'CodecVersion', '0x0');
  CodecVersion := StrToInt64Def(StrValue, $00000000);
  CodecSettingsSize := IniFile.ReadInteger(section, 'CodecSettingsSize', 0);

  //ini.ReadString does work only up to 2047 characters due to restrictions in iniFiles.pas
  //CodecSettings := ini.ReadString(section, 'CodecSettings', '');
  BufferSize := CodecSettingsSize div 3;
  if (CodecSettingsSize mod 3) > 0 then inc(BufferSize);
  BufferSize := BufferSize * 4 + 1;        //+1 for terminating #0

  getmem(CodecSettingsBuffer, BufferSize * SizeOf(Char));
  try
    CodecSettingsSizeRead := GetPrivateProfileString(PChar(Section), 'CodecSettings', '', CodecSettingsBuffer, BufferSize , PChar(iniFile.FileName));
    if CodecSettingsSizeRead = BufferSize-1 then begin
      SetString(CodecSettings, CodecSettingsBuffer, CodecSettingsSizeRead);
    end else begin
      CodecSettings := '';
      CodecSettingsSize := 0;
    end;
  finally
    freemem(CodecSettingsBuffer, BufferSize * SizeOf(Char));
  end;
  self.SetUseCodec(fccHandler, CodecVersion, CodecSettingsSize, CodecSettings);

  result := success;
end;

function TCutApplicationVirtualDub.SaveSettings(IniFile: TIniFile): boolean;
var
  section: string;
  success: boolean;
begin
  result := false;
  success := inherited SaveSettings(IniFile);

  section := GetIniSectionName;
  //IniFile.WriteString(section, 'CommandLineOptions', CommandLineOptions);
  IniFile.WriteBool(section, 'NotClose', self.FNotClose);
  IniFile.WriteBool(section, 'UseSmartRendering', self.FUseSmartRendering);
  IniFile.WriteString(section, 'CodecFourCC', '0x' + IntToHex(self.FUseCodec, 8));
  IniFile.WriteString(section, 'CodecVersion', '0x' + IntToHex(self.FCodecVersion, 8));
  IniFile.WriteString(section, 'CodecSettings', FCodecSettings);
  IniFile.WriteInteger(section, 'CodecSettingsSize', self.FCodecSettingsSize);

  result := success;
end;

function TCutApplicationVirtualDub.PrepareCutting(SourceFileName: string;
  var DestFileName: string; Cutlist: TObjectList): boolean;
var
  TempCutlist: TCutlist;
  MustFreeTempCutlist: boolean;
  myFormatSettings: TFormatSettings;
  CommandLine, ExeName, message_string: string;
  ExitCode: Cardinal;
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

    CommandLine :=  '/s"'+FScriptFileName+'"';
    if not self.FNotClose then CommandLine := CommandLine + ' /x';

//    CommandLine := CommandLine +  ' ' + self.CommandLineOptions;

    self.FCommandLines.Add(CommandLine);
    result := true;
  finally
    if MustFreeTempCutlist then TempCutlist.Free;
  end;
end;


function TCutApplicationVirtualDub.InfoString: string;
begin
  result := inherited InfoString
         // + 'Options: ' + self.CommandLineOptions + #13#10
          + 'Smart Rendering: ' + booltostr(UseSmartRendering, true) + #13#10
          + 'Codec for Smart Rendering: ' + UseCodecString + #13#10
          + 'Codec Version: ' + UseCodecVersionString +  #13#10;    
end;

function TCutApplicationVirtualDub.WriteCutlistInfo(CutlistFile: TIniFile;
  section: string): boolean;
begin
  result := inherited WriteCutlistInfo(CutlistFile, section);
  if result then begin
    result := false;
    //cutlistfile.WriteString(section, 'IntendedCutApplicationOptions', self.CommandLineOptions);
    cutlistfile.WriteBool(section, 'VDUseSmartRendering', self.UseSmartRendering);
    if UseSmartRendering then begin
      cutlistfile.WriteString(section, 'VDSmartRenderingCodecFourCC', '0x' + IntToHex(self.UseCodec, 8));
      cutlistfile.WriteString(section, 'VDSmartRenderingCodecVersion', '0x' + IntToHex(self.UseCodecVersion, 8));
    end;
    result := true;
  end;
end;    

function TCutApplicationVirtualDub.CleanUpAfterCutting: boolean;
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

{ TfrmCutApplicationVirtualDub }

procedure TfrmCutApplicationVirtualDub.Init;
begin
  inherited;
  //self.edtCommandLineOptions.Text := CutApplication.CommandLineOptions;
  cbNotClose.Checked := CutApplication.FNotClose;
  cbUseSmartRendering.Checked := CutApplication.FUseSmartRendering;
  cbxCodec.Items := CutApplication.FCodecList;
  cbxCodec.ItemIndex := CutApplication.FCodecList.IndexOfCodec(CutApplication.UseCodec);
  CodecState := CutApplication.FCodecSettings;
  CodecStateSize := CutApplication.FCodecSettingsSize;
  if cbxCodec.ItemIndex >= 0 then begin
    BConfigCodec.Enabled := CutApplication.FCodecList.CodecInfoObject[cbxCodec.ItemIndex].HasConfigureBox;
    btnCodecAbout.Enabled := CutApplication.FCodecList.CodecInfoObject[cbxCodec.ItemIndex].HasAboutBox;
  end else begin
    BConfigCodec.Enabled := false;
    btnCodecAbout.Enabled := false;
  end;
end;

procedure TfrmCutApplicationVirtualDub.Apply;
begin
  inherited;
  //CutApplication.CommandLineOptions := edtCommandLineOptions.Text;
  CutApplication.FNotClose := cbNotClose.Checked;
  CutApplication.FUseSmartRendering := cbUseSmartRendering.Checked;
  CutApplication.SelectedCodecIndex := cbxCodec.ItemIndex;
  if cbxCodec.ItemIndex >= 0 then begin
    CutApplication.FCodecSettings := CodecState;
    CutApplication.FCodecSettingsSize := CodecStateSize;
  end;
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
    if FUseCodec <> 0 then begin
      writeln(f, 'VirtualDub.video.SetCompression(0x' + IntToHex(FUseCodec, 8) + ',0,10000,0);');
      if self.FCodecSettings > '' then begin
        writeln(f, 'VirtualDub.video.SetCompData(' + inttostr(self.FCodecSettingsSize) + ',"' + Self.FCodecSettings + '");');
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

procedure TCutApplicationVirtualDub.SetSelectedCodecIndex(
  const Value: Integer);
begin
  FSelectedCodecIndex := Value;
  if Value < 0 then begin
    FUseCodec := 0;
    self.FCodecVersion := 0;
  end else begin
    FUseCodec := FCodecList.CodecInfo[Value].fccHandler;
    self.FCodecVersion := FCodecList.CodecInfo[Value].dwVersion;
  end;
  self.FCodecSettings := '';
  self.FCodecSettingsSize := 0;
end;

function TCutApplicationVirtualDub.SetUseCodec(const fccHandler: FOURCC;
  Version: DWORD; SettingsSize: Integer; Settings: String): boolean;
var
  i: Integer;
begin
  result := false;
  i := FCodecList.IndexOfCodec(fccHandler);
  if i<0 then begin
    {self.FUseCodec := 0;
    self.FCodecVersion := 0;
    self.FCodecSettings := '';
    self.FCodecSettingsSize := 0;  }
    exit;
  end;
  SetSelectedCodecIndex(i);  //<--- Set FUseCodec and FCOdecVersion. Clear CFodecSettings and FCodecSettingssize
  if self.FCodecVersion = version then begin
    self.FCodecSettings := Settings;
    self.FCodecSettingsSize := SettingsSize;
  end;
  result := true;
end;

function TCutApplicationVirtualDub.UseSmartRendering: boolean;
begin
  result := (self.FUseSmartRendering and self.CanDoSmartRendering);
end;

procedure TfrmCutApplicationVirtualDub.BConfigCodecClick(Sender: TObject);
var
  s: String;
  sz: integer;
begin
  inherited;
  if cbxCodec.ItemIndex < 0 then exit;
  s := CodecState;
  sz := CodecStateSize;
//  if ConfigCodec((cbxCodec.Items.Objects[cbxCodec.ItemIndex] as TICInfoObject).ICInfo, s, sz) then begin
  if (cbxCodec.Items.Objects[cbxCodec.ItemIndex] as TICInfoObject).Config(self.Handle, s, sz) then begin
    CodecState := s;
    CodecStateSize := sz;
  end;

end;

procedure TfrmCutApplicationVirtualDub.cbxCodecChange(Sender: TObject);
begin
  inherited;
  self.CodecState := '';
  self.CodecStateSize := 0;
  if cbxCodec.ItemIndex >= 0 then begin
    BConfigCodec.Enabled := CutApplication.FCodecList.CodecInfoObject[cbxCodec.ItemIndex].HasConfigureBox;
    btnCodecAbout.Enabled := CutApplication.FCodecList.CodecInfoObject[cbxCodec.ItemIndex].HasAboutBox;
  end else begin
    BConfigCodec.Enabled := false;
    btnCodecAbout.Enabled := false;
  end;
end;

function TCutApplicationVirtualDub.UseCodecString: string;
begin
  result := FCodecList.Strings[FSelectedCodecIndex];
end;

function TCutApplicationVirtualDub.UseCodecVersionString: string;
begin
  result := inttostr(HiWord(UseCodecVersion)) +'.' + inttostr(LoWord(UseCodecVersion));
end;

procedure TfrmCutApplicationVirtualDub.btnCodecAboutClick(Sender: TObject);
var
  Codec: TICInfoObject;
begin
  inherited;
  if cbxCodec.ItemIndex < 0 then exit;
  Codec := (cbxCodec.Items.Objects[cbxCodec.ItemIndex] as TICInfoObject);
  if Codec.HasAboutBox then Codec.About(self.Handle);
end;

end.
