PROGRAM cut_assistant;

{%File 'readme.txt'}
{%File 'news.txt'}
{%File 'license.txt'}
{%File 'cut_assistant_info.xml'}
{%File 'HG_todoList.txt'}

USES
  madExcept,
  SysUtils,
  PBOnceOnly IN 'lib\PBOnceOnly.pas',
  Forms,
  Classes,
  Main IN 'Main.pas' {FMain},
  Settings_dialog IN 'Settings_dialog.pas' {FSettings},
  UMemoDialog IN 'UMemoDialog.pas' {frmMemoDialog},
  ManageFilters IN 'ManageFilters.pas' {FManageFilters},
  Frames IN 'Frames.pas' {FFrames},
  CutlistRate_dialog IN 'CutlistRate_dialog.pas' {FCutlistRate},
  ResultingTimes IN 'ResultingTimes.pas' {FResultingTimes},
  CutlistSearchResults IN 'CutlistSearchResults.pas' {FCutlistSearchResults},
  CutlistInfo_dialog IN 'CutlistInfo_dialog.pas' {FCutlistInfo},
  UploadList IN 'UploadList.pas' {Form1},
  Utils IN 'Utils.pas',
  Movie IN 'Movie.pas',
  CodecSettings IN 'CodecSettings.pas',
  Base64 IN 'lib\Base64.pas',
  VfW IN 'lib\VfW.pas',
  UCutlist IN 'UCutlist.pas',
  UCutApplicationBase IN 'UCutApplicationBase.pas' {frmCutApplicationBase: TFrame},
  UCutApplicationMP4Box IN 'UCutApplicationMP4Box.pas' {frmCutApplicationMP4Box: TFrame},
  UfrmCutting IN 'UfrmCutting.pas' {frmCutting},
  UCutApplicationAsfbin IN 'UCutApplicationAsfbin.pas' {frmCutApplicationAsfbin: TFrame},
  UCutApplicationAviDemux IN 'UCutApplicationAviDemux.pas' {frmCutApplicationAviDemux: TFrame},
  UFilterBank IN 'UFilterBank.pas',
  UCutApplicationVirtualDub IN 'UCutApplicationVirtualDub.pas' {frmCutApplicationVirtualDub: TFrame},
  trackBarEx IN 'VCL\TrackBarEx\trackBarEx.pas',
  Unit_DSTrackBarEx IN 'VCL\DSTrackBarEx\Unit_DSTrackBarEx.pas',
  DateTools IN 'DateTools.pas',
  ULogging IN 'ULogging.pas' {FLogging},
  UDSAStorage IN 'UDSAStorage.pas',
  UAbout IN 'UAbout.pas' {AboutBox},
  UClist IN 'UClist.pas' {frmClist};

{$R *.res}
CONST
  ProcessName                      = '{B3FD8E3A-7C76-404D-81D3-201CC4A4522B}';

VAR
  iParam                           : integer;
  FileList                         : TStringList;
  MessageList                      : TStringList;
  MessageListStream                : TFileStream;

BEGIN
  MessageListStream := NIL;
  MessageList := TStringList.Create;
  TRY
    IF AlreadyRunning(ProcessName, TApplication, TFMain) THEN
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
    Application.CreateForm(TFLogging, FLogging);
    Application.CreateForm(TAboutBox, AboutBox);
    Application.CreateForm(TfrmClist, frmClist);
    // Application.CreateForm(TframeCutlist, frameCutlist);
    Application.CreateForm(TfrmClist, frmClist);
    FFrames.MainForm := FMain;

    FileList := TStringList.Create;
    FOR iParam := 1 TO ParamCount DO BEGIN
      FileList.Add(ParamStr(iParam));
    END;
    TRY
      FMain.ProcessFileList(FileList, true);
    FINALLY
      FreeAndNIL(FileList);
      IF BatchMode OR exit_after_commandline THEN
        application.Terminate
      ELSE
        Application.Run;
    END;
  FINALLY
    IF MessageList.Count > 0 THEN BEGIN
      MessageListStream := TFileStream.Create(ChangeFileExt(Application.ExeName, '.log'), fmCreate OR fmOpenReadWrite, fmShareDenyWrite);
      TRY
        MessageListStream.Seek(0, soFromEnd);
        MessageList.SaveToStream(MessageListStream);
      FINALLY
        FreeAndNil(MessageListStream);
      END;
    END;
    FreeAndNIL(MessageList);
  END;
END.

