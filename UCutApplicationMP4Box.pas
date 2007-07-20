unit UCutApplicationMP4Box;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UCutApplicationBase, StdCtrls, IniFiles, Contnrs;

const
  MP4BOX_DEFAULT_EXENAME = 'MP4Box.exe';

type
  TCutApplicationMP4Box = class;

  TfrmCutApplicationMP4Box = class(TfrmCutApplicationBase)
    edtCommandLineOptions: TEdit;
    lblCommandLineOptions: TLabel;
  private
    { Private declarations }
    procedure SetCutApplication(const Value: TCutApplicationMP4Box);
    function GetCutApplication: TCutApplicationMP4Box;
  public
    { Public declarations }
    property CutApplication: TCutApplicationMP4Box read GetCutApplication write SetCutApplication;
    procedure Init; override;
    procedure Apply; override;
  end;

  TCutApplicationMP4Box = class(TCutApplicationBase)
  protected
    FSourceFile, FDestFile: string;
    FFilePath: String;
    FOriginalFileList, FTempFileList: TStringList;
    FAddLastCommandTriggerIndex: Integer;
    procedure CommandLineTerminate(Sender: TObject; const CommandLineIndex: Integer; const CommandLine: string);
  public
    CommandLineOptions: string;
    //TempDir: string;
    constructor create; override;
    destructor destroy; override;
    function LoadSettings(IniFile: TIniFile): boolean; override;
    function SaveSettings(IniFile: TIniFile): boolean; override;
    function InfoString: string; override;
    function WriteCutlistInfo(CutlistFile: TIniFile; section: string): boolean; override;
    function PrepareCutting(SourceFileName: string; var DestFileName: string; Cutlist: TObjectList): boolean; override;
    function CleanUpAfterCutting: boolean; override;
  end;

var
  frmCutApplicationMP4Box: TfrmCutApplicationMP4Box;

implementation

{$R *.dfm}

{$WARN UNIT_PLATFORM OFF}

uses
  FileCtrl, StrUtils,
  Utils, UCutlist, UfrmCutting;


{ TCutApplicationMP4Box }

constructor TCutApplicationMP4Box.create;
begin
  inherited;
  RawRead := false;
  self.OnCommandLineTerminate := self.CommandLineTerminate;
  FrameClass := TfrmCutApplicationMP4Box;
  Name := 'MP4Box';
  DefaultExeNames.Add(MP4BOX_DEFAULT_EXENAME);
  RedirectOutput := true;
  ShowAppWindow := false;

  FOriginalFileList := TStringList.Create;
  FTempFileList := TStringList.Create;
end;

function TCutApplicationMP4Box.LoadSettings(IniFile: TIniFile): boolean;
var
  section: string;
  success: boolean;
begin
  success := inherited LoadSettings(IniFile);
  section := GetIniSectionName;
  CommandLineOptions := IniFile.ReadString(section, 'CommandLineOptions', '');
  result := success;
end;

function TCutApplicationMP4Box.SaveSettings(IniFile: TIniFile): boolean;
var
  section: string;
  success: boolean;
begin
  success := inherited SaveSettings(IniFile);

  section := GetIniSectionName;
  IniFile.WriteString(section, 'CommandLineOptions', CommandLineOptions);
  result := success;
end;

function TCutApplicationMP4Box.PrepareCutting(SourceFileName: string;
  var DestFileName: string; Cutlist: TObjectList): boolean;
const
  ForcedFileExt = '.mp4';
var
  TempCutlist: TCutlist;
  iCut: Integer;
  MustFreeTempCutlist: boolean;
  myFormatSettings: TFormatSettings;
  temp_DecimalSeparator: char;
  CommandLine, TempFileName, TempFileExt, ExeName: string;
  ExitCode: Cardinal;
  SearchRec: TSearchRec;
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

  //Rename Files to MP4
//  TempFileExt := ExtractFileExt(SourceFileName);
//  ChangeFileExt(SourceFileName, ForcedFileExt);
//  ChangeFileExt(DestFileName, ForcedFileExt);
  TempCutlist := (Cutlist as TCutlist);

  self.FCommandLines.Clear;
  self.FSourceFile := SourceFileName;
  self.FDestFile := DestFileName;

  Temp_DecimalSeparator := DecimalSeparator;
  if TempCutlist.Mode <> clmCrop then begin
    TempCutlist := TempCutlist.convert;
    MustFreeTempCutlist := True;
  end;
  try
    DecimalSeparator := '.';
    TempCutlist.sort;
    if tempCutlist.Count = 1 then begin
      CommandLine := '"'+ SourceFileName + '"';
      CommandLine := CommandLine + ' -splitx ' + floattostr(TempCutlist[0].pos_from) + ':'  + floattostr(TempCutlist[0].pos_to);

      //-out Parameter does not seem to work with -slitx. Maybe a bug in mp4box :(
      //That's why we have to work around this and detect what files are new. see below.

      //CommandLine := CommandLine + ' -out "' + DestFileName+ '"';

      self.FCommandLines.Add(CommandLine);

    end else begin
      self.FCommandLines.Clear;
      for iCut := 0 to tempCutlist.Count -1 do begin
   //     TempFileName := 'Part_1_' + extractFileName(SourceFileName);
        CommandLine := '"'+ SourceFileName + '"';
        CommandLine := CommandLine + ' -splitx ' + floattostr(TempCutlist[iCut].pos_from) + ':'  + floattostr(TempCutlist[iCut].pos_to);
        self.FCommandLines.Add(CommandLine);
      end;
    end;

    //Workaround for not working -out parameter
    //Add final Command after last Command of list is executed
    FAddLastCommandTriggerIndex := FCommandLines.Count - 1;
    //
    FFilePath := extractFilePath(SourceFileName);
    //Make List of existing files
    self.FOriginalFileList.Clear;
    if findFirst(FFilePath+'*.*', faAnyFile, SearchRec) = 0 then begin
      repeat
        FOriginalFileList.Add(SearchRec.Name);
      until FindNext(SearchRec) <> 0;
      FindClose(SearchRec);
    end;

    result := true;
  finally
    if MustFreeTempCutlist then TempCutlist.Free;
    DecimalSeparator := Temp_DecimalSeparator;
