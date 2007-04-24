program cut_assistant;

uses
  PBOnceOnly in 'lib\PBOnceOnly.pas',
  Forms,
  Classes,
  Main in 'Main.pas' {FMain},
  Settings_dialog in 'Settings_dialog.pas' {FSettings},
  UMemoDialog in 'UMemoDialog.pas' {frmMemoDialog},
  ManageFilters in 'ManageFilters.pas' {FManageFilters},
  Frames in 'Frames.pas' {FFrames},
  CutlistRate_dialog in 'CutlistRate_dialog.pas' {FCutlistRate},
  ResultingTimes in 'ResultingTimes.pas' {FResultingTimes},
  CutlistSearchResults in 'CutlistSearchResults.pas' {FCutlistSearchResults},
  CutlistInfo_dialog in 'CutlistInfo_dialog.pas' {FCutlistInfo},
  UploadList in 'UploadList.pas' {Form1},
  Utils in 'Utils.pas',
  Movie in 'Movie.pas',
  CodecSettings in 'CodecSettings.pas',
  Base64 in 'lib\Base64.pas',
  VfW in 'lib\VfW.pas',
  UCutlist in 'UCutlist.pas',
  UCutApplicationBase in 'UCutApplicationBase.pas' {frmCutApplicationBase: TFrame},
  UCutApplicationMP4Box in 'UCutApplicationMP4Box.pas' {frmCutApplicationMP4Box: TFrame},
  UfrmCutting in 'UfrmCutting.pas' {frmCutting},
  UCutApplicationAsfbin in 'UCutApplicationAsfbin.pas' {frmCutApplicationAsfbin: TFrame},
  UCutApplicationAviDemux in 'UCutApplicationAviDemux.pas' {frmCutApplicationAviDemux: TFrame},
  UFilterBank in 'UFilterBank.pas',
  UCutApplicationVirtualDub in 'UCutApplicationVirtualDub.pas' {frmCutApplicationVirtualDub: TFrame},
  trackBarEx in 'VCL\TrackBarEx\trackBarEx.pas',
  Unit_DSTrackBarEx in 'VCL\DSTrackBarEx\Unit_DSTrackBarEx.pas',
  DateTools in 'DateTools.pas';

{$R *.res}
const
  ProcessName = '{B3FD8E3A-7C76-404D-81D3-201CC4A4522B}';

var
  iParam: integer;
  FileList: TStringList;

begin
  if AlreadyRunning(ProcessName, TApplication, TFMain) then
    Exit;

  Application.Initialize;
  Application.Title := 'Cut Assistant';
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TFSettings, FSettings);
  Application.CreateForm(TfrmMemoDialog, frmMemoDialog);
  Application.CreateForm(TFManageFilters, FManageFilters);
  Application.CreateForm(TFFrames, FFrames);
  Application.CreateForm(TFCutlistRate, FCutlistRate);
  Application.CreateForm(TFResultingTimes, FResultingTimes);
  Application.CreateForm(TFCutlistSearchResults, FCutlistSearchResults);
  Application.CreateForm(TFCutlistInfo, FCutlistInfo);
  Application.CreateForm(TFUploadList, FUploadList);
  Application.CreateForm(TfrmCutting, frmCutting);
  FFrames.MainForm := FMain;

  FileList := TStringList.Create;
  for iParam := 1 to ParamCount do begin
    FileList.Add(ParamStr(iParam));
  end;
  try
    FMain.ProcessFileList(FileList, true);
  finally
    FileList.Free;
    if BatchMode or exit_after_commandline then
      application.Terminate
    else
      Application.Run;
  end;

end.
