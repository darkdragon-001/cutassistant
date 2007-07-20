unit UCutApplicationAsfBin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UCutApplicationBase, StdCtrls, IniFiles, Contnrs;

const
  ASFBIN_DEFAULT_EXENAME_1 = 'asfbin.exe';
  ASFBIN_DEFAULT_EXENAME_2 = 'asfcut.exe';

  //rkf Options Syntax
  RKF_1 = '-rkf';
  RKF_2 = '-recreatekf';


type
  TCutApplicationAsfbin = class;

  TfrmCutApplicationAsfbin = class(TfrmCutApplicationBase)
    edtCommandLineOptions: TEdit;
    lblCommandLineOptions: TLabel;
    cbRkf: TCheckBox;
    procedure cbRkfClick(Sender: TObject);
    procedure edtCommandLineOptionsChange(Sender: TObject);
  private
    { Private declarations }
    procedure SetCutApplication(const Value: TCutApplicationAsfbin);
    function GetCutApplication: TCutApplicationAsfbin;
  public
    { Public declarations }
    property CutApplication: TCutApplicationAsfbin read GetCutApplication write SetCutApplication;
    procedure Init; override;
    procedure Apply; override;
  end;

  TCutApplicationAsfbin = class(TCutApplicationBase)
  protected
  public
    CommandLineOptions: string;
    //TempDir: string;
    constructor create; override;
    function LoadSettings(IniFile: TIniFile): boolean; override;
    function SaveSettings(IniFile: TIniFile): boolean; override;
    function InfoString: string; override;
    function WriteCutlistInfo(CutlistFile: TIniFile; section: string): boolean; override;
    function PrepareCutting(SourceFileName: string; var DestFileName: string; Cutlist: TObjectList): boolean; override;
  end;

var
  frmCutApplicationAsfbin: TfrmCutApplicationAsfbin;

implementation

{$R *.dfm}

{$WARN UNIT_PLATFORM OFF}

uses
  FileCtrl, StrUtils,
  Utils, UCutlist, UfrmCutting;


{ TCutApplicationAsfbin }

constructor TCutApplicationAsfbin.create;
begin
  inherited;
  FrameClass := TfrmCutApplicationAsfbin;
  Name := 'Asfbin';
  DefaultExeNames.Add(ASFBIN_DEFAULT_EXENAME_1);
  DefaultExeNames.Add(ASFBIN_DEFAULT_EXENAME_2);
  RedirectOutput := true;
  ShowAppWindow := false;
end;

function TCutApplicationAsfbin.LoadSettings(IniFile: TIniFile): boolean;
var
  section: string;
  success: boolean;
begin
  //This part only for compatibility issues for versions below 0.9.9
  //These Settings may be overwritten below
  self.Path := IniFile.ReadString('External Cut Application', 'Path', '');
  self.CommandLineOptions := IniFile.ReadString('External Cut Application', 'CommandLineOptions', '');

  success := inherited LoadSettings(IniFile);
  section := GetIniSectionName;
  CommandLineOptions := IniFile.ReadString(section, 'CommandLineOptions', CommandLineOptions);
  result := success;
end;

function TCutApplicationAsfbin.SaveSettings(IniFile: TIniFile): boolean;
var
  section: string;
  success: boolean;
begin
  success := inherited SaveSettings(IniFile);

  section := GetIniSectionName;
  IniFile.WriteString(section, 'CommandLineOptions', CommandLineOptions);
  result := success;
end;

function TCutApplicationAsfbin.PrepareCutting(SourceFileName: string;
  var DestFileName: string; Cutlist: TObjectList): boolean;
var
  TempCutlist: TCutlist;
  iCut: Integer;
  MustFreeTempCutlist: boolean;
  myFormatSettings: TFormatSettings;
  temp_DecimalSeparator: char;
  CommandLine, ExeName: string;
  ExitCode: Cardinal;
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

  CommandLine := '-i "' + SourceFileName + '" -o "' + DestFileName + '" ';

  Temp_DecimalSeparator := DecimalSeparator;
  if TempCutlist.Mode <> clmCrop then begin
    TempCutlist := TempCutlist.convert;
    MustFreeTempCutlist := True;
  end;
  try
    DecimalSeparator := '.';
    TempCutlist.sort;
    for iCut := 0 to TempCutlist.Count-1 do begin
      CommandLine := CommandLine + ' -start ' + floattostr(TempCutlist[iCut].pos_from);
      CommandLine := CommandLine + ' -duration ' + floattostr(TempCutlist[iCut].pos_to - TempCutlist[iCut].pos_from);
    end;

    CommandLine := CommandLine +  ' ' + self.CommandLineOptions;
    self.FCommandLines.Add(CommandLine);
    result := true;
  finally
    if MustFreeTempCutlist then TempCutlist.Free;
    DecimalSeparator := Temp_DecimalSeparator;
  end;         
end;


function TCutApplicationAsfbin.InfoString: string;
begin
  result := inherited InfoString
          + 'Options: ' + self.CommandLineOptions + #13#10;
end;

function TCutApplicationAsfbin.WriteCutlistInfo(CutlistFile: TIniFile;
  section: string): boolean;
begin
  result := inherited WriteCutlistInfo(CutlistFile, section);
  if result then begin
    cutlistfile.WriteString(section, 'IntendedCutApplicationOptions', self.CommandLineOptions);
    result := true;
  end;
end;

{ TfrmCutApplicationAsfbin }

procedure TfrmCutApplicationAsfbin.Init;
begin
  inherited;
  self.edtCommandLineOptions.Text := CutApplication.CommandLineOptions;
  self.edtCommandLineOptionsChange(nil);
end;

procedure TfrmCutApplicationAsfbin.Apply;
begin
  inherited;
  CutApplication.CommandLineOptions := edtCommandLIneOptions.Text;
end;

procedure TfrmCutApplicationAsfbin.SetCutApplication(
  const Value: TCutApplicationAsfbin);
begin
  FCutApplication := Value;
end;

function TfrmCutApplicationAsfbin.GetCutApplication: TCutApplicationAsfbin;
begin
  result := (self.FCutApplication as TCutApplicationAsfbin);
end;   

procedure TfrmCutApplicationAsfbin.cbRkfClick(Sender: TObject);
var
  s: string;
begin
  s := edtCommandLineOptions.Text;
  if cbRkf.Checked then begin
    if not (AnsiContainsText(s, RKF_1) or AnsiContainsText(s, RKF_2)) then begin
      s := RKF_1 + ' ' + s;
    end;
  end else begin
    s := AnsiReplaceText(s, RKF_1, '');
    s := AnsiReplaceText(s, RKF_2, '');
    //remove double spaces
    while AnsiPos('  ', s) > 0 do begin
      s := AnsiReplaceText(s, '  ', ' ');
    end;
  end;
  edtCommandLineOptions.Text := trim(s);
end;

procedure TfrmCutApplicationAsfbin.edtCommandLineOptionsChange(
  Sender: TObject);
var
  s: string;
begin
  s := edtCommandLineOptions.Text;
  self.cbRkf.Checked := (AnsiContainsText(s, RKF_1) or AnsiContainsText(s, RKF_2));
end;

end.