//    ChangeFileExt(SourceFileName, TempFileExt);
  end;

end;


function TCutApplicationMP4Box.InfoString: string;
begin
  result := inherited InfoString
          + 'Options: ' + self.CommandLineOptions + #13#10;
end;

function TCutApplicationMP4Box.WriteCutlistInfo(CutlistFile: TIniFile;
  section: string): boolean;
begin
  result := inherited WriteCutlistInfo(CutlistFile, section);
  if result then begin
    result := false;
    cutlistfile.WriteString(section, 'IntendedCutApplicationOptions', self.CommandLineOptions);
    result := true;
  end;
end;

destructor TCutApplicationMP4Box.destroy;
begin
  FTempFileList.Free;
  FOriginalFileList.Free;
  inherited;
end;


  function FileNameCompare(List: TStringList; Index1, Index2: Integer): Integer;
   {The callback returns
      a value less than 0 if the string identified by Index1 comes before the string identified by Index2
      0 if the two strings are equivalent
      a value greater than 0 if the string with Index1 comes after the string identified by Index2.}
  var
    int1, int2: Integer;
  begin
    int1 := Integer(List.Objects[Index1]);
    int2 := Integer(List.Objects[Index2]);
    if int1>int2 then result := 1;
    if int1<int2 then result := -1;
    if int1=int2 then result := 0;
  end;

procedure TCutApplicationMP4Box.CommandLineTerminate(Sender: TObject;
  const CommandLineIndex: Integer; const CommandLine: string);
var
  SearchRec: TSearchRec;
  i: Integer;
  NewCommandLine: String;
  TempFileName: string;
  EndsSeconds: Integer;
  posUnderscore, posDot: Integer;
begin
  if CommandLineIndex = FAddLastCommandTriggerIndex then begin
    //Last Command Line Executed, now determine new files and add -cat command
    //Make List of new files
    FTempFileList.Clear;
    if findFirst(FFilePath+'*.*', faAnyFile, SearchRec) = 0 then begin
      repeat
        if FOriginalFileList.IndexOf(SearchRec.Name)<0 then begin
          //get End Time in seconds from file Name
          EndsSeconds := 0;
          posUnderscore := LastDelimiter('_', SearchRec.Name);
          if PosUnderscore > 0 then begin
            posDot := LastDelimiter('.', SearchRec.Name);
            if posDot < posUnderScore then posDot := length(SearchRec.Name)+1;
            EndsSeconds := StrToIntDef(midstr(SearchRec.Name,PosUnderScore+1, PosDot-(PosUnderScore+1)), 0);
          end;
          FTempFileList.AddObject(SearchRec.Name, TObject(EndsSeconds));
        end;
      until FindNext(SearchRec) <> 0;
      FindClose(SearchRec);
      //sort List
      FTempFileList.CustomSort(FileNameCompare);
      //Make CommandLine
      for i := 0 to FTempFileList.Count-1 do begin
        NewCommandLine := NewCommandLine + ' -cat "'+ FFilePath + FTempFileList.Strings[i] + '"';
      end;
      NewCommandLine := NewCommandLine + ' "' + FDestFile + '"';
      FCommandLines.Add(NewCommandLine);
    end;
  end;
end;

function TCutApplicationMP4Box.CleanUpAfterCutting: boolean;
var
  i: Integer;
  success: boolean;
begin
  result := false;
  if self.CleanUp then begin
    result := inherited CleanUpAfterCutting;
    for i := 0 to FTempFileList.Count-1 do begin
      if FileExists(FFilePath + FTempFileList.Strings[i]) then begin
        success := DeleteFile(FFilePath + FTempFileList.Strings[i]);
        result := result and success;
      end;
    end;
  end;
end;

{ TfrmCutApplicationMP4Box }

procedure TfrmCutApplicationMP4Box.Init;
begin
  inherited;
  self.edtCommandLineOptions.Text := CutApplication.CommandLineOptions;
end;

procedure TfrmCutApplicationMP4Box.Apply;
begin
  inherited;
  CutApplication.CommandLineOptions := edtCommandLIneOptions.Text;
end;

procedure TfrmCutApplicationMP4Box.SetCutApplication(
  const Value: TCutApplicationMP4Box);
begin
  FCutApplication := Value;
end;

function TfrmCutApplicationMP4Box.GetCutApplication: TCutApplicationMP4Box;
begin
  result := (self.FCutApplication as TCutApplicationMP4Box);
end;


end.
