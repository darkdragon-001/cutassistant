unit Main;

interface

uses
  Windows, Messages, SysUtils, DateUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, ComCtrls, OleCtrls, StdCtrls, contnrs, shellapi, Buttons,
  ExtCtrls, strutils, iniFiles, Registry, ComObj, Menus, math, ToolWin, Clipbrd,

  ImgList, ActnList,

  IdException, IdBaseComponent, IdComponent, IdThreadComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, IdMultipartFormData, IdAntiFreezeBase, IdAntiFreeze,

  DSPack, DSUtil, DirectShow9, wmf9, ActiveX,

  Settings_dialog, ManageFilters, UploadList, CutlistInfo_dialog, UCutlist,
  Movie, Unit_DSTrackBarEx, trackBarEx, Utils, CodecSettings,

  JvComponentBase, JvSimpleXml, JclSimpleXML, JvGIF, JvSpeedbar, JvExExtCtrls,
  JvExtComponent, JvExControls, JvBaseDlg, JvProgressDialog, JvAppCommand;

const
  //Registry Keys
  CutlistID = 'CutAssistant.Cutlist';
  CUTLIST_CONTENT_TYPE = 'text/plain';
  ProgID = 'Cut_Assistant.exe';
  ShellEditKey = 'CutAssistant.edit';

