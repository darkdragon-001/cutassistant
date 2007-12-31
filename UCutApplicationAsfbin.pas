unit UCutApplicationAsfBin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UCutApplicationBase, StdCtrls, IniFiles, Contnrs, JvExStdCtrls,
  JvCheckBox;

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
    cbRkf: TJvCheckBox;
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
    constructor create; override;
    function LoadSettings(IniFile: TCustomIniFile): boolean; override;
    function SaveSettings(IniFile: TCustomIniFile): boolean; override;
    function InfoString: string; override;
    function WriteCutlistInfo(CutlistFile: TCustomIniFile; section: string): boolean; override;
    function PrepareCutting(SourceFileName: string; var DestFileName: string; Cutlist: TObjectList): boolean; override;
  end;

var
  frmCutApplicationAsfbin: TfrmCutApplicationAsfbin;

implementation

{$R *.dfm}

{$WARN UNIT_PLATFORM OFF}

uses
  CAResources,
  FileCtrl, StrUtils,
  UCutlist, UfrmCutting, Utils;


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

function TCutApplicationAsfbin.LoadSettings(IniFile: TCustomIniFile): boolean;
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

function TCutApplicationAsfbin.SaveSettings(IniFile: TCustomIniFile): boolean;
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
  CommandLine: string;
begin
  result := inherited PrepareCutting(SourceFileName, DestFileName, Cutlist);
  If not Result then
    Exit;

  self.FCommandLines.Clear;
  MustFreeTempCutlist := false;
  TempCutlist := (Cutlist as TCutlist);

  if TempCutlist.Mode <> clmTrim then begin
    TempCutlist := TempCutlist.convert;
    MustFreeTempCutlist := True;
  end;

  CommandLine := '-i "' + SourceFileName + '" -o "' + DestFileName + '" ';

  try
    TempCutlist.sort;
    for iCut := 0 to TempCutlist.Count-1 do begin
      CommandLine := CommandLine + ' -start ' + FloatToStrInvariant(TempCutlist[iCut].pos_from);
      CommandLine := CommandLine + ' -duration ' + FloatToStrInvariant(TempCutlist[iCut].pos_to - TempCutlist[iCut].pos_from);
    end;

    CommandLine := CommandLine +  ' ' + self.CommandLineOptions;
    self.FCommandLines.Add(CommandLine);
    result := true;
  finally
    if MustFreeTempCutlist then
      FreeAndNIL(TempCutlist);
  end;
end;


function TCutApplicationAsfbin.InfoString: string;
begin
  Result := Format( CAResources.RsCutAppInfoAsfBin, [
                    inherited InfoString,
                    self.CommandLineOptions
                    ]);
end;

function TCutApplicationAsfbin.WriteCutlistInfo(CutlistFile: TCustomIniFile;
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