type

  TFMain = class(TForm{, ISampleGrabberCB})
    cmdStop: TButton;
    cmdPlayPause: TButton;
    lvCutlist: TListView;
    cmdAddCut: TButton;
    cmdDeleteCut: TButton;
    edtFrom: TEdit;
    edtDuration: TEdit;
    edtTo: TEdit;
    lblCutFrom: TLabel;
    lblCutDuration: TLabel;
    lblCutTo: TLabel;
    cmdSetFrom: TButton;
    cmdSetTo: TButton;
    cmdFromStart: TButton;
    cmdToEnd: TButton;
    cmdJumpFrom: TButton;
    cmdJumpTo: TButton;
    cmdReplaceCut: TButton;
    cmdEditCut: TButton;
    rgCutMode: TRadioGroup;
    cmdPrev12: TButton;
    cmdStepBack: TButton;
    cmdStepForwards: TButton;
    tbVolume: TTrackBar;
    lblVolume: TLabel;
    cbMute: TCheckBox;
    lblPos_nl: TLabel;
    cmdNext12: TButton;
    tbFinePos: TtrackBarEx;
    lblMinFinepos_nl: TLabel;
    lblMaxFinepos_nl: TLabel;
    lblDuration_nl: TLabel;
    bvCutilistInfo: TBevel;
    bvMovieControl: TBevel;
    odCutlist: TOpenDialog;
    VideoWindow: TVideoWindow;
    lblFinePos_nl: TLabel;
    tbFilePos: TDSTrackBarEx;
    SampleGrabber: TSampleGrabber;
    TeeFilter: TFilter;
    NullRenderer: TFilter;
    lblStartPosition_nl: TLabel;
    pnlVideoWindow: TPanel;
    cmd12FromTo: TButton;
    cmdConvert: TButton;
    actOpenMovie: TAction;
    actOpenCutlist: TAction;
    actFileExit: TAction;
    ImageList: TImageList;
    actSaveCutlistAs: TAction;
    actAddCut: TAction;
    actReplaceCut: TAction;
    actEditCut: TAction;
    actDeleteCut: TAction;
    actShowFramesForm: TAction;
    actNextFrames: TAction;
    actPrevFrames: TAction;
    actScanInterval: TAction;
    actStartCutting: TAction;
    actEditSettings: TAction;
    actMovieMetaData: TAction;
    actAbout: TAction;
    actUsedFilters: TAction;
    actWriteToRegisty: TAction;
    actRemoveRegistryEntries: TAction;
    actCutlistUpload: TAction;
    WebRequest_nl: TIdHTTP;
    actStepForward: TAction;
    actStepBackward: TAction;
    actBrowseWWWHelp: TAction;
    actOpenCutlistHome: TAction;
    actRepairMovie: TAction;
    cmdCutlistInfo: TBitBtn;
    actCutlistInfo: TAction;
    ICutlistWarning: TImage;
    actSaveCutlist: TAction;
    actCalculateResultingTimes: TAction;
    actAsfbinInfo: TAction;
    pnlAuthor: TPanel;
    lblCutlistAuthor_nl: TLabel;
    actSearchCutlistByFileSize: TAction;
    actSendRating: TAction;
    actDeleteCutlistFromServer: TAction;
    lblTotalCutoff_nl: TLabel;
    lblResultingDuration_nl: TLabel;
    tbRate: TtrackBarEx;
    lblRate: TLabel;
    lblCurrentRate_nl: TLabel;
    lblTrueRate_nl: TLabel;
    cmdNextCut: TButton;
    cmdPrevCut: TButton;
    actNextCut: TAction;
    actPrevCut: TAction;
    cmdFF: TButton;
    FilterGraph: TFilterGraph;
    actFullScreen: TAction;
    actCloseMovie: TAction;
    actSnapshotCopy: TAction;
    actSnapshotSave: TAction;
    mnuVideo: TPopupMenu;
    miVideoCopySnapshottoClipboard_nl: TMenuItem;
    miVideoSaveSnapshotas_nl: TMenuItem;
    actPlayInMPlayerAndSkip: TAction;
    miVideoNextXFrames_nl: TMenuItem;
    miVideoPreviousXFrames_nl: TMenuItem;
    miN1_nl: TMenuItem;
    XMLResponse: TJvSimpleXML;
    ActionList: TActionList;
    SpeedBar_nl: TJvSpeedBar;
    mnuMain: TMainMenu;
    miFile: TMenuItem;
    miCutlist: TMenuItem;
    miEdit: TMenuItem;
    miFrames: TMenuItem;
    miInfo: TMenuItem;
    miOptions: TMenuItem;
    miHelp: TMenuItem;
    miOpenMovie_nl: TMenuItem;
    miStartCutting_nl: TMenuItem;
    miPlayMovieinMPlayer_nl: TMenuItem;
    miRepairMovie_nl: TMenuItem;
    miCloseMovie_nl: TMenuItem;
    miN2_nl: TMenuItem;
    miExit_nl: TMenuItem;
    miOpenCutlist_nl: TMenuItem;
    miSearchCutlistsonServer_nl: TMenuItem;
    miN3_nl: TMenuItem;
    miSaveCutlistAs_nl: TMenuItem;
    miSaveCutlist_nl: TMenuItem;
    miUploadCutlisttoServer_nl: TMenuItem;
    miDeleteCutlistfromServer_nl: TMenuItem;
    miN4_nl: TMenuItem;
    miCutlistInfo_nl: TMenuItem;
    miCheckcutMovie_nl: TMenuItem;
    miSendRating_nl: TMenuItem;
    miAddnewcut_nl: TMenuItem;
    miReplaceselectedcut_nl: TMenuItem;
    miEditselectedcut_nl: TMenuItem;
    miDeleteselectedcut_nl: TMenuItem;
    miShowForm_nl: TMenuItem;
    miN5_nl: TMenuItem;
    miScanInterval_nl: TMenuItem;
    miPreviousXFrames_nl: TMenuItem;
    miNextXFrames_nl: TMenuItem;
    miMovieMetaData_nl: TMenuItem;
    miUsedFilters_nl: TMenuItem;
    miCutApplications_nl: TMenuItem;
    miSettings_nl: TMenuItem;
    miN6_nl: TMenuItem;
    miAssociatewithfileextensions_nl: TMenuItem;
    miRemoveregistryentries_nl: TMenuItem;
    miCutlistHomepage_nl: TMenuItem;
    miInternetHelpPages_nl: TMenuItem;
    miN7_nl: TMenuItem;
    miAbout_nl: TMenuItem;
    JvSpeedBarSection1: TJvSpeedBarSection;
    JvSpeedItem1: TJvSpeedItem;
    JvSpeedItem2: TJvSpeedItem;
    JvSpeedItem3: TJvSpeedItem;
    JvSpeedItem4: TJvSpeedItem;
    JvSpeedItem5: TJvSpeedItem;
    JvSpeedItem6: TJvSpeedItem;
    JvSpeedItem7: TJvSpeedItem;
    JvSpeedItem8: TJvSpeedItem;
    JvSpeedItem9: TJvSpeedItem;
    JvSpeedItem10: TJvSpeedItem;
    JvSpeedItem11: TJvSpeedItem;
    JvSpeedItem12: TJvSpeedItem;
    JvSpeedItem13: TJvSpeedItem;
    JvSpeedItem14: TJvSpeedItem;
    JvSpeedItem15: TJvSpeedItem;
    actSmallSkipForward: TAction;
    actSmallSkipBackward: TAction;
    actLargeSkipForward: TAction;
    actLargeSkipBackward: TAction;
    miNavigation: TMenuItem;
    miStepForward_nl: TMenuItem;
    miStepBack_nl: TMenuItem;
    miN8_nl: TMenuItem;
    miSmallSkipForward_nl: TMenuItem;
    miSmallSkipBack_nl: TMenuItem;
    miN9_nl: TMenuItem;
    miLargeSkipForward_nl: TMenuItem;
    miLargeSkipBack_nl: TMenuItem;
    miN10_nl: TMenuItem;
    miNextCut_nl: TMenuItem;
    miPrevCut_nl: TMenuItem;
    actShowLogging: TAction;
    miN13_nl: TMenuItem;
    miShowLoggingMessages_nl: TMenuItem;
    actTestExceptionHandling: TAction;
    miTestExceptionHandling_nl: TMenuItem;
    actCheckInfoOnServer: TAction;
    miCheckinfoonserver_nl: TMenuItem;
    actOpenCutassistantHome: TAction;
    miCutAssistantProject_nl: TMenuItem;
    dlgRequestProgress: TJvProgressDialog;
    RequestWorker: TIdThreadComponent;
    actSupportRequest: TAction;
    miMakeasupportrequest_nl: TMenuItem;
    lblMovieType_nl: TLabel;
    lblCutApplication_nl: TLabel;
    lblMovieFPS_nl: TLabel;
    actStop: TAction;
    actPlayPause: TAction;
    miPlayPause_nl: TMenuItem;
    miStop_nl: TMenuItem;
    miN16_nl: TMenuItem;
    actPlay: TAction;
    actPause: TAction;
    miPlay_nl: TMenuItem;
    miPause_nl: TMenuItem;
    AppCommand: TJvAppCommand;
    actCurrentFrames: TAction;
    miFramesAround_nl: TMenuItem;
    JvSpeedItem16: TJvSpeedItem;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdSetFromClick(Sender: TObject);
    procedure cmdSetToClick(Sender: TObject);
    procedure cmdFromStartClick(Sender: TObject);
    procedure cmdToEndClick(Sender: TObject);
    procedure cmdJumpFromClick(Sender: TObject);
    procedure cmdJumpToClick(Sender: TObject);
    procedure actStepForwardExecute(Sender: TObject);
    procedure actStepBackwardExecute(Sender: TObject);

    procedure lvCutlistSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvCutlistDblClick(Sender: TObject);
    procedure rgCutModeClick(Sender: TObject);

    procedure tbVolumeChange(Sender: TObject);
    procedure cbMuteClick(Sender: TObject);

    procedure tbFilePosTimer(sender: TObject; CurrentPos,
      StopPos: Cardinal);
    procedure tbFilePosPositionChangedByMouse(Sender: TObject);
    procedure tbFilePosChange(Sender: TObject);
    procedure tbFilePosSelChanged(Sender: TObject);
    procedure tbFilePosChannelPostPaint(Sender: TDSTrackBarEx;
      const ARect: TRect);
    procedure tbFinePosMOuseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbFinePosChange(Sender: TObject);
    procedure FilterGraphGraphStepComplete(Sender: TObject);
    procedure pnlVideoWindowResize(Sender: TObject);
    procedure SampleGrabberBuffer(sender: TObject; SampleTime: Double;
      pBuffer: Pointer; BufferLen: Integer);

    procedure actOpenMovieExecute(Sender: TObject);
    procedure actOpenCutlistExecute(Sender: TObject);
    procedure actSaveCutlistExecute(Sender: TObject);
    procedure actSaveCutlistAsExecute(Sender: TObject);
    procedure actFileExitExecute(Sender: TObject);
    procedure actAddCutExecute(Sender: TObject);
    procedure actReplaceCutExecute(Sender: TObject);
    procedure actEditCutExecute(Sender: TObject);
    procedure actDeleteCutExecute(Sender: TObject);
    procedure cmdConvertClick(Sender: TObject);
    procedure actCutlistInfoExecute(Sender: TObject);
    procedure actSearchCutlistByFileSizeExecute(Sender: TObject);
    procedure actCutlistUploadExecute(Sender: TObject);
    procedure actSendRatingExecute(Sender: TObject);
    procedure actDeleteCutlistFromServerExecute(Sender: TObject);

    procedure actShowFramesFormExecute(Sender: TObject);
    procedure actNextFramesExecute(Sender: TObject);
    procedure actPrevFramesExecute(Sender: TObject);
    procedure actScanIntervalExecute(Sender: TObject);

    procedure actRepairMovieExecute(Sender: TObject);
    procedure actStartCuttingExecute(Sender: TObject);
    procedure actAsfbinInfoExecute(Sender: TObject);
    procedure actMovieMetaDataExecute(Sender: TObject);
    procedure actEditSettingsExecute(Sender: TObject);
    procedure actUsedFiltersExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actBrowseWWWHelpExecute(Sender: TObject);
    procedure actOpenCutlistHomeExecute(Sender: TObject);

    procedure actWriteToRegistyExecute(Sender: TObject);
    procedure actRemoveRegistryEntriesExecute(Sender: TObject);

    procedure actCalculateResultingTimesExecute(Sender: TObject);
    procedure VideoWindowClick(Sender: TObject);
    procedure tbRateChange(Sender: TObject);
    procedure lblCurrentRate_nlDblClick(Sender: TObject);
    procedure actNextCutExecute(Sender: TObject);
    procedure actPrevCutExecute(Sender: TObject);
    procedure cmdFFMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cmdFFMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VideoWindowDblClick(Sender: TObject);
    procedure actFullScreenExecute(Sender: TObject);
    procedure VideoWindowKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actCloseMovieExecute(Sender: TObject);
    procedure actSnapshotCopyExecute(Sender: TObject);
    procedure actSnapshotSaveExecute(Sender: TObject);
    procedure actPlayInMPlayerAndSkipExecute(Sender: TObject);
    function FilterGraphSelectedFilter(Moniker: IMoniker; FilterName: WideString; ClassID: TGUID): Boolean;
    procedure FramePopUpNext12FramesClick(Sender: TObject);
    procedure FramePopUpPrevious12FramesClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actShowLoggingExecute(Sender: TObject);
    procedure actTestExceptionHandlingExecute(Sender: TObject);
    procedure actCheckInfoOnServerExecute(Sender: TObject);
    procedure actOpenCutassistantHomeExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dlgRequestProgressShow(Sender: TObject);
    procedure dlgRequestProgressProgress(Sender: TObject;
      var AContinue: Boolean);
    procedure RequestWorkerRun(Sender: TIdCustomThreadComponent);
    procedure RequestWorkerException(Sender: TIdCustomThreadComponent;
      AException: Exception);
    procedure WebRequest_nlStatus(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: String);
    procedure actSupportRequestExecute(Sender: TObject);
    procedure dlgRequestProgressCancel(Sender: TObject);
    procedure WebRequest_nlWork(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure actStopExecute(Sender: TObject);
    procedure actPlayPauseExecute(Sender: TObject);
    procedure actPlayExecute(Sender: TObject);
    procedure actPauseExecute(Sender: TObject);
    procedure AppCommandAppCommand(Handle: Cardinal; Cmd: Word;
      Device: TJvAppCommandDevice; KeyState: Word; var Handled: Boolean);
    procedure actCurrentFramesExecute(Sender: TObject);
    procedure FilterGraphGraphComplete(sender: TObject; Result: HRESULT;
      Renderer: IBaseFilter);
  private
    { Private declarations }
    UploadDataEntries: TStringList;
    StepComplete: boolean;
    SampleTarget: TObject; //TCutFrame
    procedure ResetForm;
    procedure EnableMovieControls(value: boolean);
    procedure InitVideo;
    procedure InsertSampleGrabber;
    function GetSampleGrabberMediaType(var MediaType: TAMMediaType): HResult;
    function CustomGetSampleGrabberBitmap(Bitmap: TBitmap; Buffer: Pointer; BufferLen: Integer): boolean;
    {
    function SampleCB(SampleTime: double; MediaSample: IMediaSample): HRESULT; stdcall;
    function  BufferCB(SampleTime: Double; pBuffer: PByte; BufferLen: longint): HResult; stdcall;
    }
    procedure refresh_lvCutlist(cutlist: TCutlist);
    function WaitForStep(TimeOut: INteger): boolean;
    procedure WaitForFilterGraph;
    procedure HandleParameter(const param: string);
    function CalcTrueRate(Interval: double): double;
    procedure FF_Start;
    procedure FF_Stop;
    function ConvertUploadData: boolean;
    procedure AddUploadDataEntry(CutlistDate: TDateTime; CutlistName: string; CutlistID: Integer);
    procedure UpdateMovieInfoControls;
  public
    { Public declarations }
    procedure ProcessFileList(FileList: TStringList; IsMyOwnCommandLine: boolean);
    procedure refresh_times;
    procedure enable_del_buttons(value: boolean);
    function CurrentPosition: double;
    procedure JumpTo(NewPosition: double);
    procedure SetStartPosition(Position: double);
    procedure SetStopPosition(Position: double);

    procedure ShowFrames(startframe, endframe: Integer);
    procedure ShowFramesAbs(startframe, endframe: double; numberOfFrames: Integer);

    function OpenFile(Filename: String): boolean;
    function BuildFilterGraph(FileName: String; FileType: TMovieType):boolean;
    function CloseMovieAndCutlist: boolean;
    procedure CloseMovie;
    function GraphPlayPause: boolean;
    function GraphPlay: boolean;
    function GraphPause: boolean;
    function ToggleFullScreen: boolean;
    procedure ShowMetaData;
    function RepairMovie: boolean;
    function StartCutting: boolean;
//    function CreateVDubScript(cutlist: TCutlist; Inputfile, Outputfile: String; var scriptfile: string): boolean;
    function CreateMPlayerEDL(cutlist: TCutlist; Inputfile, Outputfile: String; var scriptfile: string): boolean;

    function DownloadInfo(settings: TSettings; const UseDate, ShowAll: boolean): boolean;
    procedure LoadCutList;
//    function search_cutlist: boolean;
    function SearchCutlistsByFileSize_XML: boolean;
//    function DownloadCutlist(cutlist_name: string): boolean;
    function DownloadCutlistByID(cutlist_id, TargetFileName: string): boolean;
    function UploadCutlist(filename: string): boolean;
    function DeleteCutlistFromServer(const cutlist_id: string):boolean;
    function AskForUserRating(Cutlist: TCutlist): boolean;
    function SendRating(Cutlist: TCutlist): boolean;
  protected
    procedure WMDropFiles(var message: TWMDropFiles); message WM_DROPFILES;
    procedure WMCopyData(var msg: TWMCopyData); message WM_COPYDATA;
    function DoHttpGet(const url: string; const handleRedirects: boolean; const Error_message: string; var Response: string): boolean;
    function DoHttpRequest(data: THttpRequest): boolean;
    procedure InitHttpProperties;
    function HandleWorkerException(data: THttpRequest): boolean;
    procedure InitFramesProperties(const AAction: TAction; const s: string);
    function FormatMoviePosition(const position: double): string; overload;
    function FormatMoviePosition(const frame: longint; const duration: double): string; overload;
  end;


var
  FMain: TFMain;
  CutList: TCutList;
  Settings: TSettings;
  pos_to, pos_from: double;
  vol_temp: integer;
  last_pos: double;


  //Batch flags
  exit_after_commandline, TryCutting: boolean;

  //movie params
  MovieInfo: TMovieInfo;

  //Interfaces
  BasicVideo: IBasicVideo;
  Seeking: IMediaSeeking;
  MediaEvent: IMediaEvent;
  Framestep: IVideoFrameStep;
  VMRWindowlessControl: IVMRWindowlessControl;
  VMRWindowlessControl9: IVMRWindowlessControl9;

implementation
  uses madExcept, madNVBitmap, madNVAssistant, Frames, CutlistRate_Dialog, ResultingTimes, CutlistSearchResults,
    PBOnceOnly, UfrmCutting, UCutApplicationBase, UCutApplicationAsfbin, UCutApplicationMP4Box, UMemoDialog,
    DateTools, UAbout, ULogging, UDSAStorage, IdResourceStrings, CAResources,
    uFreeLocalizer;

{$R *.dfm}
{$WARN SYMBOL_PLATFORM OFF}

function TFMain.FormatMoviePosition(const position: double): string;
begin
  if MovieInfo.frame_duration = 0 then
    Result := FormatMoviePosition(0, 0)
  else
    Result := FormatMoviePosition(Trunc(position / MovieInfo.frame_duration), position)
end;

function TFMain.FormatMoviePosition(const frame: longint; const duration: double): string;
begin
  Result := IntToStr(frame)
          + ' / '
          + MovieInfo.FormatPosition(duration);
end;

procedure TFMain.UpdateMovieInfoControls;
begin
  if not Assigned(MovieInfo) then
    self.lblMovieFPS_nl.Caption := MovieInfo.FormatFrameRate(0, #0)
  else
    self.lblMovieFPS_nl.Caption := MovieInfo.FormatFrameRate;

  if not Assigned(MovieInfo) or not MovieInfo.MovieLoaded then
  begin
    self.lblMovieType_nl.Caption := MovieInfo.GetStringFromMovieType(mtNone);
    self.lblCutApplication_nl.Caption := Format(CAResources.RsCaptionCutApplication, [ CAResources.RsNotAvailable ]);
  end else begin
    self.lblMovieType_nl.Caption := MovieInfo.MovieTypeString;
    self.lblCutApplication_nl.Caption := Format(CAResources.RsCaptionCutApplication, [ Settings.GetCutAppName(MovieInfo.MovieType) ]);
  end;
end;

procedure TFMain.InitFramesProperties(const AAction: TAction; const s: string);
begin
  if not Assigned(AAction) then
    Exit;
  AAction.Caption := AnsiReplaceText(AAction.Caption, '$$', s);
  AAction.Hint    := AnsiReplaceText(AAction.Hint   , '$$', s);
end;

procedure TFMain.cmdSetFromClick(Sender: TObject);
begin
  SetStartPosition(CurrentPosition);
end;

procedure TFMain.cmdSetToClick(Sender: TObject);
begin
  SetStopPosition(CurrentPosition);
end;

procedure TFMain.refresh_times;
begin
  self.edtFrom.Text := MovieInfo.FormatPosition(pos_from);
  self.edtTo.Text := MovieInfo.FormatPosition(pos_to);
  if pos_to >= pos_from then begin
    self.edtDuration.Text := MovieInfo.FormatPosition(pos_to-pos_from);
    self.actAddCut.Enabled := true;
  end else begin
    self.edtDuration.Text := '';
    self.actAddCut.Enabled := false;
  end;
end;

procedure TFMain.FormCreate(Sender: TObject);
var
  numFrames: string;
begin
{
procedure TModalForm.CreateParams(var Params: TCreateParams);
  // override;
begin
  inherited;
  if (Parent <> nil) or (ParentWindow <> 0) then
    Exit;  // must not mess with wndparent if form is embedded

  if Assigned(Owner) and (Owner is TWincontrol) then
    Params.WndParent := TWinControl(Owner).handle
  else if Assigned(Screen.Activeform) then
    Params.WndParent := Screen.Activeform.Handle;
end;
}
  AdjustFormConstraints(self);
  if screen.WorkAreaWidth < self.Constraints.MinWidth then begin
    self.Constraints.MinWidth := screen.Width;
    //self.WindowState := wsMaximized;
  end;
  if screen.WorkAreaHeight < self.Constraints.MinHeight then begin
    self.Constraints.MinHeight := screen.Height;
    //self.WindowState := wsMaximized;
  end;

  if ValidRect(Settings.MainFormBounds) then
    self.BoundsRect := Settings.MainFormBounds
  else
  begin
    self.Top := Screen.WorkAreaTop + Max(0, (Screen.WorkAreaHeight - self.Height) div 2);
    self.Left := Screen.WorkAreaLeft + Max(0, (Screen.WorkAreaWidth - self.Width) div 2);
  end;

  self.WindowState := Settings.MainFormWindowState;
  

  numFrames := IntToStr(Settings.FramesCount);
  InitFramesProperties(self.actNextFrames, numFrames);
  InitFramesProperties(self.actCurrentFrames, numFrames);
  InitFramesProperties(self.actPrevFrames, numFrames);
  InitFramesProperties(self.actScanInterval, numFrames);

  ResetForm;

  DragAcceptFiles(self.Handle, true);
  ExitCode := 0;

  UploadDataEntries := TStringList.Create;
  UploadDataEntries := TStringList.Create;
  if fileexists(UploadData_Path(true)) then
    UploadDataEntries.LoadFromFile(UploadData_Path(true));

  if fileexists(UploadData_Path(false)) then begin
    ConvertUploadData;
  end;

  InitHttpProperties;

  self.rgCutMode.ItemIndex := settings.DefaultCutMode;

  Cutlist.RefreshCallBack := self.refresh_lvCutlist;
  cutlist.RefreshGUI;

  filtergraph.Volume := 5000;
  tbVolume.PageSize := tbVolume.Frequency;
  tbVolume.LineSize := round(tbVolume.PageSize /10);
  tbVolume.Position := filtergraph.Volume;
end;

procedure TFMain.FormDestroy(Sender: TObject);
begin
  Settings.MainFormBounds := self.BoundsRect;
  Settings.MainFormWindowState := self.WindowState;
  FreeAndNIL(UploadDataEntries);
end;

procedure TFMain.cmdFromStartClick(Sender: TObject);
begin
  pos_from := 0;
  refresh_times;
end;

procedure TFMain.cmdToEndClick(Sender: TObject);
begin
  pos_to := MovieInfo.current_file_duration;
  refresh_times;
end;

procedure TFMain.cmdJumpFromClick(Sender: TObject);
begin
  JumpTo(pos_from);
end;

procedure TFMain.cmdJumpToClick(Sender: TObject);
begin
  JumpTo(pos_to);
end;

procedure TFMain.lvCutlistSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  self.enable_del_buttons(true);
end;

procedure TFMain.enable_del_buttons(value: boolean);
begin
  self.actDeleteCut.enabled := value;
  self.actEditCut.Enabled := value;
  self.actReplaceCut.Enabled := value;
end;


function TFMain.StartCutting: boolean;
var
  message_string: string;
  sourcefile, sourceExtension, targetfile, targetpath: string;
  AskForPath: boolean;
  saveDlg: TSaveDialog;
  CutApplication: TCutApplicationBase;
begin
  result := false;
  if cutlist.Count = 0 then begin
    if not batchmode then
      ShowMessage(CAResources.RsNoCutsDefined);
    exit;
  end;

  if settings.CutlistAutoSaveBeforeCutting and cutlist.HasChanged then cutlist.Save(false);

  sourcefile := extractfilename(MovieInfo.current_filename);
  sourceExtension := extractfileext(sourcefile);

  if settings.UseMovieNameSuggestion and (trim(cutlist.SuggestedMovieName) <> '') then
    targetfile := trim(cutlist.SuggestedMovieName) + SourceExtension
  else
    targetfile := changefileExt(sourcefile, Settings.CutMovieExtension + SourceExtension);

  case Settings.SaveCutMovieMode of
    smWithSource: begin    //with source
         targetpath := extractFilePath(MovieInfo.current_filename);
       end;
    smGivenDir: begin    //in given Dir
         targetpath := IncludeTrailingPathDelimiter(Settings.CutMovieSaveDir);
       end;
    else begin       //with source
         targetpath := extractFilePath(MovieInfo.current_filename);
       end;
  end;

  targetfile := CleanFileName(targetfile);
  {// The following is possible only with shell32.dll V 5.0 or higer (WInXp SP2 or higher)
  case PathCleanupSpec(PWideChar(targetPath), PWideChar(targetfile)) of
    PCS_TRUNCATED: begin
        if not batchmode then showmessage('File name for cut movie is too long and will be truncated.');
      end;
    PCS_FATAL: begin
        if not batchmode then showmessage('File name for cut movie is not valid. Abort.');
        exit;
      end;
  end;
  }
  if not ForceDirectories(targetpath) then
  begin
      if not batchmode then
        ShowMessageFmt(CAResources.RsCouldNotCreateTargetPath, [ targetpath ]);
      exit;
  end;

  MovieInfo.target_filename := targetpath + targetfile;

  //Display Save Dialog?
  AskForPath := Settings.MovieNameAlwaysConfirm;

  if fileexists(MovieInfo.target_FileName) AND (NOT AskForPath) and (not batchmode) then begin
    message_string := Format(CAResources.RsTargetMovieAlreadyExists, [ MovieInfo.target_filename ]);
    if Application.MessageBox(PChar(message_string), nil, MB_YESNO + MB_DEFBUTTON2 + MB_ICONWARNING) <> IDYES then AskForPath := true;
  end;
  if AskForPath and (not batchmode) then begin
    saveDlg := TSaveDialog.Create(self);
    saveDlg.Filter := '*' + SourceExtension + '|*' + SourceExtension;
    saveDlg.Title := CAResources.RsSaveCutMovieAs;
    saveDlg.InitialDir := targetpath;
    saveDlg.filename := targetfile;
    saveDlg.options := saveDlg.Options + [ofOverwritePrompt, ofPathMustExist];
    if saveDlg.Execute then begin
      MovieInfo.target_filename := trim(saveDlg.FileName);
      if not ansiSameText(extractFileExt(MovieInfo.target_filename), SourceExtension) then begin
        MovieInfo.target_filename := MovieInfo.target_filename + sourceExtension;
      end;
    end else
      exit;
  end;

  if fileexists(MovieInfo.target_FileName) then begin
    if not deletefile(MovieInfo.target_filename) then begin
      if not batchmode then
        ShowMessageFmt(CAResources.RsCouldNotDeleteFile, [ MovieInfo.target_filename ]);
      exit;
    end;
  end;

  CutApplication := Settings.GetCutApplicationByMovieType(MovieInfo.MovieType);
  if assigned(CutApplication) then begin
    CutApplication.CutAppSettings := Settings.GetCutAppSettingsByMovieType(MovieInfo.MovieType);
    frmCutting.CutApplication := CutApplication;
    result := CutApplication.PrepareCutting(MovieInfo.current_filename, MovieInfo.target_filename, cutlist);
    if result then begin
      case frmCutting.ExecuteCutApp of
        mrOK: result := true;
        else result := false;
      end;
    end;
  end;
end;

procedure TFMain.cbMuteClick(Sender: TObject);
begin
  if CBMUte.Checked then begin
    FilterGraph.Volume := 0;
  end else begin
    FilterGraph.Volume := tbVolume.Position;
  end;

end;

procedure TFMain.tbVolumeChange(Sender: TObject);
begin
  if not CBMute.Checked then
    FilterGraph.Volume := tbVolume.Position;
end;

procedure TFMain.tbFinePosMOuseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  new_pos: double;
begin
  new_pos := currentPosition +  tbFinePos.Position * MovieInfo.frame_duration;
  if new_pos<0 then new_pos := 0;
  if new_pos > MovieInfo.current_file_duration then new_pos := MovieInfo.current_file_duration;
  JumpTo(new_pos);
  tbFinePos.Position := 0;
end;

procedure TFMain.refresh_lvCutlist(cutlist: TCutlist);
var
  icut: integer;
  cut: tcut;
  cut_view : tlistitem;
  i_column: integer;
  total_cutoff, resulting_duration: Double;
begin
  self.lvCutlist.Clear;
  self.actSendRating.Enabled := cutlist.IDOnServer <> '';

  if cutlist.Count = 0 then begin
    self.actStartCutting.Enabled := false;
    self.actCalculateResultingTimes.Enabled := false;
    self.actSaveCutlistAs.Enabled := false;
    self.actSaveCutlist.Enabled := false;
    self.actCutlistUpload.Enabled := false;
    self.actNextCut.Enabled := false;
    self.actPrevCut.Enabled := false;
    self.enable_del_buttons(false);
  end else begin
    self.actStartCutting.Enabled := true;
    self.actCalculateResultingTimes.Enabled := true;
    self.actSaveCutlistAs.Enabled := true;
    self.actSaveCutlist.Enabled := true;
    self.actCutlistUpload.Enabled := true;
    self.actNextCut.Enabled := true;
    self.actPrevCut.Enabled := true;
    for icut := 0 to cutlist.Count-1 do begin
      cut := cutlist[icut];
      cut_view := self.lvCutlist.Items.Add;
      cut_view.Caption := inttostr(icut); //inttostr(cut.index);
      cut_view.SubItems.Add(MovieInfo.FormatPosition(cut.pos_from));
      cut_view.SubItems.Add(MovieInfo.FormatPosition(cut.pos_to));
      cut_view.SubItems.Add(MovieInfo.FormatPosition(cut.pos_to-cut.pos_from + MovieInfo.frame_duration));
    end;

    //Auto-Resize columns
    for i_column := 0 to self.lvCutlist.Columns.Count -1 do begin
      lvCutlist.Columns[i_column].Width := -2;
    end;

    if lvCutlist.ItemIndex = -1 then
      self.enable_del_buttons(false)
    else
      self.enable_del_buttons(true);
  end;

  if cutlist.Mode = clmCutOut then begin
    total_cutoff := cutlist.TotalDurationOfCuts;
    resulting_duration := MovieInfo.current_file_duration - total_cutoff;
  end else begin
    resulting_duration := cutlist.TotalDurationOfCuts;
    total_cutoff := MovieInfo.current_file_duration - resulting_duration;
  end;
  self.lblTotalCutoff_nl.Caption := Format(CAResources.RsCaptionTotalCutoff, [ secondsToTimeString(total_cutoff) ]);
  self.lblResultingDuration_nl.Caption := Format(CAResources.RsCaptionResultingDuration, [ secondsToTimeString(resulting_duration) ]);


  //Cuts in Trackbar are taken from global var "cutlist"!
  self.TBFilePos.Perform(CM_RECREATEWND, 0, 0);    //Show Cuts in Trackbar

  case cutlist.Mode of
    clmCutOut: self.rgCutMode.ItemIndex := 0;
    clmTrim: self.rgCutMode.ItemIndex := 1;
  end;

  if (cutlist.RatingByAuthorPresent and (cutlist.RatingByAuthor <=2))
    or cutlist.EPGError
    or cutlist.MissingBeginning
    or cutlist.MissingEnding
    or cutlist.MissingVideo
    or cutlist.MissingAudio
    or cutlist.OtherError
  then begin
    //self.ACutlistInfo.ImageIndex := 18;
    self.ICutlistWarning.Visible := true;
  end else begin
    //self.ACutlistInfo.ImageIndex := -1;
    self.ICutlistWarning.Visible := false;
  end;

  if cutlist.Author <> '' then begin
    self.lblCutlistAuthor_nl.Caption := cutlist.Author;
    self.pnlAuthor.Visible := true;
  end else begin
    self.pnlAuthor.Visible := false;
  end;;
end;


function TFMain.OpenFile(Filename: String): boolean;
//false if file not found
var
  SourceFilter, AviDecompressorFilter: IBaseFilter;
  SourceAdded: boolean;
  AvailableFilters: TSysDevEnum;
  PinList: TPinList;
  IPin: Integer;
  TempCursor: TCursor;
begin
  result := false;
  if fileexists(filename) then begin
    if MovieInfo.MovieLoaded then begin
      if not self.CloseMovieAndCutlist then exit;;
    end;

    TempCursor := screen.Cursor;
    try
      screen.Cursor := crHourGlass;
      MovieInfo.target_filename := '';
      if not MovieInfo.InitMovie(FileName) then
        exit;

      if MovieInfo.MovieType in [ mtWMV ] then begin
        self.actRepairMovie.Enabled := true;
      end else begin
        self.actRepairMovie.Enabled := false;
      end;

      {if not batchmode then }begin
        SourceAdded := false;

        if MovieInfo.MovieType in [ mtWMV ] then begin
          SampleGrabber.FilterGraph := nil;
        end else begin
          SampleGrabber.FilterGraph := FilterGraph;
        end;

        FilterGraph.Active := true;

        AvailableFilters := TSysDevEnum.Create(CLSID_LegacyAmFilterCategory); //DirectShow Filters
        try
            //If MP4 then Try to Add AviDecompressor
          if (MovieInfo.MovieType in [mtMP4]) then begin
            AviDecompressorFilter := AvailableFilters.GetBaseFilter(CLSID_AVIDec); //Avi Decompressor
            if assigned(AviDecompressorFilter) then begin
              CheckDSError((FilterGraph as IGraphBuilder).AddFilter(AviDecompressorFilter, 'Avi Decompressor'));
            end;
          end;

          If Not (IsEqualGUID(Settings.GetPreferredSourceFilterByMovieType(MovieInfo.MovieType), GUID_NULL)) then begin
            SourceFilter := AvailableFilters.GetBaseFilter(Settings.GetPreferredSourceFilterByMovieType(MovieInfo.MovieType));
            if assigned(SourceFilter) then begin
              CheckDSError((SourceFilter as IFileSourceFilter).Load(StringToOleStr(FileName), nil));
              CheckDSError((FilterGraph as IGraphBuilder).AddFilter(SourceFilter, StringToOleStr('Source Filter [' + extractFileName(FileName) + ']')));
              SourceAdded := true;
            end;
          end;
        finally
          FreeAndNIL(AvailableFilters);
        end;

        if not sourceAdded then begin
          CheckDSError(FilterGraph.RenderFile(FileName));
        end else begin
          PinLIst := TPinLIst.Create(SourceFilter);
          try
            for iPin := 0 to PinList.Count-1 do begin
              CheckDSError((FilterGraph as IGraphBuilder).Render(PinList.Items[iPin]));
            end;
          finally
            FreeAndNIL(PinList);
          end;
        end;

        initVideo;

        if SampleGrabber.FilterGraph = nil then begin
          InsertSampleGrabber;
          if not filtergraph.Active then begin
            if not batchmode then
              ShowMessage(CAResources.RsCouldNotInsertSampleGrabber);
            MovieInfo.current_filename := '';
            MovieInfo.MovieLoaded := false;
            MovieInfo.current_filesize := -1;
            UpdateMovieInfoControls;
            exit;
          end;
        end;
        FilterGraph.Volume := self.tbVolume.Position;

        GraphPause;

        self.pnlVideoWindowResize(self);
      end;

      self.Caption := Application_Friendly_Name + ' ' + extractfilename(MovieInfo.current_filename);
      application.Title := extractfilename(MovieInfo.current_filename);

      MovieInfo.MovieLoaded := true;
      result := true;
    except
      on E: Exception do
        if not batchmode then
          ShowMessageFmt(CAResources.RsErrorOpenMovie, [ E.Message ]);
    end;
    screen.Cursor := TempCursor;
  end else begin
    if not batchmode then
      ShowMessageFmt(CAResources.RsErrorFileNotFound, [ filename ]);
    MovieInfo.current_filename := '';
    MovieInfo.MovieLoaded := false;
  end;
  self.UpdateMovieInfoControls;
end;

procedure TFMain.LoadCutList;
var
  filename, cutlist_path, cutlist_filename: string;
  CutlistMode_old: TCutlistMode;
  newCutlist : TCutlist;
begin
  if MovieInfo.current_filename = '' then begin
    if not batchmode then
      showmessage(CAResources.RsCannotLoadCutlist);
    exit;
  end;

  //Use same settings as for saving as default
  cutlist_filename := ChangeFileExt(extractfilename(MovieInfo.current_filename), cutlist_Extension);
  case Settings.SaveCutlistMode of
    smWithSource: begin    //with source
         cutlist_path := extractFilePath(MovieInfo.current_filename);
       end;
    smGivenDir: begin    //in given Dir
         cutlist_path := IncludeTrailingPathDelimiter(Settings.CutlistSaveDir);
       end;
    else begin       //with source
         cutlist_path := extractFilePath(MovieInfo.current_filename);
       end;
  end;

  odCutlist.InitialDir := cutlist_path;
  odCutlist.FileName := cutlist_filename;
  odCutlist.Options := odCutlist.Options + [ofNoChangeDir];
  if self.odCutlist.Execute then begin
    filename := self.odCutlist.FileName;
    CutlistMode_old := cutlist.Mode;
    cutlist.LoadFromFile(filename);
    if CutlistMode_old <> cutlist.Mode then begin
      newCutlist := cutlist.convert;
      newCutlist.RefreshCallBack := cutlist.RefreshCallBack;
      FreeAndNIL(cutlist);
      cutlist := newCutlist;
      cutlist.RefreshGUI;
    end;
  end;
end;

procedure TFMain.InitVideo;
var
  _ARw, _ARh : integer;
  frame_duration: double;
  _dur_time, _dur_frames: int64;
  APin: IPin;
  MediaType: TAMMediaType;
  pVIH: ^VIDEOINFOHEADER;
  pVIH2: ^VIDEOINFOHEADER2;
  filter: IBaseFilter;
  BasicVIdeo2 : IBasicVideo2;
  arx, ary : integer;
begin
  if FilterGraph.Active then begin
    if succeeded(filtergraph.QueryInterface(IMediaSeeking, Seeking)) then begin
      {if succeeded(seeking.IsFormatSupported(TIME_FORMAT_FRAME)) then begin
        seeking.SetTimeFormat(TIME_FORMAT_FRAME);
      end; }                                   //does not work ???
      seeking.GetTimeFormat(MovieInfo.TimeFormat);
      seeking.GetDuration(_dur_time);
      MovieInfo.current_file_duration := _dur_time;
      if isEqualGUID(MovieInfo.TimeFormat, TIME_FORMAT_MEDIA_TIME) then
        MovieInfo.current_file_duration := MovieInfo.current_file_duration / 10000000;
    end else seeking := nil;

    if succeeded(filtergraph.QueryInterface(IMediaEvent, MediaEvent)) then begin
    end else MediaEvent := nil;

    //detect ratio

    MovieInfo.nat_w := 0;
    MovieInfo.nat_h := 0;
    MovieInfo.ratio := 4/3;

    if succeeded(filtergraph.QueryInterface(IBasicVideo, BasicVideo)) then begin
      BasicVideo.get_VideoWidth(MovieInfo.nat_w);
      BasicVideo.get_VideoHeight(MovieInfo.nat_h);
      if (MovieInfo.nat_w>0) and (MovieInfo.nat_h >0) then
        MovieInfo.ratio := MovieInfo.nat_w / MovieInfo.nat_h;
      if MovieInfo.frame_duration = 0 then
        if Succeeded(BasicVideo.get_AvgTimePerFrame(frame_duration)) then begin
          MovieInfo.frame_duration := frame_duration;
          MovieInfo.frame_duration_source := 'B';
        end;
    end;

    if succeeded(filtergraph.QueryInterface(IBasicVideo2, BasicVideo2)) then begin
      BasicVideo2.GetPreferredAspectRatio(arx, ary);
      if (arx>0) and (ary >0) then
        MovieInfo.ratio := arx/ary;
    end;

    if succeeded(videoWindow.QueryInterface(IVMRWindowlessControl9, VMRWindowlessControl9))then begin
      VMRWindowlessControl9.GetNativeVideoSize(MovieInfo.nat_w, MovieInfo.nat_h, _ARw, _ARh);
      if (MovieInfo.nat_w>0) and (MovieInfo.nat_h >0) then
        MovieInfo.ratio := MovieInfo.nat_W / MovieInfo.nat_h;
    end else begin
      if succeeded(videoWindow.QueryInterface(IVMRWindowlessControl, VMRWindowlessControl))then begin
        VMRWindowlessControl.GetNativeVideoSize(MovieInfo.nat_w, MovieInfo.nat_h, _ARw, _ARh);
      if (MovieInfo.nat_w>0) and (MovieInfo.nat_h >0) then
        MovieInfo.ratio := MovieInfo.nat_W / MovieInfo.nat_h;
      end else begin
        VMRWindowlessControl := nil;
      end;
    end;

    if MovieInfo.frame_duration = 0 then begin
      if succeeded(videowindow.QueryInterface(IBaseFilter, filter)) then  begin
        APin := getInPin(filter, 0);
        APin.ConnectionMediaType(MediaType);
        if isEqualGUID(MediaType.formattype, FORMAT_VideoInfo2) then begin
          if Mediatype.cbFormat >= sizeof(VIDEOINFOHEADER2) then begin
            pVIH2 := mediatype.pbFormat;
            MovieInfo.frame_duration := pVIH2^.AvgTimePerFrame / 10000000;
            MovieInfo.frame_duration_source := 'V';
            //dwFourCC := pVIH2^.bmiHeader.biCompression;
          end;
        end else begin
          if isEqualGUID(MediaType.formattype, FORMAT_VideoInfo) then begin
            if Mediatype.cbFormat >= sizeof(VIDEOINFOHEADER) then begin
              pVIH := mediatype.pbFormat;
              MovieInfo.frame_duration := pVIH^.AvgTimePerFrame / 10000000;
              MovieInfo.frame_duration_source := 'v';
              //dwFourCC := pVIH^.bmiHeader.biCompression;
            end;
          end;
        end;
        // samplegrabber.SetBMPCompatible(@MediaType, 32);
        freeMediaType(@MediaType);
      end
      else if not batchmode then
        showmessage('Could not retrieve Renderer Filter.');
    end;

    if MovieInfo.frame_duration = 0 then begin
      //try calculating
      if succeeded(seeking.IsFormatSupported(TIME_FORMAT_MEDIA_TIME))
      and succeeded(seeking.IsFormatSupported(TIME_FORMAT_FRAME)) then begin
        seeking.SetTimeFormat(TIME_FORMAT_MEDIA_TIME);
        seeking.GetDuration(_dur_time);
        seeking.SetTimeFormat(TIME_FORMAT_FRAME);
        seeking.GetDuration(_dur_frames);
        if (_dur_frames > 0) and (_dur_time <> _dur_frames) then begin
          MovieInfo.frame_duration_source := 'D';
          MovieInfo.frame_duration := (_dur_time / 10000000) / _dur_frames
        end;
        seeking.SetTimeFormat(MovieInfo.TimeFormat)
      end;
    end;

    //default if nothing worked so far
    if MovieInfo.frame_duration = 0 then begin
      MovieInfo.frame_duration_source := 'F';
      MovieInfo.frame_duration := 0.04;
    end;

    self.actOpenCutlist.Enabled := true;
    self.actSearchCutlistByFileSize.Enabled := true;

    self.lblDuration_nl.Caption := FormatMoviePosition(MovieInfo.FrameCount, MovieInfo.current_file_duration);

    MovieInfo.CanStepForward := false;
    if succeeded(FilterGraph.QueryInterface(IVideoFrameStep, FrameStep)) then begin
      if FrameStep.CanStep(0, nil) = S_OK then
        MovieInfo.CanStepForward := true;
    end else FrameStep := nil;
    self.EnableMovieControls(true);
  end;
end;

procedure TFMain.JumpTo(NewPosition: double);
var
  _pos: int64;
  event: Integer;
begin
  if not MovieInfo.MovieLoaded then
    exit;
  if NewPosition < 0 then
    NewPosition := 0;
  if NewPosition > MovieInfo.current_file_duration then
    NewPosition := MovieInfo.current_file_duration;

  if isEqualGUID(MovieInfo.TimeFormat, TIME_FORMAT_MEDIA_TIME) then
    _pos := round(NewPosition * 10000000)
  else
    _pos := round(NewPosition);
  seeking.SetPositions(_pos, AM_SEEKING_AbsolutePositioning,
                       _pos, AM_SEEKING_NoPositioning);
  //filtergraph.State
  MediaEvent.WaitForCompletion(500, event);
  TBFilePos.TriggerTimer;
end;

function TFMain.CurrentPosition: double;
var
  _pos: int64;
begin
{  result := MovieInfo.current_position_seconds;}
  result := 0;
  //if not assigned(seeking) then exit;
  if succeeded(seeking.GetCurrentPosition(_pos)) then begin
    if isEqualGUID(MovieInfo.TimeFormat, TIME_FORMAT_MEDIA_TIME) then
      result := _pos / 10000000
    else
      result := _pos;
  end;
end;

procedure TFMain.tbFilePosTimer(sender: TObject; CurrentPos,
  StopPos: Cardinal);
var
  TrueRate: double;
begin
  TrueRate := CalcTrueRate(self.TBFilePos.TimerInterval / 1000);
  if TrueRate > 0 then
    self.lblTrueRate_nl.Caption := '['+floattostrF(TrueRate, ffFixed, 15, 3) + 'x]'
  else
    self.lblTrueRate_nl.Caption := '[ ? x]';
  self.lblPos_nl.Caption := FormatMoviePosition(currentPosition);
end;

procedure TFMain.tbFilePosChange(Sender: TObject);
begin
  if self.TBFilePos.IsMouseDown then begin
      self.lblPos_nl.Caption := FormatMoviePosition(self.TBFilePos.position);
  end;
end;

procedure TFMain.FilterGraphGraphStepComplete(Sender: TObject);
begin
  self.lblPos_nl.Caption := FormatMoviePosition(currentPosition);
  self.StepComplete := true;
end;

procedure TFMain.tbFilePosPositionChangedByMouse(Sender: TObject);
var
  event: integer;
begin
  MEdiaEvent.WaitForCompletion(500, event);
  self.lblPos_nl.Caption := FormatMoviePosition(currentPosition);
end;

procedure TFMain.tbFinePosChange(Sender: TObject);
begin
  self.lblFinePos_nl.Caption := inttostr(self.tbFinePos.Position);
end;

procedure TFMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  self.CloseMovie;

  DragAcceptFiles(self.Handle, false);
end;

procedure TFMain.SetStartPosition(Position: double);
begin
  pos_from := Position;
  refresh_times;
end;

procedure TFMain.SetStopPosition(Position: double);
begin
  pos_to := Position;
  refresh_times;
end;

procedure TFMain.InsertSampleGrabber;
var
  Rpin, Spin,  TInPin, TOutPin1, TOutPin2, NRInPin, SGInPin, SGOutPin: IPin;
begin

  if not FilterGraph.Active then exit;

  TeeFilter.FilterGraph := Filtergraph;
  SampleGrabber.FilterGraph := filtergraph;
  NullRenderer.FilterGraph := filtergraph;

  try
    //Disconnect Video Window
    OleCheck(GetPin((VideoWindow as IBaseFilter), PINDIR_INPUT, 0,Rpin));
    OleCheck(Rpin.ConnectedTo(Spin));
    OleCheck((FilterGraph as IGraphBuilder).Disconnect(Rpin));
    OleCheck((FilterGraph as IGraphBuilder).Disconnect(Spin));

    //Get Pins
    OleCheck(GetPin((SampleGrabber as IBaseFilter), PINDIR_INPUT, 0, SGInpin));
    OleCheck(GetPin((SampleGrabber as IBaseFilter), PINDIR_OUTPUT, 0, SGOutpin));
    OleCheck(GetPin((NullRenderer as IBaseFilter), PINDIR_INPUT, 0, NRInpin));
    OleCheck(GetPin((TeeFilter as IBaseFilter), PINDIR_INPUT, 0, TInpin));
    OleCheck(GetPin((TeeFilter as IBaseFilter), PINDIR_OUTPUT, 0, TOutpin1));

    //Establish Connections
    OleCheck((FilterGraph as IGraphBuilder).Connect(Spin,Tinpin));  // Decomp. to Tee
    OleCheck((FilterGraph as IGraphBuilder).Connect(Toutpin1,Rpin)); //Tee to VideoRenderer
    OleCheck(GetPin((TeeFilter as IBaseFilter), PINDIR_OUTPUT, 1, TOutpin2)); //GEt new OutputPin of Tee
    OleCheck((FilterGraph as IGraphBuilder).Connect(Toutpin2,SGInpin)); //Tee to SampleGrabber
    OleCheck((FilterGraph as IGraphBuilder).Connect(SGoutpin,NRInpin));  //SampleGrabber to Null

  except
    filtergraph.ClearGraph;
    filtergraph.active := false;
    raise;
  end;
end;

function TFMain.WaitForStep(TimeOut: INteger): boolean;
var
  interval: integer;
  startTick, nowTick, lastTick: Cardinal;
begin
  lastTick := GetTickCount;
  startTick := lastTick;

  if Settings.AutoMuteOnSeek then
    interval := 10
  else
    interval := Max(10, Trunc(MovieInfo.frame_duration * 1000.0));

  while (not self.StepComplete) do begin
    sleep(interval);
    nowTick := GetTickCount;
    if (self.StepComplete) or (Abs(startTick - nowTick) > TimeOut) then
      break;
    application.ProcessMessages;
  end;
  result := self.StepComplete;
end;

procedure TFMain.pnlVideoWindowResize(Sender: TObject);
var
  movie_ar, my_ar: double;
begin
  movie_ar := MovieInfo.ratio;
  my_ar := self.pnlVideoWindow.Width / self.pnlVideoWindow.Height;
  if my_ar > movie_ar then begin
    self.VideoWindow.Height := self.pnlVideoWindow.Height;
    self.VideoWindow.Width := round (self.videowindow.Height * movie_ar);
  end else begin
    self.VideoWindow.Width := self.pnlVideoWindow.Width;
    self.VideoWindow.Height := round(self.VideoWindow.Width / movie_ar);
  end; 
end;

procedure TFMain.ShowFrames(startframe, endframe: Integer);
//startframe, endframe relative to current frame
var
  iImage, count : integer;
  pos, temp_pos: double;
  Target: TCutFrame;
begin
  count := FFrames.Count;
  if endframe < startframe then exit;
  while endframe - startframe + 1 > count do begin
    if -startframe > endframe then
      startframe := startframe+1
    else
      endframe := endframe-1;
  end;

  pos := currentPosition;
  temp_pos := pos + (startframe - 0) * MovieInfo.frame_duration;
  if (temp_pos > MovieInfo.current_file_duration) then
    temp_pos := MovieInfo.current_file_duration;
  if temp_pos<0 then
    temp_pos := 0;

  FFrames.Show;

  JumpTo(temp_pos);
  // Mute sound ?
  if Settings.AutoMuteOnSeek and not CBMute.Checked then
    FilterGraph.Volume := 0;
  FFrames.CanClose := false;
  try
    for iImage := 0 to endframe - startframe do begin
      Target := FFrames.Frame[iImage];
      if (temp_pos >= 0) and (temp_pos <= MovieInfo.current_file_duration) then begin

        self.StepComplete := false;
        Target.DisableUpdate;
        try
          SampleTarget := Target;  //Set SampleTarget to trigger sampleGrabber.onbuffer method;
          if Assigned(Framestep) then begin
            if not Succeeded(FrameStep.Step(1, nil)) then
              break;
            if not WaitForStep(5000) then
              break;
          end else begin
            temp_pos := temp_pos + MovieInfo.frame_duration;
            JumpTo(temp_pos);
            WaitForFiltergraph;
          end;

          temp_pos := currentPosition;
          Target.image.visible := true;
        finally
          Target.EnableUpdate;
        end;
      end else begin
        Target.image.visible := false;
        Target.position := 0;
      end;
    end;
  finally
    FFrames.CanClose := true;
    // Restore sound
    if Settings.AutoMuteOnSeek and not CBMute.Checked then
      FilterGraph.Volume := tbVolume.Position;
    JumpTo(pos);
  end;
end;

procedure TFMain.ShowFramesAbs(startframe, endframe: double;
  numberOfFrames: Integer);
//starframe, endframe: absolute position.
var
  iImage : integer;
//  counter: integer;
  pos, temp_pos, distance: double;
  Target: TCutFrame;
begin
  if endframe <= startframe then exit;
  startframe := ensureRange(startframe, 0, MovieInfo.current_file_duration);
  endframe := ensureRange(endframe, 0, MovieInfo.current_file_duration-MovieInfo.frame_duration);

  numberOfFrames := FFrames.Count;
  distance := (endframe - startframe) / (numberofFrames-1);

  FilterGraph.Pause;
  WaitForFiltergraph;

  pos := currentPosition;
  FFrames.Show;

  // Mute sound ?
  if Settings.AutoMuteOnSeek and not CBMute.Checked then
    FilterGraph.Volume := 0;
  FFrames.CanClose := false;

  try
    for iImage := 0 to numberOfFrames-1 do begin
      Target := FFrames.Frame[iImage];
      temp_pos := startframe + (iImage * distance);
      if (temp_pos >= 0) and (temp_pos <= MovieInfo.current_file_duration) then
      begin
        SampleTarget := Target; //set sampleTarget to trigger samplegrabber.onbuffer method
        JumpTo(temp_pos);
        WaitForFiltergraph;

        Target.image.visible := true;
      end else begin
        Target.image.visible := false;
        Target.position := 0;
      end;
    end;
  finally
    FFrames.CanClose := true;
    // Restore sound
    if Settings.AutoMuteOnSeek and not CBMute.Checked then
      FilterGraph.Volume := tbVolume.Position;
    JumpTo(pos);
  end;
end;

procedure TFMain.WaitForFilterGraph;
var
  pfs : TFilterState;
  hr : hresult;
begin
     repeat
       hr := (FilterGraph as IMediaControl).GetState(50, pfs);
     until (hr = S_OK) or (hr = E_FAIL);
end;

procedure TFMain.cmdConvertClick(Sender: TObject);
var
  newCutlist: TCutlist;
begin
  if cutlist.Count = 0 then exit;
  newCutlist := cutlist.convert;
  newCutlist.RefreshCallBack := cutlist.RefreshCallBack;
  FreeAndNIL(cutlist);
  cutlist := newCutlist;
  cutlist.RefreshGUI;
end;

procedure TFMain.ShowMetaData;
const
  stream = $0;
var
  HeaderInfo : IWMHeaderInfo;
  _text: string;
  value: packed array of byte;
  _name: array of WideChar;
  name_len, attr_len: word;
  iFilter, iAttr, iByte: integer;
  found : boolean;
  filterlist: TFilterlist;
  sourceFilter: IBaseFilter;
  attr_datatype: wmt_attr_datatype;
  CAttributes: word;
  _stream: word;
begin
  if (MovieInfo.current_filename = '')  or (not MovieInfo.MovieLoaded) then exit;

  frmMemoDialog.Caption := CAResources.RsTitleMovieMetaData;
  with frmMemoDialog.memInfo do begin
    Clear;
    Lines.Add(Format(CAResources.RsMovieMetaDataMovietype , [ MovieInfo.MovieTypeString ]));
    Lines.Add(Format(CAResources.RsMovieMetaDataCutApplication , [ Settings.GetCutAppName(MovieInfo.MovieType) ]));
    Lines.Add(Format(CAResources.RsMovieMetaDataFilename , [ MovieInfo.current_filename ]));
    Lines.Add(Format(CAResources.RsMovieMetaDataFrameRate , [ FloatToStrF(1/MovieInfo.frame_duration, ffFixed, 15, 4) ]));

    if MovieInfo.MovieType in [mtAVI, mtHQAvi] then
      Lines.Add(Format(CAResources.RsMovieMetaDataVideoFourCC , [ fcc2string(MovieInfo.FFourCC) ]));

    if MovieInfo.MovieType in [ mtWMV ] then begin
      filterlist := tfilterlist.Create;
      filterlist.Assign(filtergraph as IFiltergraph);
      found := false;
      for iFilter := 0 to filterlist.Count-1 do begin
        if string(filterlist.FilterInfo[iFilter].achName) = MovieInfo.current_filename then begin
          sourcefilter := filterlist.Items[iFilter];
          found := true;
          break;
        end;
      end;
      if found then begin
        try
          //   wmcreateeditor
          //   (FIltergraph as IFiltergraph).FindFilterByName(pwidechar(current_filename), sourceFilter);
          //   (sourceFIlter as iammediacontent).get_AuthorName(pwidechar(author));
          if succeeded(sourcefilter.QueryInterface(IwmHeaderInfo, HEaderINfo)) then begin
            HeaderInfo := (sourceFilter as IwmHeaderInfo);
            HeaderInfo.GetAttributeCount(stream, CAttributes);
            _stream := stream;
            for iAttr := 0 to CAttributes-1 do begin
              HeaderInfo.GetAttributeByIndex(iAttr, _stream, nil, name_len, attr_datatype, nil, attr_len);
              setlength(_name, name_len);
              setlength(value, attr_len);
              HeaderInfo.GetAttributeByIndex(iAttr, _stream, pwidechar(_name), name_len, attr_datatype, PByte(value), attr_len);
              case attr_datatype of
                WMT_TYPE_STRING: _text := WideChartoString(PWideChar(value));
                WMT_TYPE_WORD: begin
                    _text := inttostr(word(PWord(addr(value[0]))^));
                  end;
                WMT_TYPE_DWORD: begin
                    _text := intTostr(dword(PDWord(addr(value[0]))^));
                  end;
                WMT_TYPE_QWORD: begin
                     _text := intTostr(int64(PULargeInteger(addr(value[0]))^));
                  end;
                WMT_TYPE_BOOL: begin
                    if LongBool(PDword(addr(value[0]))^) then _text := 'true' else _text := 'false';
                  end;
                WMT_TYPE_BINARY: begin
                    _text := #13#10;
                    for iByte := 0 to attr_len-1 do begin
                      _text := _text + inttohex(value[iByte],2)+' ';
                      if iByte mod 8 = 7 then _text := _text + ' ';
                      if iByte mod 16 = 15 then _text := _text + #13#10;
                    end;
                  end;
                WMT_TYPE_GUID: begin
                    _text := GuidToString(PGUID(value[0])^);
                  end;
                else _text := CAResources.RsMovieMetaDataUnknownDataFormat;
              end;
              Lines.Add(Format('%s: %s', [ WideCharToString(PWidechar(_name)), _text ]));
            end;
          end;
        finally
          FreeAndNIL(filterlist);
        end;
      end else begin
        Lines.Add(CAResources.RsMovieMetaDataNoInterface);
        FreeAndNIL(filterlist);
      end;
    end;
  end;
  frmMemoDialog.ShowModal;
end;

procedure TFMain.tbFilePosSelChanged(Sender: TObject);
begin
  with FFrames do begin
    if scan_1 <> -1 then begin
      frame[scan_1].BorderVisible := false;
      scan_1 := -1;
    end;
    if scan_2 <> -1 then begin
      frame[scan_2].BorderVisible := false;
      scan_2 := -1;
    end;
  end;
  if self.TBFilePos.SelEnd-self.TBFilePos.SelStart > 0 then
    actScanInterval.Enabled := true
  else
    actScanInterval.Enabled := false;
end;

procedure TFMain.WMDropFiles(var message: TWMDropFiles);
var
  iFile, cFiles: uInt;
  FileName: array [0..255] of Char;
  FileList: TStringList;
  FileString: String;
begin
  FileList := TStringList.Create;
  try
    cFiles:=DragQueryFile(message.Drop, $FFFFFFFF, nil, 0);
    for iFile := 1 to cFiles do begin
      DragQueryFile(message.Drop, iFile-1, @FileName, uint(sizeof(FileName)));
      filestring := string(FileName);
      FileList.add(fileString);
    end;
    ProcessFileList(FileList, false);
  finally
    FreeAndNIL(FileList);
  end;
  inherited;
end;

procedure TFMain.ProcessFileList(FileList: TStringList; IsMyOwnCommandLine: boolean);
var
  iString: INteger;
  Pstring, filename_movie, filename_cutlist, filename_upload_cutlist: string;
  upload_cutlist, found_movie, found_cutlist, get_empty_cutlist: boolean;
  //try_cutlist_download: boolean;
begin
  found_movie := false;
  found_cutlist := false;
  upload_cutlist := false;
  //try_cutlist_download := false;
  Batchmode := false;
  TryCutting := false;
  get_empty_cutlist := false;
  for iString := 0 to FileList.Count-1 do begin
    Pstring := FileList[iString];
    if AnsiStartsStr('-uploadcutlist:', ansilowercase(PString)) then begin
      filename_upload_cutlist := AnsiMidStr(PString, 16, length(Pstring)-15);
      upload_cutlist := true;
    end;
    if AnsiStartsStr('-getemptycutlist:', ansilowercase(PString)) and (not found_cutlist) then begin
      filename_cutlist := AnsiMidStr(PString, 18, length(Pstring)-17);
      found_cutlist := true;
      get_empty_cutlist := true;
    end;
    if AnsiStartsStr('-exit', ansilowercase(PString)) then begin
      if IsMyOwnCommandLine then exit_after_commandline:= true;
    end;
    if AnsiStartsStr('-open:', ansilowercase(PString)) and (not found_movie) then begin
      filename_movie := AnsiMidStr(PString, 7, length(Pstring)-6);
      if fileexists(filename_movie) then found_movie := true;
    end;
    if AnsiStartsStr('-batchmode', ansilowercase(PString)) then begin
      if IsMyOwnCommandLine then Batchmode := true;
    end;
    if AnsiStartsStr('-trycutting', ansilowercase(PString)) then begin
      TryCutting := true;
    end;
{    if AnsiStartsStr('-trycutlistdownload', ansilowercase(PString)) and (not found_cutlist) then begin
      found_cutlist := true;
      try_cutlist_download := true;
    end; }
    if AnsiStartsStr('-cutlist:', ansilowercase(PString)) and (not found_cutlist) then begin
      filename_cutlist := AnsiMidStr(PString, 10, length(Pstring)-9);
      if fileexists(filename_cutlist) then found_cutlist := true;
    end;
    if fileexists(Pstring) then begin
      if ansilowercase(extractfileext(Pstring)) = cutlist_Extension then begin
        if not found_cutlist then begin
          filename_cutlist := pstring;
          found_cutlist := true;
        end;
      end else begin
        if not found_movie then begin
          filename_movie := pstring;
          found_movie := true;
        end;
      end;
    end;
  end;

  if upload_cutlist then begin
    if not UploadCutlist(filename_upload_cutlist) then ExitCode := 64
  end;

  if found_movie then begin
    if not openfile(filename_movie) then
      if IsMyOwnCommandLine then ExitCode := 1;
  end;

  if get_empty_cutlist then begin
    if IsMyOwnCommandLine then ExitCode := 32;
    if cutlist.EditInfo then begin
      if cutlist.SaveAs(filename_cutlist) then begin
        ExitCode := 0;
        exit;
      end;
    end;
  end;

  if found_cutlist then begin
    if MovieInfo.MovieLoaded then begin
      {if try_cutlist_download then begin
        if not self.search_cutlist then begin
          if IsMyOwnCommandLine then ExitCode := 2;
          exit;
        end;
      end else begin }
        cutlist.LoadFromFile(filename_cutlist);
      {end;}
    end else begin
      if not batchmode then
        showmessage(CAResources.RsCannotLoadCutlist);
    end;
  end;

  if TryCutting then begin
    if MovieInfo.current_filename <>'' then begin
      if not StartCutting then
        if IsMyOwnCommandLine then ExitCode := 128;
    end;
  end;
end;

procedure TFMain.actSaveCutlistAsExecute(Sender: TObject);
begin
    if cutlist.Save(true) then
      if not batchmode then
        ShowMessageFmt(CAResources.RsCutlistSavedAs, [ cutlist.SavedToFilename ]);
end;

procedure TFMain.actOpenMovieExecute(Sender: TObject);
var
  OpenDialog: TOpenDialog;
  ExtList, ExtListAllSupported: string;
  procedure AppendFilterString(const description: string; const extensions: string); overload;
  var
    filter: string;
  begin
    filter := MakeFilterString(description, extensions);
    if OpenDialog.Filter <> '' then
      OpenDialog.Filter := OpenDialog.Filter + '|' + filter
    else
      OpenDialog.Filter := filter
  end;
  procedure AppendFilterString(const description: string; const ExtArray: array of string); overload;
  begin
    ExtList := FilterStringFromExtArray(ExtArray);
    AppendFilterString(description, ExtList);
    if ExtListAllSupported <> '' then
      ExtListAllSupported := ExtListAllSupported + ';' + ExtList
    else
      ExtListAllSupported := ExtList;
  end;
begin
  //if not AskForUserRating(cutlist) then exit;
  //if not cutlist.clear_after_confirm then exit;

  OpenDialog := TOpenDialog.Create(self);
  try
    OpenDialog.Options := OpenDialog.Options + [ofPathMustExist, ofFileMustExist];
    ExtListAllSupported := '';
    OpenDialog.Filter := '';

    // Make Filter List
    AppendFilterString(CAResources.RsFilterDescriptionWmv, WMV_EXTENSIONS);
    AppendFilterString(CAResources.RsFilterDescriptionAvi, AVI_EXTENSIONS);
    AppendFilterString(CAResources.RsFilterDescriptionMp4, MP4_EXTENSIONS);
    AppendFilterString(CAResources.RsFilterDescriptionAll, '*.*');
    OpenDialog.Filter := MakeFilterString(CAResources.RsFilterDescriptionAllSupported, ExtListAllSupported)+
                         '|' + OpenDialog.Filter;

    OpenDialog.InitialDir := settings.CurrentMovieDir;
    if OpenDialog.Execute then begin
      settings.CurrentMovieDir := ExtractFilePath(openDialog.FileName);
      OpenFile(opendialog.FileName);
    end;
  finally
    FreeAndNil(OpenDialog);
  end;

end;

procedure TFMain.actOpenCutlistExecute(Sender: TObject);
begin
  LoadCutlist;
end;

procedure TFMain.actFileExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TFMain.actAddCutExecute(Sender: TObject);
begin
  if cutlist.AddCut(pos_from, pos_to) then begin
    pos_from := 0;
    pos_to := 0;
    refresh_times;
  end;
end;

procedure TFMain.actReplaceCutExecute(Sender: TObject);
var
  dcut: integer;
begin
  if self.lvCutlist.SelCount = 0 then begin
    self.enable_del_buttons(false);
    exit;
  end;
  dcut := strtoint(self.lvCutlist.Selected.caption);
  cutlist.ReplaceCut(pos_from, pos_to, dCut);
end;

procedure TFMain.actEditCutExecute(Sender: TObject);
var
  dcut: integer;
begin
  if self.lvCutlist.SelCount = 0 then begin
    self.enable_del_buttons(false);
    exit;
  end;
  dcut := strtoint(self.lvCutlist.Selected.caption);
  pos_from := cutlist[dcut].pos_from;
  pos_to := cutlist[dcut].pos_to;
  refresh_times;
end;

procedure TFMain.actDeleteCutExecute(Sender: TObject);
begin
  if self.lvCutlist.SelCount = 0 then begin
    self.enable_del_buttons(false);
    exit;
  end;
  cutlist.DeleteCut(strtoint(self.lvCutlist.Selected.caption));
end;

procedure TFMain.actShowFramesFormExecute(Sender: TObject);
begin
  FFrames.Show;
end;

procedure TFMain.actNextFramesExecute(Sender: TObject);
var
  c: TCursor;
begin
  if not MovieInfo.MovieLoaded then
    exit;
  c := self.Cursor;
  try
    EnableMovieControls(false);
    self.Cursor := crHourGlass;
    application.ProcessMessages;
    showframes(1, FFrames.Count);
  finally
    EnableMovieControls(true);
    self.Cursor := c;
  end;
end;

procedure TFMain.actCurrentFramesExecute(Sender: TObject);
var
  c: TCursor;
  halfFrames: integer;
begin
  if not MovieInfo.MovieLoaded then
    exit;
  c := self.Cursor;
  try
    EnableMovieControls(false);
    self.Cursor := crHourGlass;
    application.ProcessMessages;
    halfFrames := 1 + FFrames.Count div 2;
    showframes(1 - halfFrames, FFrames.Count - halfFrames);
  finally
    EnableMovieControls(true);
    self.Cursor := c;
  end;
end;

procedure TFMain.actPrevFramesExecute(Sender: TObject);
var
  c: TCursor;
begin
  if not MovieInfo.MovieLoaded then
    exit;
  c := self.Cursor;
  try
    EnableMovieControls(false);
    self.Cursor := crHourGlass;
    application.ProcessMessages;
    showframes(-1*FFrames.Count, -1);
  finally
    EnableMovieControls(true);
    self.Cursor := c;
  end;
end;

procedure TFMain.actScanIntervalExecute(Sender: TObject);
var
  i1, i2: integer;
  pos1, pos2: double;
  c: TCursor;
begin
  if not MovieInfo.MovieLoaded then
    exit;
  i1 := FFrames.scan_1;
  i2 := FFrames.scan_2;

  if (i1 = -1) or (i2 =-1) then begin
    pos1 := self.TBFilePos.SelStart;
    pos2 := self.TBFilePos.SelEnd;
  end else begin
    if i1>i2 then begin
      i1 := i2;
      i2 := FFrames.scan_1;
    end;
    pos1 := FFrames.Frame[i1].position;
    FFrames.Frame[i1].BorderVisible := false;
    pos2 := FFrames.Frame[i2].position;
    FFrames.Frame[i2].BorderVisible := false;
  end;

  c := self.Cursor;
  self.Cursor := crHourGlass;
  try
    EnableMovieControls(false);
    self.actScanInterval.Enabled := false;
    Application.ProcessMessages;

    showframesabs(pos1, pos2, FFrames.Count);
  finally
    EnableMovieControls(true);
    self.actScanInterval.Enabled := true;
    self.Cursor := c;
  end;
end;

procedure TFMain.actEditSettingsExecute(Sender: TObject);
begin
  settings.edit;
  InitHttpProperties;
end;

procedure TFMain.actStartCuttingExecute(Sender: TObject);
begin
  StartCutting;
end;

procedure TFMain.actMovieMetaDataExecute(Sender: TObject);
begin
  ShowMetaData;
end;

procedure TFMain.actUsedFiltersExecute(Sender: TObject);
begin
  FManageFilters.SourceGraph := FilterGraph;
  FManageFilters.ShowModal;
end;

procedure TFMain.actAboutExecute(Sender: TObject);
begin
  AboutBox.ShowModal();
end;

procedure ForceOpenRegKey(const reg: TRegistry; const key: string);
var
  path: string;
begin
  if not reg.OpenKey(key, true) then begin
    if AnsiStartsStr('\', key) then path := key
    else path := reg.CurrentPath + '\' + key;

    raise ERegistryException.CreateResFmt(@CAResources.RsExUnableToOpenKey, [ path ]);
  end;
end;

procedure TFMain.actWriteToRegistyExecute(Sender: TObject);
var
  reg : TRegistry;
  myDir: string;
begin
  myDir := application.ExeName;
  reg := Tregistry.Create;
  try
   try
    reg.RootKey := HKEY_CLASSES_ROOT;
    ForceOpenRegKey(reg, '\' + cutlist_Extension);
    reg.WriteString('', CutlistID);
    reg.WriteString('Content Type', CUTLIST_CONTENT_TYPE);
    reg.CloseKey;

    ForceOpenRegKey(reg, '\'+CutlistID);
    reg.WriteString('', CAResources.RsRegDescCutlist);
    ForceOpenRegKey(reg, 'DefaultIcon');
    reg.WriteString('', '"' + myDir+'",0');
    reg.CloseKey;

    ForceOpenRegKey(reg, '\'+CutlistID+'\Shell\open');
    reg.WriteString('', CAResources.RsRegDescCutlistOpen);
    ForceOpenRegKey(reg, 'command');
    reg.WriteString('', '"' + myDir + '" -cutlist:"%1"');
    reg.CloseKey;

    ForceOpenRegKey(reg, '\WMVFile\Shell\' + ShellEditKey);
    reg.WriteString('', CAResources.RsRegDescMovieOpen);
    ForceOpenRegKey(reg, 'command');
    reg.WriteString('', '"' + myDir + '" -open:"%1"');
    reg.CloseKey;

    ForceOpenRegKey(reg, '\AVIFile\Shell\' + ShellEditKey);
    reg.WriteString('', CAResources.RsRegDescMovieOpen);
    ForceOpenRegKey(reg, 'command');
    reg.WriteString('', '"' + myDir + '" -open:"%1"');
    reg.CloseKey;

    ForceOpenRegKey(reg, '\QuickTime.mp4\Shell\' + ShellEditKey);
    reg.WriteString('', CAResources.RsRegDescMovieOpen);
    ForceOpenRegKey(reg, 'command');
    reg.WriteString('', '"' + myDir + '" -open:"%1"');
    reg.CloseKey;

    ForceOpenRegKey(reg, '\Applications\' + ProgID + '\shell\open');
    reg.WriteString('FriendlyAppName', 'Cut Assistant');
    ForceOpenRegKey(reg, 'command');
    reg.WriteString('', '"' + myDir + '" -open:"%1"');
    reg.CloseKey;
   finally
    FreeAndNIL(reg);
   end;
  except
    on ERegistryException do
      ShowExpectedException(CAResources.RsErrorRegisteringApplication);
  end;
end;

procedure TFMain.actRemoveRegistryEntriesExecute(Sender: TObject);
var
  reg : TRegistry;
  myDir: string;
begin
  myDir := application.ExeName;
  reg := Tregistry.Create;
  try
   try
    reg.RootKey := HKEY_CLASSES_ROOT;
    if reg.OpenKey('\WMVFile\Shell', false) then begin
      reg.DeleteKey(ShellEditKey);
      reg.CloseKey;
    end;

    if reg.OpenKey('\AVIFile\Shell', false) then begin
      reg.DeleteKey(ShellEditKey);
      reg.CloseKey;
    end;

    if reg.OpenKey('\QuickTime.mp4\Shell', false) then begin
      reg.DeleteKey(ShellEditKey);
      reg.CloseKey;
    end;

    if reg.OpenKey('\Applications', false) then begin
      reg.DeleteKey(ProgID);
      reg.CloseKey;
    end;

    reg.DeleteKey('\'+cutlist_Extension);
    reg.DeleteKey('\'+CutlistID);
   finally
     FreeAndNIL(reg);
   end;
  except
    on ERegistryException do
      ShowExpectedException(CAResources.RsErrorUnRegisteringApplication);
  end;
end;

procedure TFMain.rgCutModeClick(Sender: TObject);
begin
  case self.rgCutMode.ItemIndex of
    0: cutlist.Mode := clmCutOut;
    1: cutlist.Mode := clmTrim;
  end;
end;

procedure TFMain.actCutlistUploadExecute(Sender: TObject);
var
  message_String: string;
begin
  if cutlist.HasChanged then begin
    if not cutlist.Save(false) then exit; //try to save it
  end;

	if not fileexists(cutlist.SavedToFilename) then exit;

  message_string := Format(CAResources.RsMsgUploadCutlist, [ cutlist.SavedToFilename, settings.url_cutlists_upload]);
  if not (application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONINFORMATION) = IDYES) then begin
    exit;
  end;

  UploadCutlist(cutlist.SavedToFilename);
end;

procedure TFMain.actStepForwardExecute(Sender: TObject);
var
  event: integer;
begin
  if FilterGraph.State <> gsPaused then GraphPause;
  if assigned(FrameStep) then begin
    if Settings.AutoMuteOnSeek and not CBMute.Checked then
      FilterGraph.Volume := 0;
    FrameStep.Step(1, nil);
    MediaEvent.WaitForCompletion(500, event);
    TBFilePos.TriggerTimer;
    if Settings.AutoMuteOnSeek and not CBMute.Checked then
      FilterGraph.Volume := tbVolume.Position;
  end else
  begin
    self.actStepForward.Enabled := false;
  end;
end;

procedure TFMain.actStepBackwardExecute(Sender: TObject);
var
  timeToSkip: double;
begin
  if FilterGraph.State <> gsPaused then GraphPause;

  if Sender = actLargeSkipBackward then
    timeToSkip := Settings.LargeSkipTime
  else if Sender = actSmallSkipBackward then
    timeToSkip := Settings.SmallSkipTime
  else if Sender = actLargeSkipForward then
    timeToSkip := -Settings.LargeSkipTime
  else if Sender = actSmallSkipForward then
    timeToSkip := -Settings.SmallSkipTime
  else
    timeToSkip := MovieInfo.frame_duration;

  JumpTo(currentPosition - timeToSkip);
end;

procedure TFMain.actBrowseWWWHelpExecute(Sender: TObject);
begin
    ShellExecute(0, nil, PChar(settings.url_help), '', '', SW_SHOWNORMAL);
end;

procedure TFMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  done: boolean;
begin
  done := false;
  if Shift = [ ] then
    case key of
      ord('K'), ord(' '), VK_MEDIA_PLAY_PAUSE:
          done := actPlayPause.Execute;
      VK_MEDIA_STOP:
          done := actStop.Execute;
      VK_MEDIA_NEXT_TRACK:
          done := actNextCut.Execute;
      VK_MEDIA_PREV_TRACK:
          done := actPrevCut.Execute;
      VK_BROWSER_BACK:
          done := actStepBackward.Execute;
      VK_BROWSER_FORWARD:
          done := actStepForward.Execute;
  end;
  if done then
    Key := 0;
end;

procedure TFMain.AppCommandAppCommand(Handle: Cardinal; Cmd: Word;
  Device: TJvAppCommandDevice; KeyState: Word; var Handled: Boolean);
begin
  case Cmd of // Force Handled for specific commands ...
    APPCOMMAND_BROWSER_BACKWARD:
      Handled := actStepBackward.Execute or true;
    APPCOMMAND_BROWSER_FORWARD:
      Handled := actStepForward.Execute or true;
    APPCOMMAND_MEDIA_PLAY_PAUSE:
      Handled := actPlayPause.Execute or true;
    APPCOMMAND_MEDIA_STOP:
      Handled := actStop.Execute or true;
    APPCOMMAND_MEDIA_NEXTTRACK:
      Handled := actNextCut.Execute or true;
    APPCOMMAND_MEDIA_PREVIOUSTRACK:
      Handled := actPrevCut.Execute or true;
  end;
end;


procedure TFMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  message_string: string;
begin
  if cutlist.HasChanged then begin
    message_string := CAResources.RsMsgSaveChangedCutlist;
    case application.messagebox(PChar(message_string), PChar(CAResources.RsTitleSaveChangedCutlist), MB_YESNOCANCEL + MB_DEFBUTTON3 + MB_ICONQUESTION) of
      IDYES: begin
          CanClose := cutlist.Save(false);      //Can Close if saved successfully
        end;
      IDNO: begin
          CanClose := true;
        end;
      else begin
          CanClose := false;
        end;
    end;
  end;
end;

procedure TFMain.actOpenCutlistHomeExecute(Sender: TObject);
begin
  ShellExecute(0, nil, PChar(settings.url_cutlists_home), '', '', SW_SHOWNORMAL);
end;

procedure TFMain.CloseMovie;
begin
  if filtergraph.Active then begin
    filtergraph.Stop;
    filtergraph.Active := false;
    filtergraph.ClearGraph;
    SampleGrabber.FilterGraph := nil;
    TeeFilter.FilterGraph := nil;
    NullRenderer.FilterGraph := nil;
//    AviDecompressor.FilterGraph := nil;
  end;
  MovieInfo.current_filename := '';
  MovieInfo.current_filesize := -1;
  MovieInfo.MovieLoaded := false;
  if Assigned(FFrames) then begin
    FFrames.HideFrames;
  end;

  ResetForm;
end;

function TFMain.RepairMovie: boolean;
var
  filename_temp, file_ext, filename_damaged,
  command, AppPath, message_string: string;
  exitCode: DWord;
  selectFileDlg: TOpenDialog;
  CutApplication: TCutApplicationAsfbin;
begin
  result := false;
  if not (movieinfo.MovieType in [ mtWMV ]) then exit;

  CutApplication := Settings.GetCutApplicationByName('Asfbin') as TCutApplicationAsfbin;
  if not assigned (CutApplication) then begin
    if not batchmode then
      ShowMessage(CAResources.RsCutAppAsfBinNotFound);
    exit;
  end;

  if MovieInfo.current_filename = '' then begin
    selectFileDlg := TOpenDialog.Create(self);
    selectFileDlg.Filter := CAResources.RsFilterDescriptionAsf+'|*.wmv;*.asf|'+CAResources.RsFilterDescriptionAll+'|*.*';
    selectFileDlg.Options := selectFileDlg.Options + [ofPathMustExist, ofFileMustExist, ofNoChangeDir];
    selectFileDlg.Title := CAResources.RsTitleRepairMovie;
    if selectFileDlg.Execute then begin
      filename_temp := selectFileDlg.FileName;
      FreeAndNIL(selectFileDlg);
    end else begin
      FreeAndNIL(selectFileDlg);
      exit;
    end;
  end else begin
    filename_temp := MovieInfo.current_filename;
  end;

  file_ext := extractfileExt(filename_temp);
  filename_damaged := changeFileExt(filename_temp, '.damaged' + file_ext);

  message_string := Format(CAResources.RsMsgRepairMovie, [ extractFileName(CutApplication.Path), filename_damaged ]);
  if not (application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONINFORMATION) = IDYES) then begin
    exit;
  end;

  CloseMovie;

  if not renameFile(filename_temp, filename_damaged) then begin
    if not batchmode then
      ShowMessage(CAResources.RsMsgRepairMovieRenameFailed);
    exit;
  end;

  command := '-i "' + filename_damaged + '" -o "' + filename_temp + '"';
  AppPath := '"' + CutApplication.Path + '"';
  try
    result := STO_ShellExecute(AppPath, Command, INFINITE, false, exitCode);
  finally
{    if ExitCode > 0 then begin
      showmessage('Could not repair file. ExitCode = ' + inttostr(ExitCode));
      result := false;
    end;      }
    if not result then begin
      renameFile(filename_damaged, filename_temp);
    end;

    if result then begin
      if (application.messagebox(PChar(CAResources.RsMsgRepairMovieFinished), nil, MB_YESNO + MB_ICONINFORMATION) = IDYES) then begin
        self.OpenFile(filename_temp);
      end;
    end;
  end;
end;

procedure TFMain.actRepairMovieExecute(Sender: TObject);
begin
  self.RepairMovie;
end;

procedure TFMain.actCutlistInfoExecute(Sender: TObject);
begin
  cutlist.EditInfo;
end;

procedure TFMain.actSaveCutlistExecute(Sender: TObject);
begin
  if cutlist.Save(false) then
    if not batchmode then
      ShowMessageFmt(CAResources.RsCutlistSavedAs, [ cutlist.SavedToFilename ]);
end;

procedure TFMain.actCalculateResultingTimesExecute(Sender: TObject);
var
  selectFileDlg: TOpenDialog;
  AskForPath: boolean;
begin
  AskForPath := Settings.MovieNameAlwaysConfirm
             or not FileExists(MovieInfo.target_filename)
             or (MovieInfo.target_filename = '');
  if not BatchMode and AskForPath then begin
    selectFileDlg := TOpenDialog.Create(self);
    try
      selectFileDlg.Filter := MakeFilterString(CAResources.RsFilterDescriptionAllSupported,
                                FilterStringFromExtArray(WMV_EXTENSIONS)+';'+
                                FilterStringFromExtArray(AVI_EXTENSIONS)+';'+
                                FilterStringFromExtArray(MP4_EXTENSIONS))
                              +'|'+MakeFilterString(CAResources.RsFilterDescriptionAll,'*.*');

      selectFileDlg.Options := selectFileDlg.Options + [ofPathMustExist, ofFileMustExist, ofNoChangeDir];
      selectFileDlg.Title := CAResources.RsTitleCheckCutMovie;
      if MovieInfo.target_filename = '' then begin
        selectFileDlg.InitialDir := settings.CutMovieSaveDir;
      end else begin
        selectFileDlg.InitialDir := ExtractFileDir(MovieInfo.target_filename);
        selectFileDlg.FileName := MovieInfo.target_filename;
      end;
      if selectFileDlg.Execute then
        MovieInfo.target_filename := selectFileDlg.FileName
      else
        Exit;
    finally
      FreeAndNIL(selectFileDlg);
    end;
  end;

  if not fileexists(MovieInfo.target_filename) then begin
    if not batchmode then
      showmessage(CAResources.RsErrorMovieNotFound);
    Exit;
  end;

  try
    if not FResultingTimes.loadMovie(MovieInfo.target_filename) then begin
      if not batchmode then
        showmessage(CAResources.RsErrorCouldNotLoadMovie);
      exit;
    end;
    FResultingTimes.calculate(cutlist);
    FResultingTimes.Show;
  except
    on E: Exception do
      if not batchmode then
        ShowMessageFmt(CAResources.RsErrorCouldNotLoadCutMovie, [ E.Message ]);
  end;
end;

procedure TFMain.actAsfbinInfoExecute(Sender: TObject);
var
  info: string;
  CutApplication: TCutApplicationBase;
begin
  info := '';

  CutApplication := Settings.GetCutApplicationByMovieType(mtWMV);
  if assigned(CutApplication) then begin
    info := info + CAResources.RsCutApplicationWmv + #13#10;
    info := info + CutApplication.InfoString + #13#10;
  end;

  CutApplication := Settings.GetCutApplicationByMovieType(mtAVI);
  if assigned(CutApplication) then begin
    info := info + CAResources.RsCutApplicationAvi + #13#10;
    info := info + CutApplication.InfoString + #13#10;
  end;

  CutApplication := Settings.GetCutApplicationByMovieType(mtHQAVI);
  if assigned(CutApplication) then begin
    info := info + CAResources.RsCutApplicationHqAvi + #13#10;
    info := info + CutApplication.InfoString + #13#10;
  end;

  CutApplication := Settings.GetCutApplicationByMovieType(mtMP4);
  if assigned(CutApplication) then begin
    info := info + CAResources.RsCutApplicationMp4 + #13#10;
    info := info + CutApplication.InfoString + #13#10;
  end;

  CutApplication := Settings.GetCutApplicationByMovieType(mtUnknown);
  if assigned(CutApplication) then begin
    info := info + CAResources.RsCutApplicationOther + #13#10;
    info := info + CutApplication.InfoString + #13#10;
  end;

  frmMemoDialog.Caption := CAResources.RsTitleCutApplicationSettings;
  frmMemoDialog.memInfo.Clear;
  frmMemoDialog.memInfo.Text := info;
  frmMemoDialog.ShowModal;
end;

function TFMain.SearchCutlistsByFileSize_XML: boolean;
const
  php_name = 'getxml.php';
  command = '?ofsb=';
var
  url, error_message: string;
  Response: string;
  Node, CutNode: TJCLSimpleXMLElems;
  idx: integer;
begin
  result := false;
  if (MovieInfo.current_filesize = 0) or (MovieInfo.current_filename = '') then
    exit;
  Error_message := CAResources.RsErrorUnknown;

  url := settings.url_cutlists_home + php_name + command + inttostr(MovieInfo.current_filesize) +'&version=' + Application_Version;
  Result := DoHttpGet(url, false, error_message, Response);

    try
      if result and (Length(response) > 5) then begin
          XMLResponse.LoadFromString(Response);
          FCutlistSearchResults.lvLinklist.Clear;

          if XMLResponse.Root.ChildsCount > 0 then begin
            Node := XMLResponse.Root.Items;
            for idx := 0 to node.Count - 1 do begin
              CutNode := node.Item[idx].Items;
              with FCutlistSearchResults.lvLinklist.Items.Add do begin
                Caption := CutNode.ItemNamed['id'].Value;
                SubItems.Add(CutNode.ItemNamed['name'].Value);
                SubItems.Add(CutNode.ItemNamed['rating'].Value);
                SubItems.Add(CutNode.ItemNamed['ratingcount'].Value);
                SubItems.Add(CutNode.ItemNamed['ratingbyauthor'].Value);
                SubItems.Add(CutNode.ItemNamed['author'].Value);
                SubItems.Add(CutNode.ItemNamed['usercomment'].Value);
                SubItems.Add(CutNode.ItemNamed['actualcontent'].Value);
              end;
            end;
          end;

          if FCutlistSearchResults.ShowModal = mrOK then begin
            result := self.DownloadCutlistByID(FCutlistSearchResults.lvLinklist.Selected.Caption, FCutlistSearchResults.lvLinklist.Selected.SubItems[0]);
            if result then begin
              cutlist.IDOnServer :=  FCutlistSearchResults.lvLinklist.Selected.Caption;
              cutlist.RatingOnServer := StrToFloatDef(FCutlistSearchResults.lvLinklist.Selected.SubItems[1], -1);
              self.actSendRating.Enabled := true;
            end;
          end;
      end else begin
        if not batchmode then
          showmessage(CAResources.RsMsgSearchCutlistNoneFound);
      end;
    except
    on E: EJclSimpleXMLError do begin
        if not batchmode then
          ShowMessageFmt(CAresources.RsErrorSearchCutlistXml, [ E.Message ]);
      end;
    end;
end;

procedure TFMain.actSearchCutlistByFileSizeExecute(Sender: TObject);
begin
  self.SearchCutlistsByFileSize_XML;
end;

function TFMain.SendRating(Cutlist: TCutlist): boolean;
const
  php_name = 'rate.php';
  command = '?rate=';
var
  Response, Error_message, url: string;
begin
  result := false;
  if cutlist.IDOnServer = '' then begin
    actSendRating.Enabled := false;
    if not batchmode then
      Showmessage(CAResources.RsMsgSendRatingNotPossible);
    exit;
  end else begin
    if (cutlist.RatingOnServer >= 0.0) and cutlist.RatingByAuthorPresent then
      FCutlistRate.SelectedRating := Round(cutlist.RatingByAuthor + cutlist.RatingOnServer)
    else if cutlist.RatingOnServer >= 0.0 then
      FCutlistRate.SelectedRating := Round(cutlist.RatingOnServer)
    else if cutlist.RatingByAuthorPresent then
      FCutlistRate.SelectedRating := cutlist.RatingByAuthor
    else
      FCutlistRate.SelectedRating := -1;
    if FCutlistRate.ShowModal = mrOK then
    begin
      Error_message := CAResources.RsErrorUnknown;
      url := settings.url_cutlists_home
           + php_name + command +cutlist.IDOnServer
           +'&rating=' + inttostr(FCutlistRate.SelectedRating)
           +'&userid=' + settings.UserID
           +'&version=' + Application_Version;
      Result := DoHttpGet(url, true, Error_message, Response);

      if result then begin
        if AnsiContainsText(Response, '<html>') then begin
          cutlist.RatingSent := true;
          if not batchmode then
            showmessage (CAResources.RsMsgSendRatingDone);
        end else begin
          if not batchmode then
            ShowMessageFmt(CAResources.RsMsgAnswerFromServer, [ LeftStr(response, 255) ]);
        end;
      end;
    end;
  end;
end;

procedure TFMain.actSendRatingExecute(Sender: TObject);
begin
  self.SendRating(cutlist);
end;

procedure TFMain.SampleGrabberBuffer(sender: TObject; SampleTime: Double;
  pBuffer: Pointer; BufferLen: Integer);
var
  Target: TCutFrame;
  //TargetBitmap: TBitmap;
begin
  if SampleTarget = nil then exit;
  Target := (SampleTarget as TCutFrame);
  try
    //SampleGrabber.GetBitmap(Target.Image.Picture.Bitmap, pBuffer, BufferLen);
    self.CustomGetSampleGrabberBitmap(Target.Image.Picture.Bitmap, pBuffer, BufferLen);
    Target.position := SampleTime;
  finally
    SampleTarget := nil;
  end;
end;

procedure TFMain.lvCutlistDblClick(Sender: TObject);
begin
  self.actEditCut.Execute;
end;

function TFMain.UploadCutlist(filename: string): boolean;
var
  Request: THttpRequest;
  Response, Answer: string;
  Cutlist_id: Integer;
  lines: TStringList;
  begin_answer: integer;
begin
  result := false;

  if fileexists(filename) then begin
    Request := THttpRequest.Create(
                  settings.url_cutlists_upload,
                  true,
                  CAResources.RsErrorUploadCutlist);
    Request.IsPostRequest := true;
    try
      with Request.PostData do
      begin
        AddFormField('MAX_FILE_SIZE','1587200');
        AddFormField('confirm','true');
        AddFormField('type','blank');
        AddFormField('userid', settings.UserID);
        AddFormField('version', application_version);
        AddFile('userfile[]',filename, 'multipart/form-data');
      end;
      Result := DoHttpRequest(Request);
      Response := Request.Response;

      lines := TStringList.Create;
      try
        lines.Delimiter := #10;
        lines.NameValueSeparator := '=';
        lines.DelimitedText := Response;
        if TryStrToInt(lines.values['id'], Cutlist_id) then begin
          AddUploadDataEntry(Now, extractFileName(filename), Cutlist_id);
          UploadDataEntries.SaveToFile(UploadData_Path(true));
        end;
        begin_answer := LastDelimiter(#10, response)+1;
        Answer := midstr(response, begin_answer, length(response)-begin_answer+1); //Last Line
      finally
        FreeAndNIL(lines);
      end;
      if not batchmode then
        ShowMessageFmt(CAResources.RsMsgAnswerFromServer, [ answer ]);
    finally
      FreeAndNil(Request);
    end;
  end;
end;

procedure TFMain.actDeleteCutlistFromServerExecute(Sender: TObject);
var
  datestring: string;
  idx: integer;
  entry: string;
  function NextField(var s:string; const d: Char):string;
  begin
    Result := '';
    while (s <> '') do begin
      if s[1] = d then begin
        Delete(s, 1, 1);
        Break;
      end;
      Result := Result + s[1];
      Delete(s, 1, 1);
    end;
  end;
begin
  if FUploadList.Visible then
    exit;
  //Fill ListView
  FUploadList.lvLinklist.Clear;
  for idx := 0 to UploadDataEntries.Count - 1 do begin
    entry := Copy(UploadDataEntries.Strings[idx],1,MaxInt);
    with FUploadList.lvLinklist.Items.Add do begin
      Caption := NextField(entry, '=');
      SubItems.Add(NextField(entry, ';'));
      dateTimeToString(DateString, 'ddddd tt', StrToFloat(NextField(entry, ';')));
      SubItems.Add(DateString);
    end;
  end;

  //Show Dialog and delete cutlist
  if (FUploadList.ShowModal = mrOK) and (FUploadList.lvLinklist.SelCount = 1) then begin
    if self.DeleteCutlistFromServer(FUploadList.lvLinklist.Selected.Caption) then begin
      //Success, so delete Record in upload list
      UploadDataEntries.Delete(FUploadList.lvLinklist.ItemIndex);
      UploadDataEntries.SaveToFile(UploadData_Path(true));
    end;
  end;
end;

function TFMain.DeleteCutlistFromServer(const cutlist_id: string): boolean;
const
  php_name = 'delete_cutlist.php';
var
  url, Response, Error_message, val: string;
  fileRemoved, entryRemoved: boolean;
  lines: TStringList;
begin
  result := false;
  if cutlist_id='' then exit;

  Error_message := CAResources.RsErrorUnknown;
  url := settings.url_cutlists_home + php_name + '?'
       + 'cutlistid=' + cutlist_id
       + '&userid=' + settings.UserID
       + '&version=' + Application_Version;

  Result := DoHttpGet(url, true, Error_message, Response);

  if Result and (response<>'') then begin
    lines := TStringList.Create;
    try
      lines.Delimiter := #10;
      lines.NameValueSeparator := '=';
      lines.DelimitedText := Response;
      val := lines.Values['RemovedFile'];

      if val = '' then
      begin
        Result := false;
        if not batchmode then
          ShowMessage(CAResources.RsMsgCutlistDeleteUnexpected);
      end
      else
      begin
        fileRemoved := val = '1';
        entryRemoved := lines.Values['removedentry'] = '1';

        Result := fileRemoved and entryRemoved;

        if not batchmode then
          ShowMessageFmt('%s'#13#10'%s', [
            IfThen(fileRemoved, CAResources.RsMsgCutlistDeleteEntryRemoved, CAResources.RsMsgCutlistDeleteEntryNotRemoved),
            IfThen(entryRemoved, CAResources.RsMsgCutlistDeleteFileRemoved, CAResources.RsMsgCutlistDeleteFileNotRemoved)
          ]);
      end;
    finally
      FreeAndNil(lines);
    end;
  end;
end;

procedure TFMain.tbFilePosChannelPostPaint(Sender: TDSTrackBarEx;
  const ARect: TRect);
var
  scale: double;
  iCut: INteger;
  CutRect: TRect;
begin
  if MovieInfo.current_file_duration = 0 then exit;
  if cutlist.Mode = clmTrim then
    TBFilePos.ChannelCanvas.Brush.Color := clgreen
  else
    TBFilePos.ChannelCanvas.Brush.Color := clred;
  scale := (ARect.Right - ARect.Left) / MovieInfo.current_file_duration; //pixel per second
  CutRect := ARect;
  for iCut := 0 to cutlist.Count-1 do begin
    CutRect.Left := ARect.Left + round(Cutlist[iCut].pos_from * scale);
    CutRect.Right := ARect.Left + round(Cutlist[iCut].pos_to * scale);
    if CutRect.right >= CutRect.Left then
      TBFilePos.ChannelCanvas.FillRect(CutRect);
  end;
end;

function TFMain.AskForUserRating(Cutlist: TCutlist): boolean;
//true = user rated or decided not to rate, or no rating necessary
//false = abort operation
var
  userIsAuthor: boolean;
begin
  result := false;
  userIsAuthor := Cutlist.Author = settings.UserName;
  if (Cutlist.UserShouldSendRating) and not userIsAuthor then begin
    case (application.MessageBox(PChar(CAResources.RsMsgAskUserForRating), nil, MB_YESNOCANCEL + MB_ICONQUESTION)) of
      IDYES: begin
          result := self.SendRating(Cutlist);
        end;
      IDNO: result := true;
    end;
  end else result := true;
end;

procedure TFMain.WMCopyData(var msg: TWMCopyData);
begin
  HandleSendCommandline(msg.CopyDataStruct^, HandleParameter);
end;

procedure TFMain.AddUploadDataEntry(CutlistDate: TDateTime; CutlistName: string; CutlistID: Integer);
begin
  UploadDataEntries.Add(Format('%d=%s;%f', [ CutlistID, CutlistName, CutlistDate ]));
end;

procedure TFMain.HandleParameter(const param: string);
var
  FileList: TStringLIst;
begin
  FileList := TStringList.Create;
  try
    FileList.Text := param;
    self.ProcessFileList(FileList, false);
  finally
    FreeAndNIL(FileList);
  end;
end;

function TFMain.GraphPlayPause: boolean;
begin
  if filtergraph.State = gsPlaying then begin
    result := GraphPause;
  end else begin
    result := GraphPlay;
  end;
end;

function TFMain.GraphPause: boolean;
begin
  if FilterGraph.State = gsPaused then Result := true
  else Result := FilterGraph.Pause;
  if Result then begin
    self.cmdFF.Enabled := false;
    TBFilePos.TriggerTimer;
  end;
end;

function TFMain.GraphPlay: boolean;
begin
  if FilterGraph.State = gsPlaying then Result := true
  else Result := FilterGraph.Play;
  if result then begin
    self.cmdFF.Enabled := true;
    TBFilePos.TriggerTimer;
  end;
end;

procedure TFMain.VideoWindowClick(Sender: TObject);
begin
  if self.actPlayPause.Enabled then
    self.actPlayPause.Execute;
end;

procedure TFMain.tbRateChange(Sender: TObject);
var
  NewRate: double;
begin
  NewRate := Power(2, (TBRate.Position / 8));
  filtergraph.Rate := newRate;

  lblCurrentRate_nl.Caption :=  floattostrF(filtergraph.Rate, ffFixed, 15, 3) + 'x' ;
end;

function TFMain.CalcTrueRate(Interval: double): double;
//Interval: Interval since last call to CalcTrue Rate (same unit as current_position)
var
  pos, diff: double;
begin
  result := 0;
  if interval <= 0 then exit;

  pos := self.CurrentPosition;
  diff := pos - last_pos;
  last_pos := pos;
  if diff > 0 then
    result := diff / Interval;
end;

procedure TFMain.lblCurrentRate_nlDblClick(Sender: TObject);
begin
  TBRate.Position := 0;
end;

procedure TFMain.actNextCutExecute(Sender: TObject);
var
  NewPos: double;
begin
  NewPos := cutlist.NextCutPos(currentPosition + MovieInfo.frame_duration);
  if NewPos >= 0 then jumpTo(NewPos);
end;

procedure TFMain.actPrevCutExecute(Sender: TObject);
var
  NewPos: double;
begin
  NewPos := cutlist.PreviousCutPos(currentPosition - MovieInfo.frame_duration);
  if NewPos >= 0 then jumpTo(NewPos);
end;

procedure TFMain.cmdFFMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  self.FF_Start;
end;

procedure TFMain.FF_Start;
begin
  filtergraph.Rate := filtergraph.Rate * 2;
end;

procedure TFMain.FF_Stop;
begin
  self.TBRateChange(self);
end;

procedure TFMain.cmdFFMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  self.FF_Stop;
end;

procedure TFMain.VideoWindowDblClick(Sender: TObject);
begin
  ToggleFullScreen;
end;

function TFMain.ToggleFullScreen: boolean;
//returns true if mode is now fullscreen
begin
  if MovieInfo.MovieLoaded then self.VideoWindow.FullScreen := not self.VideoWindow.FullScreen;
  result := self.VideoWindow.FullScreen;
end;

procedure TFMain.actFullScreenExecute(Sender: TObject);
begin
  self.actFullScreen.Checked := ToggleFullScreen;
end;

procedure TFMain.VideoWindowKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and self.VideoWindow.FullScreen then begin
    self.actFullScreenExecute(Sender);
  end;
end;

procedure TFMain.actCloseMovieExecute(Sender: TObject);
begin
  self.CloseMovieAndCutlist;
end;

function TFMain.CloseMovieAndCutlist: boolean;
begin
  result := false;
  if not AskForUserRating(cutlist) then exit;
  if not cutlist.clear_after_confirm then exit;
  if movieInfo.MovieLoaded then CloseMovie;
  result := true;
end;

function TFMain.DownloadCutlistByID(cutlist_id, TargetFileName: string): boolean;
const
  php_name = 'getfile.php';
  Command = '?id=';
var
  Cutlist_File: TextFile;
  message_string, error_message, Response: string;
  url, target_file, cutlist_path: string;
begin
  result := false;
  case Settings.SaveCutlistMode of
    smWithSource: begin    //with source
         cutlist_path := extractFilePath(MovieInfo.current_filename);
       end;
    smGivenDir: begin    //in given Dir
         cutlist_path := includeTrailingBackslash(Settings.CutlistSaveDir);
       end;
    else begin       //with source
         cutlist_path := extractFilePath(MovieInfo.current_filename);
       end;
  end;
  target_file := cutlist_path + TargetFileName;

  if cutlist.HasChanged and (not batchmode) then begin
    message_string := Format(CAResources.RsDownloadCutlistWarnChanged, [ TargetFileName, cutlist_id ]);
    if not (application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONINFORMATION) = IDYES) then begin
      exit;
    end;
  end;

  Error_message := CAResources.RsErrorUnknown;
  url := settings.url_cutlists_home + php_name + command + cleanurl(cutlist_id);

  if not DoHttpGet(url, false, error_message, Response) then
  begin
    if not batchmode then
    begin
      message_string := Error_message + #13#10 + CAResources.RsMsgOpenHomepage;
      if (application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONQUESTION) = IDYES) then
      begin
        ShellExecute(0, nil, PChar(settings.url_cutlists_home), '', '', SW_SHOWNORMAL);
      end;
    end;
  end else
  begin
    if (Length(Response) < 5) then
    begin
      if not batchmode then
        ShowMessageFmt(CAResources.RsDownloadCutlistInvalidData, [ Length(Response) ]);
      Exit;
    end;
    if not ForceDirectories(cutlist_path) then
    begin
      if not batchmode then
        ShowMessageFmt(CAResources.RsErrorCreatePathFailedAbort, [ cutlist_path ]);
      exit;
    end;
    if fileexists(target_file) then
    begin
      if not batchmode then
      begin
        message_string := Format(CAResources.RsWarnTargetExistsOverwrite, [ target_file ]);
        if not (application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONQUESTION) = IDYES) then
        begin
          exit;
        end;
      end;
      if not DeleteFile(target_file) then
      begin
        if not batchmode then
          ShowMessageFmt(CAResources.RsErrorDeleteFileFailedAbort, [ target_file ]);
        exit;
      end;
    end;

    AssignFile(Cutlist_File, target_file);
    Rewrite(Cutlist_File);
    try
      Write(Cutlist_File, Response);
    finally
      CloseFile(Cutlist_File);
    end;
    cutlist.LoadFromFile(target_file);
    Result := true;
  end;
end;

function TFMain.ConvertUploadData: boolean;
var
  RowDataNode, RowNode: TJCLSimpleXMLElem;
  idx, cntNew: integer;
  CutlistID: integer;
  CutlistDate: TDateTime;
  CutlistIDStr, CutlistName, CutlistDateStr: string;
begin
  Result := false;
  if not FileExists(UploadData_Path(false)) then
    Exit;

  cntNew := 0;

  XMLResponse.LoadFromFile(UploadData_Path(false));
  try
    RowDataNode := XMLResponse.Root.Items.ItemNamed['ROWDATA'];
    if RowDataNode <> nil then begin
      for idx := 0 to RowDataNode.Items.Count - 1 do begin
        RowNode := RowDataNode.Items.Item[idx];
        if RowNode <> nil then begin
          CutlistIDStr := RowNode.Properties.Value('id', '0');
          CutlistID := StrToIntDef(CutlistIDStr, 0);
          CutlistName := RowNode.Properties.Value('name', '');
          CutlistDateStr := RowNode.Properties.Value('DateTime', '');
          if Length(CutlistDateStr) > 9 then begin
            CutlistDate := DateTimeStrEval('YYYYMMDDTHH:NN:SSZZZ', CutlistDateStr);
          end
          else begin
            CutlistDate := DateTimeStrEval('YYYYMMDD', CutlistDateStr);
          end;
          if (CutlistID > 0) and (UploadDataEntries.IndexOfName(CutlistIDStr) < 0) then begin
            AddUploadDataEntry(CutlistDate, CutlistName, CutlistID);
            Inc(cntNew);
          end;
        end;
      end;
    end;
    if cntNew > 0 then begin
      UploadDataEntries.SaveToFile(UploadData_Path(true));
    end;
    if FileExists(UploadData_Path(false)) then begin
      RenameFile(UploadData_Path(false), UploadData_Path(false) + '.BAK');
    end;
  except
  on E: EJclSimpleXMLError do begin
      if not batchmode then
        ShowMessageFmt(CAResources.RsErrorConvertUploadData, [ E.Message ]);
    end;
  end;
end;

function GetXMLMessage(const Node: TJCLSimpleXMLElem; const ItemName: string; const LastChecked: TDateTime) : string;
var
  Msg: TJCLSimpleXMLElems;
  datum: TDateTime;
  function ItemStr(const AName: string): string;
  var Item: TJCLSimpleXMLElem;
  begin
    Item := Msg.ItemNamed[AName];
    if Item = nil then Result := ''
    else Result := Item.Value;
  end;
  function ItemInt(const AName: string): integer;
  begin
    Result := StrToIntDef(ItemStr(AName), -1);
  end;
begin
  Result := '';
  Msg := Node.Items;
  if not TryEncodeDate(
    ItemInt('date_year'),ItemInt('date_month'), ItemInt('date_day'),
    Datum
  ) then exit;
  if LastChecked <= Datum then begin
    Result := '[' + DateToStr(Datum) + '] ' + ItemStr(ItemName);
  end;
end;

function GetXMLMessages(const Node: TJCLSimpleXMLElem; const LastChecked: TDateTime; const name: string) : string;
var
  MsgList: TJCLSimpleXMLElems;
  s: string;
  idx:integer;
begin
  Result := '';
  MsgList := Node.Items.ItemNamed[name].Items;
  if MsgList.Count > 0 then begin
    for idx := 0 to MsgList.Count - 1 do begin
      s := GetXMLMessage(MsgList.Item[idx], 'text', LastChecked);
      if Length(s) > 0 then begin
        Result := Result + #13#10#13#10 + s;
      end;
    end;
  end;
end;

function TFMain.DownloadInfo(settings: TSettings; const UseDate, ShowAll: boolean): boolean;
var
  error_message, url, AText, ResponseText: string;
  lastChecked : TDateTime;
  //f: textFile;
begin
  result := false;
  lastChecked := settings.InfoLastChecked;
  if UseDate then
    if not (daysBetween(lastChecked, SysUtils.Date) >= settings.InfoCheckInterval) then
      exit;
  if ShowAll then
    lastChecked := 0;

  Error_message := CAResources.RsErrorUnknown;
  url := settings.url_info_file;

  Error_message := CAResources.RsErrorDownloadInfo;
  Result := DoHttpGet(url, false, Error_message, ResponseText);

  if Result then begin
    try
      if Length(ResponseText) > 5 then begin
        XMLResponse.LoadFromString(ResponseText);

        if XMLResponse.Root.ChildsCount > 0 then begin
          if settings.InfoShowMessages then begin
            AText := GetXMLMessages(XMLResponse.Root, lastChecked, 'messages');
            if Length(AText) > 0 then
              if not batchmode then
                ShowMessageFmt(CAResources.RsMsgInfoMessage, [ AText ]);
          end;
          if settings.InfoShowBeta then begin
            AText := GetXMLMessage(XMLResponse.Root.Items.ItemNamed['beta'], 'version_text', lastChecked);
            if Length(AText) > 0 then
              if not batchmode then
                ShowMessageFmt(CAResources.RsMsgInfoDevelopment, [ AText ]);
          end;
          if settings.InfoShowStable then begin
            AText := GetXMLMessage(XMLResponse.Root.Items.ItemNamed['stable'], 'version_text', lastChecked);
            if Length(AText) > 0 then
              if not batchmode then
                ShowMessageFmt(CAResources.RsMsgInfoStable, [ AText ]);
          end;
          Result := true;
        end;
      end;
      settings.InfoLastChecked := sysutils.Date;
    except
      on E: EJclSimpleXMLError do begin
        if not batchmode then
          ShowMessageFmt(CAResources.RsErrorDownloadInfoXml, [ error_message, E.Message ]);
      end;
      else begin
        raise;
      end;
    end;
  end;
end;

procedure TFMain.actSnapshotCopyExecute(Sender: TObject);
var
  tempBitmap: TBitmap;
  tempCutFrame: TCutFrame;
begin
  if mnuVideo.PopupComponent = VideoWindow then begin
    if not assigned(seeking) then exit;
    //tempBitmap := TBitmap.Create;
    tempCutFrame := TCutFrame.create(nil);
    try
      sampleTarget := tempCutFrame;
      tempBitmap := tempCutFrame.Image.Picture.Bitmap;
//      sampleTarget := tempBitmap;
      jumpto(currentPosition);
      WaitForFiltergraph;
      ClipBoard.Assign(tempBitmap);
    finally
      //FreeAndNIL(tempBitmap);
      FreeAndNIL(tempCutFrame);
    end;
  end;
  if mnuVideo.PopupComponent is TImage then begin
    clipboard.Assign((mnuVideo.PopupComponent as TImage).Picture.Bitmap);
  end;
end;

procedure TFMain.actSnapshotSaveExecute(Sender: TObject);
const
  BMP_EXTENSION = '.bmp';
  JPG_EXTENSION = '.jpg';

  function AskForFileName(var FileName: string; var FileType: Integer): boolean;
  var
    saveDlg: TSaveDialog;
    DefaultExt: string;
  begin
    result := false;
    saveDlg := TSaveDialog.Create(Application.MainForm);
    try
      saveDlg.Filter := MakeFilterString(CAResources.RsFilterDescriptionBitmap, '*'+BMP_EXTENSION) + '|'
                      + MakeFilterString(CAResources.RsFilterDescriptionJpeg, '*'+JPG_EXTENSION) + '|'
                      + MakeFilterString(CAResources.RsFilterDescriptionAll, '*.*');
      saveDlg.FilterIndex := 2;
      saveDlg.Title := CAResources.RsTitleSaveSnapshot;
      //saveDlg.InitialDir := '';
      saveDlg.filename := fileName;
      saveDlg.options := saveDlg.Options + [ofOverwritePrompt, ofPathMustExist];
      if saveDlg.Execute then begin
        result := true;
        FileName := saveDlg.FileName;
        FileType := saveDlg.FilterIndex;
        case FileType of
          1: begin
               DefaultExt := BMP_EXTENSION;
             end;
          else begin
            FileType := 2;
            DefaultExt := JPG_EXTENSION;
          end;
        end;
        if extractFileExt(FileName) <> DefaultExt then FileName := FileName + DefaultExt;
      end;
    finally
      FreeAndNIL(saveDlg);
    end;
  end;

var
  tempBitmap: TBitmap;
  tempCutFrame: TCutFrame;
  posString,
  fileName: string;
  FileType: Integer;
begin
  if filtergraph.State = gsPlaying then GraphPause;

  if mnuVideo.PopupComponent  = VideoWindow then begin
    if not assigned(seeking) then exit;

    //tempBitmap := TBitmap.Create;
    tempCutFrame := TCutFrame.create(nil);
    try
      //sampleTarget := tempBitmap;
      sampleTarget := tempCutFrame;
      tempBitmap := tempCutFrame.Image.Picture.Bitmap;
      jumpto(currentPosition);
      WaitForFiltergraph;

      posString := movieInfo.FormatPosition(tempCutFrame.position);
      posString := ansireplacetext(posString, ':', '''');
      fileName := extractfilename(MovieInfo.current_filename);
      fileName := changeFileExt(fileName, '_' + cleanFileName(posString));

      if not AskForFileName(FileName, FileType) then exit;

      if FileType = 1 then begin
        TempBitmap.SaveToFile(FileName);
      end else begin
        SaveBitmapAsJPEG(TempBitmap, FileName);
      end;
    finally
      //FreeAndNIL(tempBitmap);
      FreeAndNIL(tempCutFrame);
    end;
  end;

  if mnuVideo.PopupComponent is TImage then begin
    posString := MovieInfo.FormatPosition((mnuVideo.PopupComponent.Owner as TCutFrame).position);
    posString := ansireplacetext(posString, ':', '''');
    fileName := extractfilename(MovieInfo.current_filename);
    fileName := changeFileExt(fileName, '_' + cleanFileName(posString));
    if not AskForFileName(FileName, FileType) then exit;

    TempBitmap := (mnuVideo.PopupComponent as TImage).Picture.Bitmap;
    if FileType = 1 then begin
      TempBitmap.SaveToFile(FileName);
    end else begin
      SaveBitmapAsJPEG(TempBitmap, FileName);
    end;
  end;
end;

function TFMain.CreateMPlayerEDL(cutlist: TCutlist; Inputfile,
  Outputfile: String; var scriptfile: string): boolean;
const
  EDL_EXTENSION = '.edl';
var
  f: Textfile;
  i: integer;
  cutlist_tmp: TCutlist;
begin
  if scriptfile = '' then
    scriptfile := Inputfile + EDL_EXTENSION;
  assignfile(f, scriptfile);
  rewrite(f);
  try
    if cutlist.Mode = clmCutOut then begin
      cutlist.sort;
      for i := 0 to cutlist.Count - 1 do begin
        writeln(f, FloatToStrInvariant(cutlist.Cut[i].pos_from)  + ' ' + FloatToStrInvariant(cutlist.Cut[i].pos_to) + ' 0');
      end;
    end else begin
      cutlist_tmp := cutlist.convert;
      for i := 0 to cutlist_tmp.Count - 1 do begin
        writeln(f, FloatToStrInvariant(cutlist_tmp.Cut[i].pos_from)  + ' ' + FloatToStrInvariant(cutlist_tmp.Cut[i].pos_to) + ' 0');
      end;
      FreeAndNIL(cutlist_tmp);
    end;
  finally
    closefile(f);
  end;
  result := true;
end;

procedure TFMain.actPlayInMPlayerAndSkipExecute(Sender: TObject);
var
  edlfile, AppPath, command, message_string: string;
begin
  edlfile := '';
  if not MovieInfo.MovieLoaded then exit;
  AppPath := settings.MplayerPath;
  if not fileexists(AppPath) then exit;
  command := MovieInfo.current_filename;
  if cutlist.count > 0 then begin
    if not self.CreateMPlayerEDL(cutlist, MovieInfo.current_filename, '', edlfile) then exit;
    command := command + ' -edl ' + edlfile;
  end;
  if not CallApplication(AppPath, Command, message_string) then begin
    if not batchmode then
      ShowMessageFmt(CAResources.RsErrorExternalCall, [ extractFilename(AppPath), message_string ]);
  end;
end;

procedure TFMain.ResetForm;
begin
  pos_from := 0;
  pos_to := 0;

  self.Caption := Application_Friendly_Name;
  application.Title := Application_Friendly_Name;

  self.actOpenCutlist.Enabled := false;
  self.actSearchCutlistByFileSize.Enabled := false;
  self.EnableMovieControls(false);
  self.actStepForward.Enabled := false;

  self.lblDuration_nl.Caption := FormatMoviePosition(0);
  self.UpdateMovieInfoControls;
end;

procedure TFMain.EnableMovieControls(value: boolean);
begin
    self.actNextFrames.Enabled := value;
    self.actCurrentFrames.Enabled := value;
    self.actPrevFrames.Enabled := value;
    self.TBFilePos.Enabled := value;
    self.tbFinePos.Enabled := value;
    self.actSmallSkipForward.Enabled := value;
    self.actLargeSkipForward.Enabled := value;
    self.actStepBackward.Enabled := value;
    self.actSmallSkipBackward.Enabled := value;
    self.actLargeSkipBackward.Enabled := value;
    self.actPlayPause.Enabled := value;
    self.actPlay.Enabled := value;
    self.actPause.Enabled := value;
    self.actStop.Enabled:= value;
    if value and MovieInfo.CanStepForward then begin
      self.actStepForward.Enabled := true;
    end else begin
      self.actStepForward.Enabled := false;
    end;
    self.cmdJumpFrom.Enabled := value;
    self.cmdJumpTo.Enabled := value;
    self.cmdSetFrom.Enabled := value;
    self.cmdSetTo.Enabled := value;
    self.cmdFromStart.Enabled := value;
    self.cmdToEnd.Enabled := value;
    //self.BPlayPause.Enabled := APlayPause.Enabled;
end;

function TFMain.BuildFilterGraph(FileName: String;
  FileType: TMovieType): boolean;
begin
  result := false;
end;

function TFMain.GetSampleGrabberMediaType(var MediaType: TAMMediaType): HResult;
//Fix because SampleGrabber does not set right media type:
//SampleGrabber has wrong resolution in MediaType if videowindow
//is smaller than native resolution
var
  SourcePin: IPin;
  InPin: IPin;
begin
  InPin := SampleGrabber.InPutPin;
  Result := InPin.ConnectedTo(SourcePin);
  if Result <> S_OK then begin
    exit;
  end;
  Result := SourcePin.ConnectionMediaType(MediaType)
end;

function TFMain.CustomGetSampleGrabberBitmap(Bitmap: TBitmap; Buffer: Pointer; BufferLen: Integer): Boolean;
//Fix because SampleGrabber does not set right media type:
//SampleGrabber has wrong resolution in MediaType if videowindow
//is smaller than native resolution
//This function is copied from DSPack but uses MediaType from upstream filter
  function GetDIBLineSize(BitCount, Width: Integer): Integer;
  begin
    if BitCount = 15 then
      BitCount := 16;
    Result := ((BitCount * Width + 31) div 32) * 4;
  end;
var
  hr: HRESULT;
  BIHeaderPtr: PBitmapInfoHeader;
  MediaType: TAMMediaType;
  BitmapHandle: HBitmap;
  DIBPtr: Pointer;
  DIBSize: LongInt;
begin
  Result := False;
  if not Assigned(Bitmap) then
    Exit;
  if Assigned(Buffer) and (BufferLen = 0) then
    Exit;
  hr := self.GetSampleGrabberMediaType(MediaType);    // <-- Changed
  if hr <> S_OK then
    Exit;
  try
    if IsEqualGUID(MediaType.majortype, MEDIATYPE_Video) then
    begin
      BIHeaderPtr := Nil;
      if IsEqualGUID(MediaType.formattype, FORMAT_VideoInfo) then
      begin
        if MediaType.cbFormat = SizeOf(TVideoInfoHeader) then  // check size
          BIHeaderPtr := @(PVideoInfoHeader(MediaType.pbFormat)^.bmiHeader);
      end
      else if IsEqualGUID(MediaType.formattype, FORMAT_VideoInfo2) then
      begin
        if MediaType.cbFormat = SizeOf(TVideoInfoHeader2) then  // check size
          BIHeaderPtr := @(PVideoInfoHeader2(MediaType.pbFormat)^.bmiHeader);
      end;
      // check, whether format is supported by TSampleGrabber
      if not Assigned(BIHeaderPtr) then
        Exit;
      BitmapHandle := CreateDIBSection(0, PBitmapInfo(BIHeaderPtr)^,
                                       DIB_RGB_COLORS, DIBPtr, 0, 0);
      if BitmapHandle <> 0 then
      begin
        try
          if DIBPtr = Nil then
            Exit;
          // get DIB size
          DIBSize := BIHeaderPtr^.biSizeImage;
          if DIBSize = 0 then
          begin
            with BIHeaderPtr^ do
              DIBSize := GetDIBLineSize(biBitCount, biWidth) * biHeight * biPlanes;
          end;
          // copy DIB
          if not Assigned(Buffer) then
          begin
            Exit;                                       // <-- changed
          end
          else
          begin
            if BufferLen > DIBSize then  // copy Min(BufferLen, DIBSize)
              BufferLen := DIBSize;
            Move(Buffer^, DIBPtr^, BufferLen);
          end;
          Bitmap.Handle := BitmapHandle;
          Result := True;
        finally
          if Bitmap.Handle <> BitmapHandle then  // preserve for any changes in Graphics.pas
            DeleteObject(BitmapHandle);
        end;
      end;
    end;
  finally
    FreeMediaType(@MediaType);
  end;
end;    

function TFMain.FilterGraphSelectedFilter(Moniker: IMoniker;
  FilterName: WideString; ClassID: TGUID): Boolean;
begin
  result := not settings.FilterIsInBlackList(ClassID);
end;

procedure TFMain.FramePopUpPrevious12FramesClick(Sender: TObject);
begin
  if mnuVideo.PopupComponent = VideoWindow then begin
    self.actPrevFrames.Execute;
  end;
  if mnuVideo.PopupComponent is TImage then begin
    ((mnuVideo.PopupComponent as TImage).Owner as TCutFrame).ImageDoubleClick(mnuVideo.PopupComponent);
    self.actPrevFrames.Execute;
  end;
end;

procedure TFMain.FramePopUpNext12FramesClick(Sender: TObject);
begin
  if mnuVideo.PopupComponent = VideoWindow then begin
    self.actNextFrames.Execute;
  end;
  if mnuVideo.PopupComponent is TImage then begin
    ((mnuVideo.PopupComponent as TImage).Owner as TCutFrame).ImageDoubleClick(mnuVideo.PopupComponent);
    self.actNextFrames.Execute;
  end;
end;

procedure TFMain.actShowLoggingExecute(Sender: TObject);
begin
  if not FLogging.Visible then
  begin
    FLogging.Width := Self.Width;
    FLogging.Top := Self.Top + Self.Height + 1;
    FLogging.Left := Self.Left;
  end;
  FLogging.Visible := true;
end;

procedure TFMain.actTestExceptionHandlingExecute(Sender: TObject);
begin
  raise Exception.Create('Exception handling test at ' + FormatDateTime('', Now));
end;

procedure TFMain.actCheckInfoOnServerExecute(Sender: TObject);
begin
  self.DownloadInfo(Settings, false, Utils.ShiftDown);
end;

procedure TFMain.actOpenCutassistantHomeExecute(Sender: TObject);
begin
  ShellExecute(0, nil, 'http://sourceforge.net/projects/cutassistant/', '', '', SW_SHOWNORMAL);
end;

procedure TFMain.FormShow(Sender: TObject);
begin
  if settings.CheckInfos then
    self.DownloadInfo(settings, true, false);
  if settings.NewSettingsCreated then
    actEditSettings.Execute;
end;

function TFMain.DoHttpGet(const url: string; const handleRedirects: boolean; const Error_message: string; var Response: string): boolean;
var
  data: THttpRequest;
begin
  data := THttpRequest.Create(url, handleRedirects, Error_message);
  try
    Result := DoHttpRequest(data);
    Response := data.Response;
  finally
    FreeAndNil(data);
  end;
end;

function TFMain.DoHttpRequest(data: THttpRequest): boolean;
const
  SLEEP_TIME = 50;
  MAX_SLEEP = 10;
var
  idx: integer;
begin
  RequestWorker.Start;
  RequestWorker.Data := data;

  idx := MAX_SLEEP;
  while idx > 0 do
  begin
    Dec(idx);
    Sleep(SLEEP_TIME);
    if RequestWorker.Stopped then
      Break;
  end;
  if not RequestWorker.Stopped then
    dlgRequestProgress.Execute;

  Result := HandleWorkerException(data);
end;

function TFMain.HandleWorkerException(data: THttpRequest): boolean;
var
  excClass: TClass;
  url, msg: string;
  idx: integer;
begin
  if RequestWorker.ReturnValue = 0 then
  begin
    Result := true;
    Exit;
  end;

  Result := false;
  excClass := RequestWorker.TerminatingExceptionClass;
  if excClass <> nil then
  begin
    msg := RequestWorker.TerminatingException;
    if excClass.InheritsFrom(EIdProtocolReplyError) then
    begin
      case RequestWorker.ReturnValue of
        404, 302: begin
          url := data.Url;
          idx := Pos('?', url);
          if idx < 1 then idx := Length(url)
          else Dec(idx);
          msg := Format(CAResources.RsErrorHttpFileNotFound, [ Copy(url, 1, idx) ]);
        end;
      end;
    end;
    if not batchmode then
      ShowMessage(data.ErrorMessage + msg);
  end;
end;

procedure TFMain.dlgRequestProgressShow(Sender: TObject);
var
  dlg: TJvProgressDialog;
begin
  dlg := Sender as TJvProgressDialog;
  Assert(Assigned(dlg));
  dlg.Position := 30;
end;

procedure TFMain.dlgRequestProgressCancel(Sender: TObject);
begin
  WebRequest_nl.DisconnectSocket;
  RequestWorker.WaitFor;
end;

procedure TFMain.dlgRequestProgressProgress(Sender: TObject;
  var AContinue: Boolean);
var
  dlg: TJvProgressDialog;
begin
  dlg := Sender as TJvProgressDialog;
  if dlg.Position = dlg.Max then dlg.Position := dlg.Min
  else dlg.Position := dlg.Position + 2;
  if RequestWorker.ReturnValue >= 0 then
    dlg.Interval := 0;
  if RequestWorker.ReturnValue > 0 then
    AContinue := false;
end;

procedure TFMain.RequestWorkerRun(Sender: TIdCustomThreadComponent);
var
  data: THttpRequest;
  Response: string;
begin
  Assert(Assigned(Sender));
  if Assigned(Sender.Thread) then
    NameThread(Sender.Thread.ThreadID, 'RequestWorker');
  data := Sender.Data as THttpRequest;
  if not Assigned(data) then // busy wait for data object ...
  begin
    Sleep(10);
    Exit;
  end;
  Sender.ReturnValue := -1;
  try
    WebRequest_nl.HandleRedirects := data.HandleRedirects;
    if data.IsPostRequest then
      Response := WebRequest_nl.Post(data.Url, data.PostData)
    else
      Response := WebRequest_nl.Get(data.Url);
    data.Response := Response;
  finally
    // Only for testing purposes
    //Sleep(10000);
    if not Sender.Terminated then
      Sender.Stop;
    if Sender.ReturnValue < 0 then;
      Sender.ReturnValue := 0;
  end;
end;

procedure TFMain.RequestWorkerException(Sender: TIdCustomThreadComponent;
  AException: Exception);
var
  data: THttpRequest;
begin
  Assert(Assigned(Sender));
  if not Assigned(Sender.Data) then
  begin
    dlgRequestProgress.Text := CAResources.RsProgressTransferAborted;
  end
  else begin
    data := Sender.Data as THttpRequest;
    dlgRequestProgress.Text := CAResources.RsErrorTransferAborting;
    data.Response := '';
  end;

  if AException is EIdProtocolReplyError then
    with AException as EIdProtocolReplyError do
      Sender.ReturnValue := ReplyErrorCode;
  if Sender.ReturnValue <= 0 then
    Sender.ReturnValue := 1;

  Sender.Stop;
end;

procedure TFMain.InitHttpProperties;
begin
  self.WebRequest_nl.ConnectTimeout := 1000 * Settings.NetTimeout;
  self.WebRequest_nl.ReadTimeout := 1000 * Settings.NetTimeout;
  self.WebRequest_nl.ProxyParams.ProxyServer := Settings.proxyServerName;
  self.WebRequest_nl.ProxyParams.ProxyPort := Settings.proxyPort;
  self.WebRequest_nl.ProxyParams.ProxyUsername := Settings.proxyUserName;
  self.WebRequest_nl.ProxyParams.ProxyPassword := Settings.proxyPassword;
end;

procedure TFMain.WebRequest_nlStatus(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: String);
begin
  dlgRequestProgress.Text := AStatusText;
end;

procedure TFMain.WebRequest_nlWork(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
  case AWorkMode of
    wmRead:
      dlgRequestProgress.Text := Format(CAResources.RsProgressReadData, [AWorkCount]);
    wmWrite:
      dlgRequestProgress.Text := Format(CAResources.RsProgressWroteData, [AWorkCount]);
  end;
end;


procedure TFMain.actSupportRequestExecute(Sender: TObject);
var
  AException: IMEException;
  AAssistant: INVAssistant;
  ABugReport: string;
  AScreenShot: INVBitmap;
  AMemo: INVEdit;
begin
  AException := NewException(etHidden);
  AException.ListThreads := false;
  //AException.MailAddr := 'cutassistant-help@lists.sourceforge.net';
  AException.MailSubject := Format(CAResources.RsCutAssistantSupportRequest, [ Application_Version ]);

  AAssistant := AException.GetAssistant('SupportAssistant');
  AMemo := AAssistant.Form['SupportDetailsForm'].nvEdit('DetailsMemo');
  AScreenShot := AException.ScreenShot;
  if AAssistant.ShowModal() = nvmOk then
  begin
    ABugReport := AException.GetBugReport(true);
    AException.MailBody := AMemo.OutputName + #13#10 + StringOfChar('-', Length(AMemo.OutputName)) + #13#10 + AMemo.Text;
    SendBugReport(ABugReport, AScreenShot, self.Handle, AException);
  end;
end;

procedure TFMain.actStopExecute(Sender: TObject);
begin
  GraphPause; //Set Play/Pause Button Caption
  jumpto(0);
  filtergraph.Stop;
end;

procedure TFMain.actPlayPauseExecute(Sender: TObject);
begin
  GraphPlayPause;
end;

procedure TFMain.actPlayExecute(Sender: TObject);
begin
  GraphPlay;
end;

procedure TFMain.actPauseExecute(Sender: TObject);
begin
  GraphPause;
end;

procedure TFMain.FilterGraphGraphComplete(sender: TObject; Result: HRESULT;
  Renderer: IBaseFilter);
begin
  // implement cut preview ...
  //ShowMessage('Complete');
end;


initialization
begin
  randomize;

  FreeLocalizer.LanguageDir := Application_Dir;
  FreeLocalizer.ErrorProcessing := epErrors;

  Settings := TSettings.Create;
  Settings.load;

  FreeLocalizer.AutoTranslate := Settings.LanguageFile <> '';
  if FreeLocalizer.AutoTranslate then
    FreeLocalizer.LanguageFile := Settings.LanguageFile;

  //RegisterDSAMessage(1, 'CutlistRated', 'Cutlist rated');
  MovieInfo := TMovieInfo.Create;
  Cutlist := TCutList.Create(Settings, MovieInfo);
end;

finalization
begin
  FreeAndNIL(Cutlist);
  FreeAndNIL(MovieInfo);
  Settings.save;
  FreeAndNIL(Settings);
end;

end.
