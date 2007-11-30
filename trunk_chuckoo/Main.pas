UNIT Main;

INTERFACE

USES
  Windows, Messages, SysUtils, DateUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, OleCtrls, StdCtrls, contnrs, shellapi, Buttons,
  ExtCtrls, strutils, iniFiles, Registry, ComObj, Menus, math, ToolWin, Clipbrd,

  ImgList,

  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  IdMultipartFormData, IdException,

  DSPack, DSUtil, DirectShow9, wmf9, ActiveX,

  Settings_dialog, ManageFilters, UploadList, CutlistInfo_dialog, UCutlist,
  Movie, Unit_DSTrackBarEx, trackBarEx, Utils,

  CodecSettings, JvComponentBase, JvSimpleXml, JclSimpleXML, IdAntiFreezeBase,
  IdAntiFreeze, JvGIF, JvSpeedbar, JvExExtCtrls, JvExtComponent, JvExControls,
  JvXPCore, JvXPBar, ActnList, IdThreadComponent, JvBaseDlg,
  JvProgressDialog, JvExStdCtrls, JvScrollBar, JvPanel;

CONST
  //Registry Keys
  CutlistID                        = 'CutAssistant.Cutlist';
  CUTLIST_CONTENT_TYPE             = 'text/plain';
  ProgID                           = 'Cut_Assistant.exe';
  ShellEditKey                     = 'CutAssistant.edit';

TYPE

  TFMain = CLASS(TForm {, ISampleGrabberCB})
    CutListOpenDialog: TOpenDialog;
    VideoWindow: TVideoWindow;
    SampleGrabber1: TSampleGrabber;
    TeeFilter: TFilter;
    NullRenderer1: TFilter;
    PanelVideoWindow: TPanel;
    OpenMovie: TAction;
    OpenCutlist: TAction;
    File_Exit: TAction;
    ImageList1: TImageList;
    SaveCutlistAs: TAction;
    AddCut: TAction;
    ReplaceCut: TAction;
    EditCut: TAction;
    DeleteCut: TAction;
    AShowFramesForm: TAction;
    ANextFrames: TAction;
    APrevFrames: TAction;
    AScanInterval: TAction;

    AStartCutting: TAction;
    EditSettings: TAction;
    MovieMetaData: TAction;
    About: TAction;
    UsedFilters: TAction;
    WriteToRegisty: TAction;
    RemoveRegistryEntries: TAction;
    CutlistUpload: TAction;
    IdHTTP1: TIdHTTP;
    AStepForward: TAction;
    AStepBackward: TAction;
    BrowseWWWHelp: TAction;
    OpenCutlistHome: TAction;
    ARepairMovie: TAction;
    ACutlistInfo: TAction;
    ASaveCutlist: TAction;
    ACalculateResultingTimes: TAction;
    AAsfbinInfo: TAction;
    ASearchCutlistByFileSize: TAction;
    ASendRating: TAction;
    ADeleteCutlistFromServer: TAction;
    ANextCut: TAction;
    APrevCut: TAction;
    FilterGraph: TFilterGraph;
    AFullScreen: TAction;
    ACloseMovie: TAction;
    ASnapshotCopy: TAction;
    ASnapshotSave: TAction;
    MenuVideo: TPopupMenu;
    CopySnapshottoClipboard1: TMenuItem;
    SaveSnapshotas1: TMenuItem;
    APlayInMPlayerAndSkip: TAction;
    FramePopUpNext12Frames: TMenuItem;
    FramePopUpPrevious12Frames: TMenuItem;
    N1: TMenuItem;
    XMLResponse: TJvSimpleXML;
    ActionList1: TActionList;
    SpeedBar: TJvSpeedBar;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    Cutlist1: TMenuItem;
    Edit1: TMenuItem;
    Frames1: TMenuItem;
    Info1: TMenuItem;
    Options1: TMenuItem;
    Help1: TMenuItem;
    OpenMovie1: TMenuItem;
    StartCutting1: TMenuItem;
    PlayMovieinMPlayer1: TMenuItem;
    RepairMovie1: TMenuItem;
    CloseMovie1: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    OpenCutlist1: TMenuItem;
    SearchCutlistsonServer1: TMenuItem;
    N3: TMenuItem;
    SaveCutlistAs1: TMenuItem;
    SaveCutlist1: TMenuItem;
    UploadCutlisttoServer1: TMenuItem;
    DeleteCutlistfromServer1: TMenuItem;
    N4: TMenuItem;
    CutlistInfo1: TMenuItem;
    CheckcutMovie1: TMenuItem;
    SendRating1: TMenuItem;
    Addnewcut1: TMenuItem;
    Replaceselectedcut1: TMenuItem;
    Editselectedcut1: TMenuItem;
    Deleteselectedcut1: TMenuItem;
    ShowForm1: TMenuItem;
    N5: TMenuItem;
    ScanInterval1: TMenuItem;
    Previous12Frames1: TMenuItem;
    Next12Frames1: TMenuItem;
    MovieMetaData1: TMenuItem;
    UsedFilters1: TMenuItem;
    CutApplications1: TMenuItem;
    Settings1: TMenuItem;
    N6: TMenuItem;
    Associatewithfileextensions1: TMenuItem;
    Removeregistryentries1: TMenuItem;
    CutlistHomepage1: TMenuItem;
    InternetHelpPages1: TMenuItem;
    N7: TMenuItem;
    About1: TMenuItem;
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
    ASmallSkipForward: TAction;
    ASmallSkipBackward: TAction;
    ALargeSkipForward: TAction;
    ALargeSkipBackward: TAction;
    Navigation1: TMenuItem;
    II1: TMenuItem;
    II2: TMenuItem;
    N8: TMenuItem;
    III1: TMenuItem;
    III2: TMenuItem;
    N9: TMenuItem;
    IIII1: TMenuItem;
    IIII2: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    AShowLogging: TAction;
    N13: TMenuItem;
    ShowLoggingMessages1: TMenuItem;
    ATestExceptionHandling: TAction;
    TestExceptionHandling1: TMenuItem;
    ACheckInfoOnServer: TAction;
    Checkinfoonserver1: TMenuItem;
    AOpenCutassistantHome: TAction;
    CutAssistantProject1: TMenuItem;
    RequestProgressDialog: TJvProgressDialog;
    RequestWorker: TIdThreadComponent;
    ASupportRequest: TAction;
    Makeasupportrequest1: TMenuItem;
    AStop: TAction;
    APlayPause: TAction;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    TrackMWheelFine: TtrackBarEx;
    pnlMovieControl: TPanel;
    pnlViewControl: TPanel;
    BPrevCut: TButton;
    BStepBack: TButton;
    BPlayPause: TButton;
    BFF: TButton;
    BStop: TButton;
    BNextCut: TButton;
    BStepForwards: TButton;
    TFinePos: TtrackBarEx;
    Panel2: TPanel;
    pnlCutFrom: TPanel;
    BSetFrom: TButton;
    BJumpFrom: TButton;
    BFromStart: TButton;
    EFrom: TEdit;
    pnlCutTo: TPanel;
    BSetTo: TButton;
    BJumpTo: TButton;
    BToEnd: TButton;
    ETo: TEdit;
    pnlCutAdd: TPanel;
    Label2: TLabel;
    BAddCut: TButton;
    EDuration: TEdit;
    Panel1: TPanel;
    LDuration: TLabel;
    LPos: TLabel;
    Label7: TLabel;
    BPrev12: TButton;
    B12FromTo: TButton;
    BNext12: TButton;
    TBFilePos: TDSTrackBarEx;
    cbSclickMode: TCheckBox;
    Panel3: TPanel;
    Label8: TLabel;
    TVolume: TTrackBar;
    CBMute: TCheckBox;
    TBRate: TtrackBarEx;
    Label4: TLabel;
    LTrueRate: TLabel;
    LRate: TLabel;
    btnScanToEnd: TButton;
    JvSpeedItem16: TJvSpeedItem;
    PROCEDURE FormCreate(Sender: TObject);
    PROCEDURE FormCloseQuery(Sender: TObject; VAR CanClose: Boolean);
    PROCEDURE FormClose(Sender: TObject; VAR Action: TCloseAction);
    PROCEDURE FormKeyDown(Sender: TObject; VAR Key: Word;
      Shift: TShiftState);
    PROCEDURE BSetFromClick(Sender: TObject);
    PROCEDURE BSetToClick(Sender: TObject);
    PROCEDURE BFromStartClick(Sender: TObject);
    PROCEDURE BToEndClick(Sender: TObject);
    PROCEDURE BJumpFromClick(Sender: TObject);
    PROCEDURE BJumpToClick(Sender: TObject);
    PROCEDURE AStepForwardExecute(Sender: TObject);
    PROCEDURE AStepBackwardExecute(Sender: TObject);

    PROCEDURE LcutlistSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    PROCEDURE LcutlistDblClick(Sender: TObject);
    // procedure RCutModeClick(Sender: TObject);

    PROCEDURE TVolumeChange(Sender: TObject);
    PROCEDURE CBMuteClick(Sender: TObject);

    PROCEDURE TBFilePosTimer(sender: TObject; CurrentPos,
      StopPos: Cardinal);
    PROCEDURE TBFilePosPositionChangedByMouse(Sender: TObject);
    PROCEDURE TBFilePosChange(Sender: TObject);
    PROCEDURE TBFilePosSelChanged(Sender: TObject);
    PROCEDURE TBFilePosChannelPostPaint(Sender: TDSTrackBarEx;
      CONST ARect: TRect);
    PROCEDURE TFinePosMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    PROCEDURE TFinePosChange(Sender: TObject);
    PROCEDURE FilterGraphGraphStepComplete(Sender: TObject);
    PROCEDURE PanelVideoWindowResize(Sender: TObject);
    PROCEDURE SampleGrabber1Buffer(sender: TObject; SampleTime: Double;
      pBuffer: Pointer; BufferLen: Integer);

    PROCEDURE OpenMovieExecute(Sender: TObject);
    PROCEDURE OpenCutlistExecute(Sender: TObject);
    PROCEDURE ASaveCutlistExecute(Sender: TObject);
    PROCEDURE SaveCutlistAsExecute(Sender: TObject);
    PROCEDURE File_ExitExecute(Sender: TObject);
    PROCEDURE AddCutExecute(Sender: TObject);
    PROCEDURE ReplaceCutExecute(Sender: TObject);
    PROCEDURE EditCutExecute(Sender: TObject);
    PROCEDURE DeleteCutExecute(Sender: TObject);
    PROCEDURE BConvertClick(Sender: TObject);
    PROCEDURE ACutlistInfoExecute(Sender: TObject);
    PROCEDURE ASearchCutlistByFileSizeExecute(Sender: TObject);
    PROCEDURE CutlistUploadExecute(Sender: TObject);
    PROCEDURE ASendRatingExecute(Sender: TObject);
    PROCEDURE ADeleteCutlistFromServerExecute(Sender: TObject);

    PROCEDURE AShowFramesFormExecute(Sender: TObject);
    PROCEDURE ANextFramesExecute(Sender: TObject);
    PROCEDURE APrevFramesExecute(Sender: TObject);
    PROCEDURE AScanintervalExecute(Sender: TObject);

    PROCEDURE ARepairMovieExecute(Sender: TObject);
    PROCEDURE AStartCuttingExecute(Sender: TObject);
    PROCEDURE ShowCutlistWorkWindow(Sender: TObject);
    PROCEDURE MovieMetaDataExecute(Sender: TObject);
    PROCEDURE EditSettingsExecute(Sender: TObject);
    PROCEDURE UsedFiltersExecute(Sender: TObject);
    PROCEDURE AboutExecute(Sender: TObject);
    PROCEDURE BrowseWWWHelpExecute(Sender: TObject);
    PROCEDURE OpenCutlistHomeExecute(Sender: TObject);

    PROCEDURE WriteToRegistyExecute(Sender: TObject);
    PROCEDURE RemoveRegistryEntriesExecute(Sender: TObject);

    PROCEDURE ACalculateResultingTimesExecute(Sender: TObject);
    PROCEDURE VideoWindowClick(Sender: TObject);
    PROCEDURE TBRateChange(Sender: TObject);
    PROCEDURE LRateDblClick(Sender: TObject);
    PROCEDURE ANextCutExecute(Sender: TObject);
    PROCEDURE APrevCutExecute(Sender: TObject);
    PROCEDURE BFFMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    PROCEDURE BFFMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    PROCEDURE VideoWindowDblClick(Sender: TObject);
    PROCEDURE AFullScreenExecute(Sender: TObject);
    PROCEDURE VideoWindowKeyDown(Sender: TObject; VAR Key: Word;
      Shift: TShiftState);
    PROCEDURE ACloseMovieExecute(Sender: TObject);
    PROCEDURE ASnapshotCopyExecute(Sender: TObject);
    PROCEDURE ASnapshotSaveExecute(Sender: TObject);
    PROCEDURE APlayInMPlayerAndSkipExecute(Sender: TObject);
    FUNCTION FilterGraphSelectedFilter(Moniker: IMoniker; FilterName: WideString; ClassID: TGUID): Boolean;
    PROCEDURE FramePopUpNext12FramesClick(Sender: TObject);
    PROCEDURE FramePopUpPrevious12FramesClick(Sender: TObject);
    PROCEDURE FormDestroy(Sender: TObject);
    PROCEDURE AShowLoggingExecute(Sender: TObject);
    PROCEDURE ATestExceptionHandlingExecute(Sender: TObject);
    PROCEDURE ACheckInfoOnServerExecute(Sender: TObject);
    PROCEDURE AOpenCutassistantHomeExecute(Sender: TObject);
    PROCEDURE FormShow(Sender: TObject);
    PROCEDURE RequestProgressDialogShow(Sender: TObject);
    PROCEDURE RequestProgressDialogProgress(Sender: TObject;
      VAR AContinue: Boolean);
    PROCEDURE RequestWorkerRun(Sender: TIdCustomThreadComponent);
    PROCEDURE RequestWorkerException(Sender: TIdCustomThreadComponent;
      AException: Exception);
    PROCEDURE IdHTTP1Status(ASender: TObject; CONST AStatus: TIdStatus;
      CONST AStatusText: STRING);
    PROCEDURE ASupportRequestExecute(Sender: TObject);
    PROCEDURE RequestProgressDialogCancel(Sender: TObject);
    PROCEDURE IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      CONST AWorkCount: Integer);
    PROCEDURE AStopExecute(Sender: TObject);
    PROCEDURE APlayPauseExecute(Sender: TObject);
    PROCEDURE TrackMWheelFineChange(Sender: TObject);
    PROCEDURE btnScanToEndMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    PROCEDURE btnShowCutlistClick(Sender: TObject);
    PROCEDURE Button1Click(Sender: TObject);
    PROCEDURE JvSpeedItem16Click(Sender: TObject);
  PRIVATE
    { Private declarations }
    UploadDataEntries: TStringList;
    StepComplete: boolean;
    SampleTarget: TObject; //TCutFrame
    PROCEDURE ResetForm;
    PROCEDURE EnableMovieControls(value: boolean);
    PROCEDURE InitVideo;
    PROCEDURE InsertSampleGrabber;
    FUNCTION GetSampleGrabberMediaType(VAR MediaType: TAMMediaType): HResult;
    FUNCTION CustomGetSampleGrabberBitmap(Bitmap: TBitmap; Buffer: Pointer; BufferLen: Integer): boolean;
    {
    function SampleCB(SampleTime: double; MediaSample: IMediaSample): HRESULT; stdcall;
    function  BufferCB(SampleTime: Double; pBuffer: PByte; BufferLen: longint): HResult; stdcall;
    }
    PROCEDURE refresh_Lcutlist(cutlist: TCutlist);
    FUNCTION WaitForStep(TimeOut: INteger): boolean;
    PROCEDURE WaitForFilterGraph;
    PROCEDURE HandleParameter(CONST param: STRING);
    FUNCTION CalcTrueRate(Interval: double): double;
    PROCEDURE FF_Start;
    PROCEDURE FF_Stop;
    FUNCTION ConvertUploadData: boolean;
    PROCEDURE AddUploadDataEntry(CutlistDate: TDateTime; CutlistName: STRING; CutlistID: Integer);
    PROCEDURE UpdateMovieInfoControls;
  PUBLIC
    { Public declarations }

    iActiveCut: integer;
    //   CutList: TCutList;

    PROCEDURE ProcessFileList(FileList: TStringList; IsMyOwnCommandLine: boolean);
    PROCEDURE refresh_times;
    PROCEDURE enable_del_buttons(value: boolean);
    FUNCTION CurrentPosition: double;
    PROCEDURE JumpTo(NewPosition: double);
    PROCEDURE SetStartPosition(Position: double);
    PROCEDURE SetStopPosition(Position: double);

    PROCEDURE ShowFrames(startframe, endframe: Integer);
    PROCEDURE ShowFramesAbs(startframe, endframe: double; numberOfFrames: Integer);

    FUNCTION OpenFile(Filename: STRING): boolean;
    FUNCTION BuildFilterGraph(FileName: STRING; FileType: TMovieType): boolean;
    FUNCTION CloseMovieAndCutlist: boolean;
    PROCEDURE CloseMovie;
    FUNCTION GraphPlayPause: boolean;
    FUNCTION GraphPlay: boolean;
    FUNCTION GraphPause: boolean;
    FUNCTION ToggleFullScreen: boolean;
    PROCEDURE ShowMetaData;
    FUNCTION RepairMovie: boolean;


    PROCEDURE setCutlistMode(value: integer);


    FUNCTION StartCutting: boolean;
    //    function CreateVDubScript(cutlist: TCutlist; Inputfile, Outputfile: String; var scriptfile: string): boolean;
    FUNCTION CreateMPlayerEDL(cutlist: TCutlist; Inputfile, Outputfile: STRING; VAR scriptfile: STRING): boolean;

    FUNCTION DownloadInfo(settings: TSettings; CONST UseDate, ShowAll: boolean): boolean;
    PROCEDURE LoadCutList;
    //    function search_cutlist: boolean;
    FUNCTION SearchCutlistsByFileSize_XML: boolean;
    //    function DownloadCutlist(cutlist_name: string): boolean;
    FUNCTION DownloadCutlistByID(cutlist_id, TargetFileName: STRING): boolean;
    FUNCTION UploadCutlist(filename: STRING): boolean;
    FUNCTION DeleteCutlistFromServer(CONST cutlist_id: STRING): boolean;
    FUNCTION AskForUserRating(Cutlist: TCutlist): boolean;
    FUNCTION SendRating(Cutlist: TCutlist): boolean;
  PROTECTED
    PROCEDURE WMDropFiles(VAR message: TWMDropFiles); MESSAGE WM_DROPFILES;
    PROCEDURE WMCopyData(VAR msg: TWMCopyData); MESSAGE WM_COPYDATA;
    FUNCTION DoHttpGet(CONST url: STRING; CONST handleRedirects: boolean; CONST Error_message: STRING; VAR Response: STRING): boolean;
    FUNCTION DoHttpRequest(data: THttpRequest): boolean;
    PROCEDURE InitHttpProperties;
    FUNCTION HandleWorkerException(data: THttpRequest): boolean;
    PROCEDURE InitFramesProperties(CONST AAction: TAction; CONST s: STRING);
  END;


VAR
  FMain                            : TFMain;
  CutList                          : TCutList;
  Settings                         : TSettings;
  pos_to, pos_from                 : double;
  vol_temp                         : integer;
  last_pos                         : double;

  //HG
  IlastPos                         : longint;
  iActiveCut                       : integer;
  mainformLoaded                   : boolean;

  //*HG

    //Batch flags
  exit_after_commandline, TryCutting: boolean;

  //movie params
  MovieInfo                        : TMovieInfo;

  //Interfaces
  BasicVideo                       : IBasicVideo;
  Seeking                          : IMediaSeeking;
  MediaEvent                       : IMediaEvent;
  Framestep                        : IVideoFrameStep;
  VMRWindowlessControl             : IVMRWindowlessControl;
  VMRWindowlessControl9            : IVMRWindowlessControl9;

IMPLEMENTATION
USES madExcept, madNVBitmap, madNVAssistant, Frames, CutlistRate_Dialog, ResultingTimes, CutlistSearchResults,
  PBOnceOnly, UfrmCutting, UCutApplicationBase, UCutApplicationAsfbin, UCutApplicationMP4Box, UMemoDialog,
  DateTools, UAbout, ULogging, UDSAStorage, IdResourceStrings, UframeCutlist,
  UClist;

{$R *.dfm}
{$WARN SYMBOL_PLATFORM OFF}

PROCEDURE TFMain.UpdateMovieInfoControls;
BEGIN
  // HG ... due to cutlist in separate form now
  // only clear cutlist, if the main form is already created, otherwise we crash

  IF mainformLoaded = true THEN BEGIN


    IF NOT Assigned(MovieInfo) THEN
      frmClist.lblMovieFPS.Caption := 'fps: N/A'
    ELSE
      frmClist.lblMovieFPS.Caption := MovieInfo.FormatFrameRate;

    IF NOT Assigned(MovieInfo) OR NOT MovieInfo.MovieLoaded THEN BEGIN
      frmClist.lblMovieType.Caption := '[None]';
      frmClist.lblCutApplication.Caption := 'Cut app.: N/A';
    END ELSE BEGIN
      frmClist.lblMovieType.Caption := MovieInfo.MovieTypeString;
      frmClist.lblCutApplication.Caption := 'Cut app.: ' + Settings.GetCutAppName(MovieInfo.MovieType);
    END;

  END;
  //HG

END;

PROCEDURE TFMain.InitFramesProperties(CONST AAction: TAction; CONST s: STRING);
BEGIN
  IF NOT Assigned(AAction) THEN
    Exit;
  AAction.Caption := AnsiReplaceText(AAction.Caption, '$$', s);
  AAction.Hint := AnsiReplaceText(AAction.Hint, '$$', s);
END;

PROCEDURE TFMain.BSetFromClick(Sender: TObject);
BEGIN
  SetStartPosition(CurrentPosition);
  // HG

  iActiveCut := cutlist.GetCutNr(CurrentPosition);


  //label3.Caption := inttostr(iActiveCut);

  self.pnlCutFrom.Color := clSkyBlue;



  //do no try this when there is no cut begin set, this may cause errors unneeded
  IF (cbSclickMode.checked = true) AND (pos_from > 0) AND (pos_from < pos_to) THEN BEGIN
    AddCut.Execute;
  END;
  // *HG




END;

PROCEDURE TFMain.BSetToClick(Sender: TObject);

BEGIN
  SetStopPosition(CurrentPosition);

  // HG

  iActiveCut := cutlist.GetCutNr(CurrentPosition);


  //label3.Caption := inttostr(iActiveCut);


//iActiveCut := cutlist.GetCutNr(pos_from);


//         label1.Caption := inttostr(iActiveCut);


  self.pnlCutTo.Color := clSkyBlue;
  //do no try this when there is no cut begin set, this may cause errors unneeded
  IF (cbSclickMode.checked = true) AND (AddCut.Enabled = true) AND (pos_from > 0) THEN BEGIN
    AddCut.Execute;
  END;
  // *HG

END;

PROCEDURE TFMain.refresh_times;
BEGIN
  self.EFrom.Text := MovieInfo.FormatPosition(pos_from);
  self.ETo.Text := MovieInfo.FormatPosition(pos_to);
  //  if pos_to >= pos_from then begin
  //HG
  IF (pos_to >= pos_from) AND (pos_from > 0) THEN BEGIN
    //HG
    self.EDuration.Text := MovieInfo.FormatPosition(pos_to - pos_from);
    self.AddCut.Enabled := true;
    self.pnlCutAdd.Color := clYellow;

  END ELSE BEGIN
    self.EDuration.Text := '';
    self.AddCut.Enabled := false;
    self.pnlCutAdd.Color := clGradientInactiveCaption;
  END;
END;

PROCEDURE TFMain.FormCreate(Sender: TObject);
VAR
  numFrames                        : STRING;
BEGIN
  AdjustFormConstraints(self);
  IF screen.WorkAreaWidth < self.Constraints.MinWidth THEN BEGIN
    self.Constraints.MinWidth := screen.Width;
    //self.WindowState := wsMaximized;
  END;
  IF screen.WorkAreaHeight < self.Constraints.MinHeight THEN BEGIN
    self.Constraints.MinHeight := screen.Height;
    //self.WindowState := wsMaximized;
  END;

  IF ValidRect(Settings.MainFormBounds) THEN
    self.BoundsRect := Settings.MainFormBounds
  ELSE BEGIN
    self.Top := Screen.WorkAreaTop + Max(0, (Screen.WorkAreaHeight - self.Height) DIV 2);
    self.Left := Screen.WorkAreaLeft + Max(0, (Screen.WorkAreaWidth - self.Width) DIV 2);
  END;

  self.WindowState := Settings.MainFormWindowState;


  numFrames := IntToStr(Settings.FramesCount);
  InitFramesProperties(self.ANextFrames, numFrames);
  InitFramesProperties(self.APrevFrames, numFrames);
  InitFramesProperties(self.AScanInterval, numFrames);

  ResetForm;

  DragAcceptFiles(self.Handle, true);
  ExitCode := 0;

  //Init Filtergraph
  {FilterGraph := TFiltergraph.Create(self);
  FilterGraph.GraphEdit := true;
  FilterGraph.LinearVolume := true;
  FilterGraph.OnGraphStepComplete := FilterGraphGraphStepComplete;
  //SampleGrabber1.FilterGraph := FilterGraph;
  VideoWindow.FilterGraph := FilterGraph;
  TBFilePos.FilterGraph := FilterGraph;   }

  UploadDataEntries := TStringList.Create;
  UploadDataEntries := TStringList.Create;
  IF fileexists(UploadData_Path(true)) THEN
    UploadDataEntries.LoadFromFile(UploadData_Path(true));

  IF fileexists(UploadData_Path(false)) THEN BEGIN
    ConvertUploadData;
  END;

  InitHttpProperties;




  // HG ... due to cutlist in separate form now
  // only clear cutlist, if the main form is already created, otherwise we crash

  setCutlistMode(settings.DefaultCutMode);
      self.cbSclickMode.checked := settings.DefaultAutoMode;


  IF mainformLoaded = true THEN BEGIN
    frmClist.RCutMode.ItemIndex := settings.DefaultCutMode;
  END;
  Cutlist.RefreshCallBack := self.refresh_Lcutlist;
  cutlist.RefreshGUI;
  //end;

  filtergraph.Volume := 5000;
  TVolume.PageSize := TVOlume.Frequency;
  TVOlume.LineSize := round(TVolume.PageSize / 10);
  TVolume.Position := filtergraph.Volume;
    self.cbSclickMode.checked := settings.DefaultAutoMode;

  //self.WindowState := wsMaximized;
END;

PROCEDURE TFMain.FormDestroy(Sender: TObject);
BEGIN
  Settings.MainFormBounds := self.BoundsRect;
  Settings.MainFormWindowState := self.WindowState;
  FreeAndNIL(UploadDataEntries);
END;

PROCEDURE TFMain.BFromStartClick(Sender: TObject);
BEGIN
  pos_from := 0;
  refresh_times;
END;

PROCEDURE TFMain.BToEndClick(Sender: TObject);
BEGIN
  pos_to := MovieInfo.current_file_duration;
  refresh_times;
END;

PROCEDURE TFMain.BJumpFromClick(Sender: TObject);
BEGIN
  JumpTo(pos_from);
END;

PROCEDURE TFMain.BJumpToClick(Sender: TObject);
BEGIN
  JumpTo(pos_to);
END;

PROCEDURE TFMain.LcutlistSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
BEGIN
  self.enable_del_buttons(true);
END;

PROCEDURE TFMain.enable_del_buttons(value: boolean);
BEGIN
  self.DeleteCut.enabled := value;
  self.EditCut.Enabled := value;
  self.ReplaceCut.Enabled := value;
END;






PROCEDURE TFMain.setCutlistMode(value: integer);
BEGIN

  CASE value OF

    0: cutlist.Mode := clmCutOut;
    1: cutlist.Mode := clmCrop;
  END;

END;





FUNCTION TFMain.StartCutting: boolean;
VAR
  message_string                   : STRING;
  sourcefile, sourceExtension, targetfile, targetpath: STRING;
  AskForPath                       : boolean;
  saveDlg                          : TSaveDialog;
  //  exitCode: DWord;
  CutApplication                   : TCutApplicationBase;
BEGIN
  result := false;
  IF cutlist.Count = 0 THEN BEGIN
    IF NOT batchmode THEN showmessage('No cuts defined.');
    exit;
  END;

  IF settings.CutlistAutoSaveBeforeCutting AND cutlist.HasChanged THEN cutlist.Save(false);

  sourcefile := extractfilename(MovieInfo.current_filename);
  sourceExtension := extractfileext(sourcefile);

  IF settings.UseMovieNameSuggestion AND (trim(cutlist.SuggestedMovieName) <> '') THEN
    targetfile := trim(cutlist.SuggestedMovieName) + SourceExtension
  ELSE
    targetfile := changefileExt(sourcefile, Settings.CutMovieExtension + SourceExtension);

  CASE Settings.SaveCutMovieMode OF
    smWithSource: BEGIN //with source
        targetpath := extractFilePath(MovieInfo.current_filename);
      END;
    smGivenDir: BEGIN //in given Dir
        targetpath := IncludeTrailingPathDelimiter(Settings.CutMovieSaveDir);
      END;
  ELSE BEGIN //with source
      targetpath := extractFilePath(MovieInfo.current_filename);
    END;
  END;

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
  MovieInfo.target_filename := targetpath + targetfile;

  IF NOT ForceDirectories(targetpath) THEN BEGIN
    IF NOT batchmode THEN
      showmessage('Could not create target file path ' + targetpath + '. Abort.');
    exit;
  END;

  //Display Save Dialog?
  AskForPath := Settings.MovieNameAlwaysConfirm;


  IF fileexists(MovieInfo.target_FileName) AND (NOT AskForPath) AND (NOT batchmode) THEN BEGIN
    message_string := 'Target file already exists:' + #13#10 + #13#10 + MovieInfo.target_filename + #13#10 + #13#10 + 'Overwrite?';
    IF application.messagebox(PChar(message_string), NIL, MB_YESNO + MB_DEFBUTTON2 + MB_ICONWARNING) <> IDYES THEN AskForPath := true;
  END;
  IF AskForPath AND (NOT batchmode) THEN BEGIN
    saveDlg := TSaveDialog.Create(self);
    saveDlg.Filter := '*' + SourceExtension + '|*' + SourceExtension;
    saveDlg.Title := 'Save cut movie as...';
    saveDlg.InitialDir := targetpath;
    saveDlg.filename := targetfile;
    saveDlg.options := saveDlg.Options + [ofOverwritePrompt, ofPathMustExist];
    IF saveDlg.Execute THEN BEGIN
      MovieInfo.target_filename := trim(saveDlg.FileName);
      IF NOT ansiSameText(extractFileExt(MovieInfo.target_filename), SourceExtension) THEN BEGIN
        MovieInfo.target_filename := MovieInfo.target_filename + sourceExtension;
      END;
    END ELSE
      exit;
  END;

  IF fileexists(MovieInfo.target_FileName) THEN BEGIN
    IF NOT deletefile(MovieInfo.target_filename) THEN BEGIN
      IF NOT batchmode THEN showmessage('Could not delete existing file ' + MovieInfo.target_filename + '. Abort.');
      exit;
    END;
  END;

  CutApplication := Settings.GetCutApplicationByMovieType(MovieInfo.MovieType);
  IF assigned(CutApplication) THEN BEGIN
    CutApplication.CutAppSettings := Settings.GetCutAppSettingsByMovieType(MovieInfo.MovieType);
    frmCutting.CutApplication := CutApplication;
    result := CutApplication.PrepareCutting(MovieInfo.current_filename, MovieInfo.target_filename, cutlist);
    IF result THEN BEGIN
      CASE frmCutting.ExecuteCutApp OF
        mrOK: result := true;
      ELSE result := false;
      END;
    END;
  END;
END;

PROCEDURE TFMain.CBMuteClick(Sender: TObject);
BEGIN
  IF CBMUte.Checked THEN BEGIN
    FilterGraph.Volume := 0;
  END ELSE BEGIN
    FilterGraph.Volume := TVolume.Position;
  END;

END;

PROCEDURE TFMain.TVolumeChange(Sender: TObject);
BEGIN
  IF NOT CBMute.Checked THEN
    FilterGraph.Volume := TVolume.Position;
END;

PROCEDURE TFMain.TFinePosMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
VAR
  new_pos                          : double;
BEGIN
  new_pos := currentPosition + TFinePos.Position * MovieInfo.frame_duration;
  IF new_pos < 0 THEN new_pos := 0;
  IF new_pos > MovieInfo.current_file_duration THEN new_pos := MovieInfo.current_file_duration;
  JumpTo(new_pos);
  TFinePos.Position := 0;
END;

PROCEDURE TFMain.refresh_Lcutlist(cutlist: TCutlist);
VAR
  icut                             : integer;
  cut                              : tcut;
  cut_view                         : tlistitem;
  i_column                         : integer;
  total_cutoff, resulting_duration : Double;
BEGIN
  // HG ... due to cutlist in separate form now
  // only clear cutlist, if the main form is already created, otherwise we crash

  IF mainformLoaded = true THEN BEGIN

    frmClist.Lcutlist.Clear;
  END;
  //HG

  self.ASendRating.Enabled := cutlist.IDOnServer <> '';

  IF cutlist.Count = 0 THEN BEGIN
    self.AStartCutting.Enabled := false;
    self.ACalculateResultingTimes.Enabled := false;
    self.SaveCutlistAs.Enabled := false;
    self.ASaveCutlist.Enabled := false;
    self.CutlistUpload.Enabled := false;
    self.ANextCut.Enabled := false;
    self.APrevCut.Enabled := false;
    self.enable_del_buttons(false);
  END ELSE BEGIN
    self.AStartCutting.Enabled := true;
    self.ACalculateResultingTimes.Enabled := true;
    self.SaveCutlistAs.Enabled := true;
    self.ASaveCutlist.Enabled := true;
    self.CutlistUpload.Enabled := true;
    self.ANextCut.Enabled := true;
    self.APrevCut.Enabled := true;
    FOR icut := 0 TO cutlist.Count - 1 DO BEGIN
      cut := cutlist[icut];
      cut_view := frmClist.Lcutlist.Items.Add;
      cut_view.Caption := inttostr(cut.index);
      cut_view.SubItems.Add(MovieInfo.FormatPosition(cut.pos_from));
      cut_view.SubItems.Add(MovieInfo.FormatPosition(cut.pos_to));
      cut_view.SubItems.Add(MovieInfo.FormatPosition(cut.pos_to - cut.pos_from + MovieInfo.frame_duration));
    END;

    //Auto-Resize columns
    FOR i_column := 0 TO frmClist.Lcutlist.Columns.Count - 1 DO BEGIN
      frmClist.lcutlist.Columns[i_column].Width := -2;
    END;

    IF frmClist.LCutlist.ItemIndex = -1 THEN
      self.enable_del_buttons(false)
    ELSE
      self.enable_del_buttons(true);
  END;

  IF cutlist.Mode = clmCutOut THEN BEGIN
    total_cutoff := cutlist.TotalDurationOfCuts;
    resulting_duration := MovieInfo.current_file_duration - total_cutoff;
  END ELSE BEGIN
    resulting_duration := cutlist.TotalDurationOfCuts;
    total_cutoff := MovieInfo.current_file_duration - resulting_duration;
  END;

  // HG ... due to cutlist in separate form now
// only set values in cutlist window, if the main form is already created, otherwise we crash

  IF mainformLoaded = true THEN BEGIN

    frmClist.LTotalCutoff.Caption := 'Total cutoff: ' + secondstotimestring(total_cutoff);
    frmClist.LResultingDuration.Caption := 'Resulting movie duration: ' + secondsToTimeString(resulting_duration);

    CASE cutlist.Mode OF
      clmCutOut: frmClist.RCutMode.ItemIndex := 0;
      clmCrop: frmClist.RCutMode.ItemIndex := 1;
    END;


    IF (cutlist.RatingByAuthorPresent AND (cutlist.RatingByAuthor <= 2))
      OR cutlist.EPGError
      OR cutlist.MissingBeginning
      OR cutlist.MissingEnding
      OR cutlist.MissingVideo
      OR cutlist.MissingAudio
      OR cutlist.OtherError
      THEN BEGIN
      //self.ACutlistInfo.ImageIndex := 18;
      frmClist.ICutlistWarning.Visible := true;
    END ELSE BEGIN
      //self.ACutlistInfo.ImageIndex := -1;
      frmClist.ICutlistWarning.Visible := false;
    END;


    IF cutlist.Author <> '' THEN BEGIN
      frmClist.LAuthor.Caption := cutlist.Author;
      frmClist.PAuthor.Visible := true;
    END ELSE BEGIN
      frmClist.PAuthor.Visible := false;
    END; ;
  END;

  //HG


  //Cuts in Trackbar are taken from global var "cutlist"!
  self.TBFilePos.Perform(CM_RECREATEWND, 0, 0); //Show Cuts in Trackbar


END;








FUNCTION TFMain.OpenFile(Filename: STRING): boolean;
//false if file not found
VAR
  SourceFilter, AviDecompressorFilter: IBaseFilter;
  SourceAdded                      : boolean;
  AvailableFilters                 : TSysDevEnum;
  PinList                          : TPinList;
  IPin                             : Integer;
  TempCursor                       : TCursor;
BEGIN
  result := false;
  IF fileexists(filename) THEN BEGIN
    IF MovieInfo.MovieLoaded THEN BEGIN
      IF NOT self.CloseMovieAndCutlist THEN exit; ;
    END;

    TempCursor := screen.Cursor;
    TRY
      screen.Cursor := crHourGlass;
      MovieInfo.target_filename := '';
      IF NOT MovieInfo.InitMovie(FileName) THEN
        exit;

      IF MovieInfo.MovieType IN [mtWMV] THEN BEGIN
        self.ARepairMovie.Enabled := true;
      END ELSE BEGIN
        self.ARepairMovie.Enabled := false;
      END;

      {if not batchmode then }BEGIN
        SourceAdded := false;

        IF MovieInfo.MovieType IN [mtWMV] THEN BEGIN
          SampleGrabber1.FilterGraph := NIL;
        END ELSE BEGIN
          SampleGrabber1.FilterGraph := FilterGraph;
        END;

        FilterGraph.Active := true;

        AvailableFilters := TSysDevEnum.Create(CLSID_LegacyAmFilterCategory); //DirectShow Filters
        TRY
          //If MP4 then Try to Add AviDecompressor
          IF (MovieInfo.MovieType IN [mtMP4]) THEN BEGIN
            AviDecompressorFilter := AvailableFilters.GetBaseFilter(CLSID_AVIDec); //Avi Decompressor
            IF assigned(AviDecompressorFilter) THEN BEGIN
              CheckDSError((FilterGraph AS IGraphBuilder).AddFilter(AviDecompressorFilter, 'Avi Decompressor'));
            END;
          END;

          IF NOT (IsEqualGUID(Settings.GetPreferredSourceFilterByMovieType(MovieInfo.MovieType), GUID_NULL)) THEN BEGIN
            SourceFilter := AvailableFilters.GetBaseFilter(Settings.GetPreferredSourceFilterByMovieType(MovieInfo.MovieType));
            IF assigned(SourceFilter) THEN BEGIN
              CheckDSError((SourceFilter AS IFileSourceFilter).Load(StringToOleStr(FileName), NIL));
              CheckDSError((FilterGraph AS IGraphBuilder).AddFilter(SourceFilter, StringToOleStr('Source Filter [' + extractFileName(FileName) + ']')));
              SourceAdded := true;
            END;
          END;
        FINALLY
          FreeAndNIL(AvailableFilters);
        END;

        IF NOT sourceAdded THEN BEGIN
          CheckDSError(FilterGraph.RenderFile(FileName));
        END ELSE BEGIN
          PinLIst := TPinLIst.Create(SourceFilter);
          TRY
            FOR iPin := 0 TO PinList.Count - 1 DO BEGIN
              CheckDSError((FilterGraph AS IGraphBuilder).Render(PinList.Items[iPin]));
            END;
          FINALLY
            FreeAndNIL(PinList);
          END;
        END;

        initVideo;

        IF SampleGrabber1.FilterGraph = NIL THEN BEGIN
          InsertSampleGrabber;
          IF NOT filtergraph.Active THEN BEGIN
            IF NOT batchmode THEN
              showmessage('Could not insert sample grabber.');
            MovieInfo.current_filename := '';
            MovieInfo.MovieLoaded := false;
            MovieInfo.current_filesize := -1;
            UpdateMovieInfoControls;
            exit;
          END;
        END;
        FilterGraph.Volume := self.TVolume.Position;

        GraphPause;

        //SampleGrabber1.SampleGrabber.SetCallback(self, 0);

        TBFilePos.TriggerTimer;
        self.PanelVideoWindowResize(self);
      END;

      self.Caption := Application_Friendly_Name + ' ' + extractfilename(MovieInfo.current_filename);
      application.Title := extractfilename(MovieInfo.current_filename);

      MovieInfo.MovieLoaded := true;
      result := true;
    EXCEPT
      ON E: Exception DO
        IF NOT batchmode THEN
          ShowMessage('Could not open Movie!'#13#10'Error: ' + E.Message);
    END;
    screen.Cursor := TempCursor;
  END ELSE BEGIN
    IF NOT batchmode THEN
      ShowMessage('File not found: ' + #13#10 + filename);
    MovieInfo.current_filename := '';
    MovieInfo.MovieLoaded := false;
  END;
  self.UpdateMovieInfoControls;
END;

PROCEDURE TFMain.LoadCutList;
VAR
  filename, cutlist_path, cutlist_filename: STRING;
  CutlistMode_old                  : TCutlistMode;
  newCutlist                       : TCutlist;
BEGIN
  IF MovieInfo.current_filename = '' THEN BEGIN
    IF NOT batchmode THEN
      showmessage('Please load movie first.');
    exit;
  END;

  //Use same settings as for saving as default
  cutlist_filename := ChangeFileExt(extractfilename(MovieInfo.current_filename), cutlist_Extension);
  CASE Settings.SaveCutlistMode OF
    smWithSource: BEGIN //with source
        cutlist_path := extractFilePath(MovieInfo.current_filename);
      END;
    smGivenDir: BEGIN //in given Dir
        cutlist_path := IncludeTrailingPathDelimiter(Settings.CutlistSaveDir);
      END;
  ELSE BEGIN //with source
      cutlist_path := extractFilePath(MovieInfo.current_filename);
    END;
  END;

  CutlistOpenDialog.InitialDir := cutlist_path;
  CutlistOpenDialog.FileName := cutlist_filename;
  CutlistOpenDialog.Options := CutlistOpenDialog.Options + [ofNoChangeDir];
  IF self.CutlistOpenDialog.Execute THEN BEGIN
    filename := self.CutlistOpenDialog.FileName;
    CutlistMode_old := cutlist.Mode;
    cutlist.LoadFromFile(filename);
    IF CutlistMode_old <> cutlist.Mode THEN BEGIN
      newCutlist := cutlist.convert;
      newCutlist.RefreshCallBack := cutlist.RefreshCallBack;
      FreeAndNIL(cutlist);
      cutlist := newCutlist;
      cutlist.RefreshGUI;
    END;
  END;
END;

PROCEDURE TFMain.InitVideo;
VAR
  _ARw, _ARh                       : integer;
  frame_duration                   : double;
  _dur_time, _dur_frames           : int64;
  APin                             : IPin;
  MediaType                        : TAMMediaType;
  pVIH                             : ^VIDEOINFOHEADER;
  pVIH2                            : ^VIDEOINFOHEADER2;
  filter                           : IBaseFilter;
  BasicVIdeo2                      : IBasicVideo2;
  arx, ary                         : integer;
BEGIN
  IF FilterGraph.Active THEN BEGIN
    IF succeeded(filtergraph.QueryInterface(IMediaSeeking, Seeking)) THEN BEGIN
      {if succeeded(seeking.IsFormatSupported(TIME_FORMAT_FRAME)) then begin
        seeking.SetTimeFormat(TIME_FORMAT_FRAME);
      end;                              }//does not work ???
      seeking.GetTimeFormat(MovieInfo.TimeFormat);
      seeking.GetDuration(_dur_time);
      MovieInfo.current_file_duration := _dur_time;
      IF isEqualGUID(MovieInfo.TimeFormat, TIME_FORMAT_MEDIA_TIME) THEN
        MovieInfo.current_file_duration := MovieInfo.current_file_duration / 10000000;
    END ELSE seeking := NIL;

    IF succeeded(filtergraph.QueryInterface(IMediaEvent, MediaEvent)) THEN BEGIN
    END ELSE MediaEvent := NIL;

    //detect ratio

    MovieInfo.nat_w := 0;
    MovieInfo.nat_h := 0;
    MovieInfo.ratio := 4 / 3;

    IF succeeded(filtergraph.QueryInterface(IBasicVideo, BasicVideo)) THEN BEGIN
      BasicVideo.get_VideoWidth(MovieInfo.nat_w);
      BasicVideo.get_VideoHeight(MovieInfo.nat_h);
      IF (MovieInfo.nat_w > 0) AND (MovieInfo.nat_h > 0) THEN
        MovieInfo.ratio := MovieInfo.nat_w / MovieInfo.nat_h;
      IF MovieInfo.frame_duration = 0 THEN
        IF Succeeded(BasicVideo.get_AvgTimePerFrame(frame_duration)) THEN BEGIN
          MovieInfo.frame_duration := frame_duration;
          MovieInfo.frame_duration_source := 'B';
        END;
    END;

    IF succeeded(filtergraph.QueryInterface(IBasicVideo2, BasicVideo2)) THEN BEGIN
      BasicVideo2.GetPreferredAspectRatio(arx, ary);
      IF (arx > 0) AND (ary > 0) THEN
        MovieInfo.ratio := arx / ary;
    END;

    IF succeeded(videoWindow.QueryInterface(IVMRWindowlessControl9, VMRWindowlessControl9)) THEN BEGIN
      VMRWindowlessControl9.GetNativeVideoSize(MovieInfo.nat_w, MovieInfo.nat_h, _ARw, _ARh);
      IF (MovieInfo.nat_w > 0) AND (MovieInfo.nat_h > 0) THEN
        MovieInfo.ratio := MovieInfo.nat_W / MovieInfo.nat_h;
    END ELSE BEGIN
      IF succeeded(videoWindow.QueryInterface(IVMRWindowlessControl, VMRWindowlessControl)) THEN BEGIN
        VMRWindowlessControl.GetNativeVideoSize(MovieInfo.nat_w, MovieInfo.nat_h, _ARw, _ARh);
        IF (MovieInfo.nat_w > 0) AND (MovieInfo.nat_h > 0) THEN
          MovieInfo.ratio := MovieInfo.nat_W / MovieInfo.nat_h;
      END ELSE BEGIN
        VMRWindowlessControl := NIL;
      END;
    END;

    IF MovieInfo.frame_duration = 0 THEN BEGIN
      IF succeeded(videowindow.QueryInterface(IBaseFilter, filter)) THEN BEGIN
        APin := getInPin(filter, 0);
        APin.ConnectionMediaType(MediaType);
        IF isEqualGUID(MediaType.formattype, FORMAT_VideoInfo2) THEN BEGIN
          // self.Label13.Caption := 'Format VideoInfo2';
          IF Mediatype.cbFormat >= sizeof(VIDEOINFOHEADER2) THEN BEGIN
            pVIH2 := mediatype.pbFormat;
            MovieInfo.frame_duration := pVIH2^.AvgTimePerFrame / 10000000;
            MovieInfo.frame_duration_source := 'V';
            //dwFourCC := pVIH2^.bmiHeader.biCompression;
          END;
        END ELSE BEGIN
          IF isEqualGUID(MediaType.formattype, FORMAT_VideoInfo) THEN BEGIN
            // self.Label13.Caption := 'Format VideoInfo';
            IF Mediatype.cbFormat >= sizeof(VIDEOINFOHEADER) THEN BEGIN
              pVIH := mediatype.pbFormat;
              MovieInfo.frame_duration := pVIH^.AvgTimePerFrame / 10000000;
              MovieInfo.frame_duration_source := 'v';
              //dwFourCC := pVIH^.bmiHeader.biCompression;
            END;
          END;
        END;
        // samplegrabber.SetBMPCompatible(@MediaType, 32);
        freeMediaType(@MediaType);
      END
      ELSE IF NOT batchmode THEN
        showmessage('Could not retrieve Renderer Filter.');
    END;

    IF MovieInfo.frame_duration = 0 THEN BEGIN
      //try calculating
      IF succeeded(seeking.IsFormatSupported(TIME_FORMAT_MEDIA_TIME))
        AND succeeded(seeking.IsFormatSupported(TIME_FORMAT_FRAME)) THEN BEGIN
        seeking.SetTimeFormat(TIME_FORMAT_MEDIA_TIME);
        seeking.GetDuration(_dur_time);
        seeking.SetTimeFormat(TIME_FORMAT_FRAME);
        seeking.GetDuration(_dur_frames);
        IF (_dur_frames > 0) AND (_dur_time <> _dur_frames) THEN BEGIN
          MovieInfo.frame_duration_source := 'D';
          MovieInfo.frame_duration := (_dur_time / 10000000) / _dur_frames
        END;
        seeking.SetTimeFormat(MovieInfo.TimeFormat)
      END;
    END;

    //default if nothing worked so far
    IF MovieInfo.frame_duration = 0 THEN BEGIN
      MovieInfo.frame_duration_source := 'F';
      MovieInfo.frame_duration := 0.04;
    END;

    self.OpenCutlist.Enabled := true;
    self.ASearchCutlistByFileSize.Enabled := true;
    self.LDuration.Caption := IntToStr(MovieInfo.FrameCount) + ' / '
      + MovieInfo.FormatPosition(MovieInfo.current_file_duration);

    MovieInfo.CanStepForward := false;
    IF succeeded(FilterGraph.QueryInterface(IVideoFrameStep, FrameStep)) THEN BEGIN
      IF FrameStep.CanStep(0, NIL) = S_OK THEN
        MovieInfo.CanStepForward := true;
    END ELSE FrameStep := NIL;
    self.EnableMovieControls(true);
  END;
  //HG
  self.BtnScanToEnd.Enabled := true; // enable scan to button
  //HG
END;

PROCEDURE TFMain.JumpTo(NewPosition: double);
VAR
  _pos                             : int64;
  event                            : Integer;
BEGIN
  IF NOT MovieInfo.MovieLoaded THEN
    exit;
  IF NewPosition < 0 THEN
    NewPosition := 0;
  IF NewPosition > MovieInfo.current_file_duration THEN
    NewPosition := MovieInfo.current_file_duration;

  IF isEqualGUID(MovieInfo.TimeFormat, TIME_FORMAT_MEDIA_TIME) THEN
    _pos := round(NewPosition * 10000000)
  ELSE
    _pos := round(NewPosition);
  seeking.SetPositions(_pos, AM_SEEKING_AbsolutePositioning,
    _pos, AM_SEEKING_NoPositioning);
  //filtergraph.State
  MediaEvent.WaitForCompletion(500, event);
  TBFilePos.TriggerTimer;
END;

FUNCTION TFMain.CurrentPosition: double;
VAR
  _pos                             : int64;
BEGIN
  {  result := MovieInfo.current_position_seconds;}
  result := 0;
  //if not assigned(seeking) then exit;
  IF succeeded(seeking.GetCurrentPosition(_pos)) THEN BEGIN
    IF isEqualGUID(MovieInfo.TimeFormat, TIME_FORMAT_MEDIA_TIME) THEN
      result := _pos / 10000000
    ELSE
      result := _pos;
  END;
END;




PROCEDURE TFMain.TBFilePosTimer(sender: TObject; CurrentPos,
  StopPos: Cardinal);
VAR
  TrueRate                         : double;
BEGIN
  TrueRate := CalcTrueRate(self.TBFilePos.TimerInterval / 1000);
  IF TrueRate > 0 THEN
    self.LTrueRate.Caption := '[' + floattostrF(TrueRate, ffFixed, 15, 3) + 'x]'
  ELSE
    self.LTrueRate.Caption := '[ ? x]';
  self.LPos.Caption := IntToStr(Trunc(currentPosition / MovieInfo.frame_duration)) + ' / '
    + MovieInfo.FormatPosition(currentPosition);
END;

PROCEDURE TFMain.TBFilePosChange(Sender: TObject);
BEGIN
  IF self.TBFilePos.IsMouseDown THEN BEGIN
    self.LPos.Caption := IntToStr(Trunc(self.TBFilePos.position / MovieInfo.frame_duration)) + ' / '
      + MovieInfo.FormatPosition(self.TBFilePos.position) //;
  END
END;

PROCEDURE TFMain.FilterGraphGraphStepComplete(Sender: TObject);
BEGIN
  self.LPos.Caption := IntToStr(Trunc(currentPosition / MovieInfo.frame_duration)) + ' / '
    + MovieInfo.FormatPosition(currentPosition);
  self.StepComplete := true;
END;

PROCEDURE TFMain.TBFilePosPositionChangedByMouse(Sender: TObject);
VAR
  event                            : integer;
BEGIN
  MEdiaEvent.WaitForCompletion(500, event);
  self.LPos.Caption := IntToStr(Trunc(currentPosition / MovieInfo.frame_duration)) + ' / '
    + MovieInfo.FormatPosition(currentPosition);

  //HG
  TrackMWheelFine.SetFocus;
  //HG

END;

PROCEDURE TFMain.TFinePosChange(Sender: TObject);
BEGIN




  IF (self.TFinePos.Position = 0) THEN BEGIN
    self.BStepBack.Caption := 'II<';
    self.BStepForwards.Caption := '>II';
  END ELSE

    IF (self.TFinePos.Position < 0) THEN BEGIN
      self.BStepBack.Caption := inttostr(self.TFinePos.Position * -1);
      self.TFinePos.PageSize := self.TFinePos.Position * -1;

    END ELSE BEGIN
      self.BStepForwards.Caption := inttostr(self.TFinePos.Position);
      self.TFinePos.PageSize := self.TFinePos.Position;

    END;


END;

PROCEDURE TFMain.FormClose(Sender: TObject; VAR Action: TCloseAction);
BEGIN
  self.CloseMovie;

  DragAcceptFiles(self.Handle, false);
END;

PROCEDURE TFMain.SetStartPosition(Position: double);
BEGIN
  pos_from := Position;
  refresh_times;
END;

PROCEDURE TFMain.SetStopPosition(Position: double);
BEGIN
  pos_to := Position;
  refresh_times;
END;

PROCEDURE TFMain.InsertSampleGrabber;
VAR
  Rpin, Spin, TInPin, TOutPin1, TOutPin2, NRInPin, SGInPin, SGOutPin: IPin;
BEGIN

  IF NOT FilterGraph.Active THEN exit;

  TeeFilter.FilterGraph := filtergraph;
  SampleGrabber1.FilterGraph := filtergraph;
  NullRenderer1.FilterGraph := filtergraph;

  TRY
    //Disconnect Video Window
    OleCheck(GetPin((VideoWindow AS IBaseFilter), PINDIR_INPUT, 0, Rpin));
    OleCheck(Rpin.ConnectedTo(Spin));
    OleCheck((FilterGraph AS IGraphBuilder).Disconnect(Rpin));
    OleCheck((FilterGraph AS IGraphBuilder).Disconnect(Spin));

    //Get Pins
    OleCheck(GetPin((SampleGrabber1 AS IBaseFilter), PINDIR_INPUT, 0, SGInpin));
    OleCheck(GetPin((SampleGrabber1 AS IBaseFilter), PINDIR_OUTPUT, 0, SGOutpin));
    OleCheck(GetPin((NullRenderer1 AS IBaseFilter), PINDIR_INPUT, 0, NRInpin));
    OleCheck(GetPin((TeeFilter AS IBaseFilter), PINDIR_INPUT, 0, TInpin));
    OleCheck(GetPin((TeeFilter AS IBaseFilter), PINDIR_OUTPUT, 0, TOutpin1));

    //Establish Connections
    OleCheck((FilterGraph AS IGraphBuilder).Connect(Spin, Tinpin)); // Decomp. to Tee
    OleCheck((FilterGraph AS IGraphBuilder).Connect(Toutpin1, Rpin)); //Tee to VideoRenderer
    OleCheck(GetPin((TeeFilter AS IBaseFilter), PINDIR_OUTPUT, 1, TOutpin2)); //GEt new OutputPin of Tee
    //    OleCheck(GetPin((TeeFilter as IBaseFilter), PINDIR_OUTPUT, 1, TOutpin2)); //GEt new OutputPin of Tee
    OleCheck((FilterGraph AS IGraphBuilder).Connect(Toutpin2, SGInpin)); //Tee to SampleGrabber
    OleCheck((FilterGraph AS IGraphBuilder).Connect(SGoutpin, NRInpin)); //SampleGrabber to Null

  EXCEPT
    filtergraph.ClearGraph;
    filtergraph.active := false;
    RAISE;
  END;
END;

FUNCTION TFMain.WaitForStep(TimeOut: INteger): boolean;
VAR
  interval                         : integer;
  startTick, nowTick, lastTick     : Cardinal;
BEGIN
  lastTick := GetTickCount;
  startTick := lastTick;

  IF Settings.AutoMuteOnSeek THEN
    interval := 10
  ELSE
    interval := Max(10, Trunc(MovieInfo.frame_duration * 1000.0));

  WHILE (NOT self.StepComplete) DO BEGIN
    sleep(interval);
    nowTick := GetTickCount;
    IF (self.StepComplete) OR (Abs(startTick - nowTick) > TimeOut) THEN
      break;
    application.ProcessMessages;
  END;
  result := self.StepComplete;
END;

PROCEDURE TFMain.PanelVideoWindowResize(Sender: TObject);
VAR
  movie_ar, my_ar                  : double;
BEGIN
  movie_ar := MovieInfo.ratio;
  my_ar := self.PanelVideoWindow.Width / self.PanelVideoWindow.Height;
  IF my_ar > movie_ar THEN BEGIN
    self.VideoWindow.Height := self.PanelVideoWindow.Height;
    self.VideoWindow.Width := round(self.videowindow.Height * movie_ar);
  END ELSE BEGIN
    self.VideoWindow.Width := self.PanelVideoWindow.Width;
    self.VideoWindow.Height := round(self.VideoWindow.Width / movie_ar);
  END;
END;

PROCEDURE TFMain.ShowFrames(startframe, endframe: Integer);
//startframe, endframe relative to current frame
VAR
  iImage, count                    : integer;
  pos, temp_pos                    : double;
  Target                           : TCutFrame;
BEGIN
  count := FFrames.Count;
  IF endframe < startframe THEN exit;
  WHILE endframe - startframe + 1 > count DO BEGIN
    IF - startframe > endframe THEN
      startframe := startframe + 1
    ELSE
      endframe := endframe - 1;
  END;

  pos := currentPosition;
  temp_pos := pos + (startframe - 0) * MovieInfo.frame_duration;
  IF (temp_pos > MovieInfo.current_file_duration) THEN
    temp_pos := MovieInfo.current_file_duration;
  IF temp_pos < 0 THEN
    temp_pos := 0;

  FFrames.Show;

  JumpTo(temp_pos);
  // Mute sound ?
  IF Settings.AutoMuteOnSeek AND NOT CBMute.Checked THEN
    FilterGraph.Volume := 0;
  FFrames.CanClose := false;
  TRY
    FOR iImage := 0 TO endframe - startframe DO BEGIN
      Target := FFrames.Frame[iImage];
      IF (temp_pos >= 0) AND (temp_pos <= MovieInfo.current_file_duration) THEN BEGIN

        self.StepComplete := false;
        Target.DisableUpdate;
        TRY
          SampleTarget := Target; //Set SampleTarget to trigger sampleGrabber.onbuffer method;
          IF Assigned(Framestep) THEN BEGIN
            IF NOT Succeeded(FrameStep.Step(1, NIL)) THEN
              break;
            IF NOT WaitForStep(5000) THEN
              break;
          END ELSE BEGIN
            temp_pos := temp_pos + MovieInfo.frame_duration;
            JumpTo(temp_pos);
            WaitForFiltergraph;
          END;

          temp_pos := currentPosition;
          Target.image.visible := true;
        FINALLY
          Target.EnableUpdate;
        END;
      END ELSE BEGIN
        Target.image.visible := false;
        Target.position := 0;
      END;
    END;
  FINALLY
    FFrames.CanClose := true;
    // Restore sound
    IF Settings.AutoMuteOnSeek AND NOT CBMute.Checked THEN
      FilterGraph.Volume := TVolume.Position;
    JumpTo(pos);
  END;
END;

PROCEDURE TFMain.ShowFramesAbs(startframe, endframe: double;
  numberOfFrames: Integer);
//starframe, endframe: absolute position.
VAR
  iImage                           : integer;
  //  counter: integer;
  pos, temp_pos, distance          : double;
  Target                           : TCutFrame;
BEGIN
  IF endframe <= startframe THEN exit;
  startframe := ensureRange(startframe, 0, MovieInfo.current_file_duration);
  endframe := ensureRange(endframe, 0, MovieInfo.current_file_duration - MovieInfo.frame_duration);

  numberOfFrames := FFrames.Count;
  distance := (endframe - startframe) / (numberofFrames - 1);

  FilterGraph.Pause;
  WaitForFiltergraph;

  pos := currentPosition;
  FFrames.Show;

  // Mute sound ?
  IF Settings.AutoMuteOnSeek AND NOT CBMute.Checked THEN
    FilterGraph.Volume := 0;
  FFrames.CanClose := false;

  TRY
    FOR iImage := 0 TO numberOfFrames - 1 DO BEGIN
      Target := FFrames.Frame[iImage];
      temp_pos := startframe + (iImage * distance);
      IF (temp_pos >= 0) AND (temp_pos <= MovieInfo.current_file_duration) THEN BEGIN
        SampleTarget := Target; //set sampleTarget to trigger samplegrabber.onbuffer method
        JumpTo(temp_pos);
        WaitForFiltergraph;

        Target.image.visible := true;
      END ELSE BEGIN
        Target.image.visible := false;
        Target.position := 0;
      END;
    END;
  FINALLY
    FFrames.CanClose := true;
    // Restore sound
    IF Settings.AutoMuteOnSeek AND NOT CBMute.Checked THEN
      FilterGraph.Volume := TVolume.Position;
    JumpTo(pos);
  END;
END;

PROCEDURE TFMain.WaitForFilterGraph;
VAR
  pfs                              : TFilterState;
  hr                               : hresult;
BEGIN
  REPEAT
    hr := (FilterGraph AS IMediaControl).GetState(50, pfs);
  UNTIL (hr = S_OK) OR (hr = E_FAIL);
END;

PROCEDURE TFMain.BConvertClick(Sender: TObject);
VAR
  newCutlist                       : TCutlist;
BEGIN
  IF cutlist.Count = 0 THEN exit;
  newCutlist := cutlist.convert;
  newCutlist.RefreshCallBack := cutlist.RefreshCallBack;
  FreeAndNIL(cutlist);
  cutlist := newCutlist;
  cutlist.RefreshGUI;
END;

PROCEDURE TFMain.ShowMetaData;
CONST
  stream                           = $0;
VAR
  //    MetaEditor: IWMMetadataEditor;
  HeaderInfo                       : IWMHeaderInfo;
  _text                            : STRING;
  value                            : PACKED ARRAY OF byte;
  _name                            : ARRAY OF WideChar;
  name_len, attr_len               : word;
  iFilter, iAttr, iByte            : integer;
  found                            : boolean;
  filterlist                       : TFilterlist;
  sourceFilter                     : IBaseFilter;
  attr_datatype                    : wmt_attr_datatype;
  CAttributes                      : word;
  _stream                          : word;
BEGIN
  IF (MovieInfo.current_filename = '') OR (NOT MovieInfo.MovieLoaded) THEN exit;

  frmMemoDialog.Caption := 'Movie Meta Data';
  frmMemoDialog.memInfo.Clear;
  frmMemoDialog.memInfo.Lines.Add('Filetype: ' + MovieInfo.MovieTypeString);
  frmMemoDialog.memInfo.Lines.Add('Cut application: ' + Settings.GetCutAppName(MovieInfo.MovieType));
  frmMemoDialog.memInfo.Lines.Add('Filename: ' + MovieInfo.current_filename);
  frmMemoDialog.memInfo.Lines.Add('Frame Rate: ' + FloatToStrF(1 / MovieInfo.frame_duration, ffFixed, 15, 4));

  IF MovieInfo.MovieType IN [mtAVI, mtHQAvi] THEN BEGIN
    frmMemoDialog.memInfo.Lines.Add('Video FourCC: ' + fcc2string(MovieInfo.FFourCC));
  END;
  IF MovieInfo.MovieType IN [mtWMV] THEN BEGIN
    filterlist := tfilterlist.Create;
    filterlist.Assign(filtergraph AS IFiltergraph);
    found := false;
    FOR iFilter := 0 TO filterlist.Count - 1 DO BEGIN
      IF STRING(filterlist.FilterInfo[iFilter].achName) = MovieInfo.current_filename THEN BEGIN
        sourcefilter := filterlist.Items[iFilter];
        found := true;
        break;
      END;
    END;
    IF found THEN BEGIN
      TRY
        //   wmcreateeditor
        //   (FIltergraph as IFiltergraph).FindFilterByName(pwidechar(current_filename), sourceFilter);
        //   (sourceFIlter as iammediacontent).get_AuthorName(pwidechar(author));
        IF succeeded(sourcefilter.QueryInterface(IwmHeaderInfo, HEaderINfo)) THEN BEGIN
          HeaderInfo := (sourceFilter AS IwmHeaderInfo);
          HeaderInfo.GetAttributeCount(stream, CAttributes);
          _stream := stream;
          FOR iAttr := 0 TO CAttributes - 1 DO BEGIN
            HeaderInfo.GetAttributeByIndex(iAttr, _stream, NIL, name_len, attr_datatype, NIL, attr_len);
            setlength(_name, name_len);
            setlength(value, attr_len);
            HeaderInfo.GetAttributeByIndex(iAttr, _stream, pwidechar(_name), name_len, attr_datatype, PByte(value), attr_len);
            CASE attr_datatype OF
              WMT_TYPE_STRING: _text := WideChartoString(PWideChar(value));
              WMT_TYPE_WORD: BEGIN
                  _text := inttostr(word(PWord(addr(value[0]))^));
                END;
              WMT_TYPE_DWORD: BEGIN
                  _text := intTostr(dword(PDWord(addr(value[0]))^));
                END;
              WMT_TYPE_QWORD: BEGIN
                  _text := intTostr(int64(PULargeInteger(addr(value[0]))^));
                END;
              WMT_TYPE_BOOL: BEGIN
                  IF LongBool(PDword(addr(value[0]))^) THEN _text := 'true' ELSE _text := 'false';
                END;
              WMT_TYPE_BINARY: BEGIN
                  _text := #13#10;
                  FOR iByte := 0 TO attr_len - 1 DO BEGIN
                    _text := _text + inttohex(value[iByte], 2) + ' ';
                    IF iByte MOD 8 = 7 THEN _text := _text + ' ';
                    IF iByte MOD 16 = 15 THEN _text := _text + #13#10;
                  END;
                END;
              WMT_TYPE_GUID: BEGIN
                  _text := GuidToString(PGUID(value[0])^);
                END;
            ELSE _text := '***unknown data format***';
            END;
            _text := widechartoString(PWidechar(_name)) + ': ' + _text;
            frmMemoDialog.memInfo.Lines.Add(_text);
          END;
        END;
      FINALLY
        FreeAndNIL(filterlist);
      END;
    END ELSE BEGIN
      frmMemoDialog.memInfo.Lines.Add('***Could not find interface***');
      FreeAndNIL(filterlist);
    END;
  END;
  frmMemoDialog.ShowModal;
END;

PROCEDURE TFMain.TBFilePosSelChanged(Sender: TObject);
BEGIN
  WITH FFrames DO BEGIN
    IF scan_1 <> -1 THEN BEGIN
      frame[scan_1].BorderVisible := false;
      scan_1 := -1;
    END;
    IF scan_2 <> -1 THEN BEGIN
      frame[scan_2].BorderVisible := false;
      scan_2 := -1;
    END;
  END;
  IF self.TBFilePos.SelEnd - self.TBFilePos.SelStart > 0 THEN
    AScanInterval.Enabled := true
  ELSE
    AScanInterval.Enabled := false;
END;

PROCEDURE TFMain.WMDropFiles(VAR message: TWMDropFiles);
VAR
  iFile, cFiles                    : uInt;
  FileName                         : ARRAY[0..255] OF Char;
  FileList                         : TStringList;
  FileString                       : STRING;
BEGIN
  FileList := TStringList.Create;
  TRY
    cFiles := DragQueryFile(message.Drop, $FFFFFFFF, NIL, 0);
    FOR iFile := 1 TO cFiles DO BEGIN
      DragQueryFile(message.Drop, iFile - 1, @FileName, uint(sizeof(FileName)));
      filestring := STRING(FileName);
      FileList.add(fileString);
    END;
    ProcessFileList(FileList, false);
  FINALLY
    FreeAndNIL(FileList);
  END;
  INHERITED;
END;

PROCEDURE TFMain.ProcessFileList(FileList: TStringList; IsMyOwnCommandLine: boolean);
VAR
  iString                          : INteger;
  Pstring, filename_movie, filename_cutlist, filename_upload_cutlist: STRING;
  upload_cutlist, found_movie, found_cutlist, get_empty_cutlist: boolean;
  //try_cutlist_download: boolean;
BEGIN
  found_movie := false;
  found_cutlist := false;
  upload_cutlist := false;
  //try_cutlist_download := false;
  Batchmode := false;
  TryCutting := false;
  get_empty_cutlist := false;
  FOR iString := 0 TO FileList.Count - 1 DO BEGIN
    Pstring := FileList[iString];
    IF AnsiStartsStr('-uploadcutlist:', ansilowercase(PString)) THEN BEGIN
      filename_upload_cutlist := AnsiMidStr(PString, 16, length(Pstring) - 15);
      upload_cutlist := true;
    END;
    IF AnsiStartsStr('-getemptycutlist:', ansilowercase(PString)) AND (NOT found_cutlist) THEN BEGIN
      filename_cutlist := AnsiMidStr(PString, 18, length(Pstring) - 17);
      found_cutlist := true;
      get_empty_cutlist := true;
    END;
    IF AnsiStartsStr('-exit', ansilowercase(PString)) THEN BEGIN
      IF IsMyOwnCommandLine THEN exit_after_commandline := true;
    END;
    IF AnsiStartsStr('-open:', ansilowercase(PString)) AND (NOT found_movie) THEN BEGIN
      filename_movie := AnsiMidStr(PString, 7, length(Pstring) - 6);
      IF fileexists(filename_movie) THEN found_movie := true;
    END;
    IF AnsiStartsStr('-batchmode', ansilowercase(PString)) THEN BEGIN
      IF IsMyOwnCommandLine THEN Batchmode := true;
    END;
    IF AnsiStartsStr('-trycutting', ansilowercase(PString)) THEN BEGIN
      TryCutting := true;
    END;
    {    if AnsiStartsStr('-trycutlistdownload', ansilowercase(PString)) and (not found_cutlist) then begin
          found_cutlist := true;
          try_cutlist_download := true;
        end; }
    IF AnsiStartsStr('-cutlist:', ansilowercase(PString)) AND (NOT found_cutlist) THEN BEGIN
      filename_cutlist := AnsiMidStr(PString, 10, length(Pstring) - 9);
      IF fileexists(filename_cutlist) THEN found_cutlist := true;
    END;
    IF fileexists(Pstring) THEN BEGIN
      IF ansilowercase(extractfileext(Pstring)) = cutlist_Extension THEN BEGIN
        IF NOT found_cutlist THEN BEGIN
          filename_cutlist := pstring;
          found_cutlist := true;
        END;
      END ELSE BEGIN
        IF NOT found_movie THEN BEGIN
          filename_movie := pstring;
          found_movie := true;
        END;
      END;
    END;
  END;

  IF upload_cutlist THEN BEGIN
    IF NOT UploadCutlist(filename_upload_cutlist) THEN ExitCode := 64
  END;

  IF found_movie THEN BEGIN
    IF NOT openfile(filename_movie) THEN
      IF IsMyOwnCommandLine THEN ExitCode := 1;
  END;

  IF get_empty_cutlist THEN BEGIN
    IF IsMyOwnCommandLine THEN ExitCode := 32;
    IF cutlist.EditInfo THEN BEGIN
      IF cutlist.SaveAs(filename_cutlist) THEN BEGIN
        ExitCode := 0;
        exit;
      END;
    END;
  END;

  IF found_cutlist THEN BEGIN
    IF MovieInfo.MovieLoaded THEN BEGIN
      {if try_cutlist_download then begin
        if not self.search_cutlist then begin
          if IsMyOwnCommandLine then ExitCode := 2;
          exit;
        end;
      end else begin }
      cutlist.LoadFromFile(filename_cutlist);
      {end;}
    END ELSE BEGIN
      IF NOT batchmode THEN
        showmessage('Can not load Cutlist. Please load movie first.');
    END;
  END;

  IF TryCutting THEN BEGIN
    IF MovieInfo.current_filename <> '' THEN BEGIN
      IF NOT StartCutting THEN
        IF IsMyOwnCommandLine THEN ExitCode := 128;
    END;
  END;
END;

PROCEDURE TFMain.SaveCutlistAsExecute(Sender: TObject);
BEGIN
  IF cutlist.Save(true) THEN
    IF NOT batchmode THEN
      ShowMessage('Cutlist saved successfully to' + #13#10 + cutlist.SavedToFilename);
END;

PROCEDURE TFMain.OpenMovieExecute(Sender: TObject);

  FUNCTION FilterStringFromExtArray(ExtArray: ARRAY OF STRING): STRING;
  VAR
    i                              : Integer;
  BEGIN
    result := '';
    FOR i := 0 TO length(ExtArray) - 1 DO BEGIN
      IF i > 0 THEN result := result + ';';
      result := result + '*' + ExtArray[i];
    END;
  END;

VAR
  OpenDialog                       : TOpenDialog;
  ExtList, ExtListAllSupported     : STRING;
BEGIN
  //if not AskForUserRating(cutlist) then exit;
  //if not cutlist.clear_after_confirm then exit;

  OpenDialog := TOpenDialog.Create(self);
  TRY
    OpenDialog.Options := OpenDialog.Options + [ofPathMustExist, ofFileMustExist];

    // Make Filter List
    ExtList := FilterStringFromExtArray(WMV_EXTENSIONS);
    ExtListAllSupported := extList;
    OpenDialog.Filter := 'Windows Media Files (' + ExtList + ')|' + ExtList;
    ExtList := FilterStringFromExtArray(AVI_EXTENSIONS);
    ExtListAllSupported := ExtListAllSupported + ';' + extList;
    OpenDialog.Filter := OpenDialog.Filter + '|AVI Files (' + ExtList + ')|' + ExtList;
    ExtList := FilterStringFromExtArray(MP4_EXTENSIONS);
    ExtListAllSupported := ExtListAllSupported + ';' + extList;
    OpenDialog.Filter := OpenDialog.Filter + '|MP4 Files (' + ExtList + ')|' + ExtList;
    OpenDialog.Filter := 'All Supported Files (' + ExtListAllSupported + ')|' + ExtListAllSupported + '|' + OpenDialog.Filter;
    OpenDialog.Filter := OpenDialog.Filter + '|All Files|*.*';
    OpenDialog.InitialDir := settings.CurrentMovieDir;
    IF OpenDialog.Execute THEN BEGIN
      settings.CurrentMovieDir := ExtractFilePath(openDialog.FileName);
      OpenFile(opendialog.FileName);
    END;

    //HG
    iActiveCut := -1; //reset active cut id
    self.BtnScanToEnd.Enabled := true; // enable scan to button
    //*HG
  FINALLY
    FreeAndNil(OpenDialog);
  END;

END;

PROCEDURE TFMain.OpenCutlistExecute(Sender: TObject);
BEGIN
  LoadCutlist;
END;

PROCEDURE TFMain.File_ExitExecute(Sender: TObject);
BEGIN
  self.Close;
END;

PROCEDURE TFMain.AddCutExecute(Sender: TObject);

VAR InsideStartPos, InsideEndPos   : double;
BEGIN

  // if we have set start or end outside a previous defined cut
  IF iActiveCut = -1 THEN BEGIN
    // start and end defined ??
    IF (pos_from <> 0) AND (pos_to <> 0) THEN BEGIN

      InsideStartPos := cutlist.NextCutPos(pos_from);
      InsideEndPos := cutlist.PreviousCutPos(pos_to);
      // is this a cut inside ??
      IF InsideStartPos < InsideEndPos THEN BEGIN
        // find which one to replace
        iActiveCut := cutlist.GetCutNr(InsideStartPos + MovieInfo.frame_duration);
      END;

      // is this a cut partially inside ??
      IF InsideStartPos = InsideEndPos THEN BEGIN
        // find which one to replace
        IF pos_from < InsideStartPos THEN BEGIN
          iActiveCut := cutlist.GetCutNr(InsideEndPos - MovieInfo.frame_duration);
        END;

        IF iActiveCut = -1 THEN BEGIN
          iActiveCut := cutlist.GetCutNr(InsideEndPos + MovieInfo.frame_duration);
        END;

      END;




    END;



  END;





  IF iActiveCut <> -1 THEN BEGIN

    cutlist.ReplaceCut(pos_from, pos_to, iActiveCut);
    pos_from := 0;
    pos_to := 0;
    refresh_times;
    self.pnlCutAdd.Color := clGradientInactiveCaption;
    self.AddCut.Enabled := false;
    self.pnlCutFrom.Color := clGradientInactiveCaption;
    self.pnlCutTo.Color := clGradientInactiveCaption;
  END
  ELSE
    IF cutlist.AddCut(pos_from, pos_to) THEN BEGIN
      pos_from := 0;
      pos_to := 0;
      refresh_times;
      self.pnlCutAdd.Color := clGradientInactiveCaption;
      self.AddCut.Enabled := false;
      self.pnlCutFrom.Color := clGradientInactiveCaption;
      self.pnlCutTo.Color := clGradientInactiveCaption;
    END;
END;

PROCEDURE TFMain.ReplaceCutExecute(Sender: TObject);
VAR
  dcut                             : integer;
BEGIN
  IF frmClist.Lcutlist.SelCount = 0 THEN BEGIN
    self.enable_del_buttons(false);
    exit;
  END;
  dcut := strtoint(frmClist.Lcutlist.Selected.caption);
  cutlist.ReplaceCut(pos_from, pos_to, dCut);
END;

PROCEDURE TFMain.EditCutExecute(Sender: TObject);
VAR
  dcut                             : integer;
BEGIN
  IF frmClist.Lcutlist.SelCount = 0 THEN BEGIN
    self.enable_del_buttons(false);
    exit;
  END;
  dcut := strtoint(frmClist.Lcutlist.Selected.caption);
  pos_from := cutlist[dcut].pos_from;
  pos_to := cutlist[dcut].pos_to;
  refresh_times;
END;

PROCEDURE TFMain.DeleteCutExecute(Sender: TObject);
BEGIN
  IF frmClist.Lcutlist.SelCount = 0 THEN BEGIN
    self.enable_del_buttons(false);
    exit;
  END;
  cutlist.DeleteCut(strtoint(frmClist.Lcutlist.Selected.caption));
END;

PROCEDURE TFMain.AShowFramesFormExecute(Sender: TObject);
BEGIN
  FFrames.Show;
END;

PROCEDURE TFMain.ANextFramesExecute(Sender: TObject);
VAR
  c                                : TCursor;
BEGIN
  IF NOT MovieInfo.MovieLoaded THEN
    exit;
  c := self.Cursor;
  TRY
    EnableMovieControls(false);
    self.Cursor := crHourGlass;
    application.ProcessMessages;
    showframes(1, FFrames.Count);
  FINALLY
    EnableMovieControls(true);
    self.Cursor := c;
  END;
END;

PROCEDURE TFMain.APrevFramesExecute(Sender: TObject);
VAR
  c                                : TCursor;
BEGIN
  IF NOT MovieInfo.MovieLoaded THEN
    exit;
  c := self.Cursor;
  TRY
    EnableMovieControls(false);
    self.Cursor := crHourGlass;
    application.ProcessMessages;
    showframes(-1 * FFrames.Count, -1);
  FINALLY
    EnableMovieControls(true);
    self.Cursor := c;
  END;
END;

PROCEDURE TFMain.AScanIntervalExecute(Sender: TObject);
VAR
  i1, i2                           : integer;
  pos1, pos2                       : double;
  c                                : TCursor;
BEGIN
  IF NOT MovieInfo.MovieLoaded THEN
    exit;
  i1 := FFrames.scan_1;
  i2 := FFrames.scan_2;

  IF (i1 = -1) OR (i2 = -1) THEN BEGIN
    pos1 := self.TBFilePos.SelStart;
    pos2 := self.TBFilePos.SelEnd;
  END ELSE BEGIN
    IF i1 > i2 THEN BEGIN
      i1 := i2;
      i2 := FFrames.scan_1;
    END;
    pos1 := FFrames.Frame[i1].position;
    FFrames.Frame[i1].BorderVisible := false;
    pos2 := FFrames.Frame[i2].position;
    FFrames.Frame[i2].BorderVisible := false;
  END;

  c := self.Cursor;
  self.Cursor := crHourGlass;
  TRY
    EnableMovieControls(false);
    self.AScanInterval.Enabled := false;
    self.BtnScanToEnd.Enabled := false;

    Application.ProcessMessages;

    showframesabs(pos1, pos2, FFrames.Count);
  FINALLY
    EnableMovieControls(true);
    self.AScanInterval.Enabled := true;
    self.BtnScanToEnd.Enabled := true;
    self.Cursor := c;
  END;
END;
























PROCEDURE TFMain.EditSettingsExecute(Sender: TObject);
BEGIN
  settings.edit;
  InitHttpProperties;
END;

PROCEDURE TFMain.AStartCuttingExecute(Sender: TObject);
BEGIN
  StartCutting;
END;

PROCEDURE TFMain.MovieMetaDataExecute(Sender: TObject);
BEGIN
  ShowMetaData;
END;

PROCEDURE TFMain.UsedFiltersExecute(Sender: TObject);
BEGIN
  FManageFilters.SourceGraph := FilterGraph;
  FManageFilters.ShowModal;
END;

PROCEDURE TFMain.AboutExecute(Sender: TObject);
BEGIN
  AboutBox.ShowModal();
END;

PROCEDURE ForceOpenRegKey(CONST reg: TRegistry; CONST key: STRING);
VAR
  path                             : STRING;
BEGIN
  IF NOT reg.OpenKey(key, true) THEN BEGIN
    IF AnsiStartsStr('\', key) THEN path := key
    ELSE path := reg.CurrentPath + '\' + key;

    RAISE ERegistryException.Create('Unable to open key "' + path + '".');
  END;
END;

PROCEDURE TFMain.WriteToRegistyExecute(Sender: TObject);
VAR
  reg                              : TRegistry;
  myDir                            : STRING;
BEGIN
  myDir := application.ExeName;
  reg := Tregistry.Create;
  TRY
    TRY
      reg.RootKey := HKEY_CLASSES_ROOT;
      ForceOpenRegKey(reg, '\' + cutlist_Extension);
      reg.WriteString('', CutlistID);
      reg.WriteString('Content Type', CUTLIST_CONTENT_TYPE);
      reg.CloseKey;

      ForceOpenRegKey(reg, '\' + CutlistID);
      reg.WriteString('', 'Cutlist for Cut Assistant');
      ForceOpenRegKey(reg, 'DefaultIcon');
      reg.WriteString('', '"' + myDir + '",0');
      reg.CloseKey;

      ForceOpenRegKey(reg, '\' + CutlistID + '\Shell\open');
      reg.WriteString('', 'Open with Cut Assistant');
      ForceOpenRegKey(reg, 'command');
      reg.WriteString('', '"' + myDir + '" -cutlist:"%1"');
      reg.CloseKey;

      ForceOpenRegKey(reg, '\WMVFile\Shell\' + ShellEditKey);
      reg.WriteString('', 'Edit with Cut Assistant');
      ForceOpenRegKey(reg, 'command');
      reg.WriteString('', '"' + myDir + '" -open:"%1"');
      reg.CloseKey;

      ForceOpenRegKey(reg, '\AVIFile\Shell\' + ShellEditKey);
      reg.WriteString('', 'Edit with Cut Assistant');
      ForceOpenRegKey(reg, 'command');
      reg.WriteString('', '"' + myDir + '" -open:"%1"');
      reg.CloseKey;

      ForceOpenRegKey(reg, '\QuickTime.mp4\Shell\' + ShellEditKey);
      reg.WriteString('', 'Edit with Cut Assistant');
      ForceOpenRegKey(reg, 'command');
      reg.WriteString('', '"' + myDir + '" -open:"%1"');
      reg.CloseKey;

      ForceOpenRegKey(reg, '\Applications\' + ProgID + '\shell\open');
      reg.WriteString('FriendlyAppName', 'Cut Assistant');
      ForceOpenRegKey(reg, 'command');
      reg.WriteString('', '"' + myDir + '" -open:"%1"');
      reg.CloseKey;
    FINALLY
      FreeAndNIL(reg);
    END;
  EXCEPT
    ON ERegistryException DO
      ShowExpectedException('registering application.');
  END;
END;

PROCEDURE TFMain.RemoveRegistryEntriesExecute(Sender: TObject);
VAR
  reg                              : TRegistry;
  myDir                            : STRING;
BEGIN
  myDir := application.ExeName;
  reg := Tregistry.Create;
  TRY
    TRY
      reg.RootKey := HKEY_CLASSES_ROOT;
      IF reg.OpenKey('\WMVFile\Shell', false) THEN BEGIN
        reg.DeleteKey(ShellEditKey);
        reg.CloseKey;
      END;

      IF reg.OpenKey('\AVIFile\Shell', false) THEN BEGIN
        reg.DeleteKey(ShellEditKey);
        reg.CloseKey;
      END;

      IF reg.OpenKey('\QuickTime.mp4\Shell', false) THEN BEGIN
        reg.DeleteKey(ShellEditKey);
        reg.CloseKey;
      END;

      IF reg.OpenKey('\Applications', false) THEN BEGIN
        reg.DeleteKey(ProgID);
        reg.CloseKey;
      END;

      reg.DeleteKey('\' + cutlist_Extension);
      reg.DeleteKey('\' + CutlistID);
    FINALLY
      FreeAndNIL(reg);
    END;
  EXCEPT
    ON ERegistryException DO
      ShowExpectedException('unregistering application.');
  END;
END;


PROCEDURE TFMain.CutlistUploadExecute(Sender: TObject);
VAR
  message_String                   : STRING;
BEGIN
  IF cutlist.HasChanged THEN BEGIN
    IF NOT cutlist.Save(false) THEN exit; //try to save it
  END;

  IF NOT fileexists(cutlist.SavedToFilename) THEN exit;

  message_string := 'Your Cutlist ' + #13#10 + cutlist.SavedToFilename + #13#10 +
    'will now be uploaded to the following site: ' + #13#10 + settings.url_cutlists_upload + #13#10 +
    'Continue?';
  IF NOT (application.messagebox(PChar(message_string), NIL, MB_YESNO + MB_ICONINFORMATION) = IDYES) THEN BEGIN
    exit;
  END;

  UploadCutlist(cutlist.SavedToFilename);
END;

PROCEDURE TFMain.AStepForwardExecute(Sender: TObject);
VAR
  event                            : integer;
BEGIN
  IF NOT (FilterGraph.State = gsPaused) THEN GraphPause;
  IF assigned(FrameStep) THEN BEGIN
    IF Settings.AutoMuteOnSeek AND NOT CBMute.Checked THEN
      FilterGraph.Volume := 0;
    FrameStep.Step(1, NIL);
    MediaEvent.WaitForCompletion(500, event);
    TBFilePos.TriggerTimer;
    IF Settings.AutoMuteOnSeek AND NOT CBMute.Checked THEN
      FilterGraph.Volume := TVolume.Position;
  END ELSE BEGIN
    self.AStepForward.Enabled := false;
  END;
END;

PROCEDURE TFMain.AStepBackwardExecute(Sender: TObject);
VAR
  timeToSkip                       : double;
BEGIN
  IF NOT (FilterGraph.State = gsPaused) THEN GraphPause;

  IF Sender = ALargeSkipBackward THEN
    timeToSkip := Settings.LargeSkipTime
  ELSE IF Sender = ASmallSkipBackward THEN
    timeToSkip := Settings.SmallSkipTime
  ELSE IF Sender = ALargeSkipForward THEN
    timeToSkip := -Settings.LargeSkipTime
  ELSE IF Sender = ASmallSkipForward THEN
    timeToSkip := -Settings.SmallSkipTime
  ELSE
    timeToSkip := MovieInfo.frame_duration;

  JumpTo(currentPosition - timeToSkip);
END;

PROCEDURE TFMain.BrowseWWWHelpExecute(Sender: TObject);
BEGIN
  ShellExecute(0, NIL, PChar(settings.url_help), '', '', SW_SHOWNORMAL);
END;

PROCEDURE TFMain.FormKeyDown(Sender: TObject; VAR Key: Word;
  Shift: TShiftState);
CONST
  VK_MEDIA_PLAY_PAUSE              = $B3;
BEGIN
  //  showmessage(inttostr(key));
  CASE key OF
    ord('K'), ord(' '), VK_MEDIA_PLAY_PAUSE: BEGIN
        GraphPlayPause;
        Key := 0;
      END;

  // HG Home or Pos1 Key sets begin of cut
    VK_HOME : BEGIN
        self.BSetFrom.click;
        Key := 0;
      END;

        // HG End  Key sets begin of cut
    VK_END : BEGIN
        self.BSetTo.click;
        Key := 0;
      END;

  END;

  //HG
  TrackMWheelFine.SetFocus;
  //HG



END;

PROCEDURE TFMain.FormCloseQuery(Sender: TObject; VAR CanClose: Boolean);
VAR
  message_string                   : STRING;
BEGIN
  IF cutlist.HasChanged THEN BEGIN
    message_string := 'Save changes in current cutlist?';
    CASE application.messagebox(PChar(message_string), 'Cutlist not saved', MB_YESNOCANCEL + MB_DEFBUTTON3 + MB_ICONQUESTION) OF
      IDYES: BEGIN
          CanClose := cutlist.Save(false); //Can Close if saved successfully
        END;
      IDNO: BEGIN
          CanClose := true;
        END;
    ELSE BEGIN
        CanClose := false;
      END;
    END;
  END;
END;

PROCEDURE TFMain.OpenCutlistHomeExecute(Sender: TObject);
BEGIN
  ShellExecute(0, NIL, PChar(settings.url_cutlists_home), '', '', SW_SHOWNORMAL);
END;

PROCEDURE TFMain.CloseMovie;
BEGIN
  IF filtergraph.Active THEN BEGIN
    filtergraph.Stop;
    filtergraph.Active := false;
    filtergraph.ClearGraph;
    samplegrabber1.FilterGraph := NIL;
    TeeFilter.FilterGraph := NIL;
    NullRenderer1.FilterGraph := NIL;
    //    AviDecompressor.FilterGraph := nil;
  END;
  MovieInfo.current_filename := '';
  MovieInfo.current_filesize := -1;
  MovieInfo.MovieLoaded := false;
  IF Assigned(FFrames) THEN BEGIN
    FFrames.HideFrames;
  END;

  ResetForm;
END;

FUNCTION TFMain.RepairMovie: boolean;
VAR
  filename_temp, file_ext, filename_damaged,
    command, AppPath, message_string: STRING;
  exitCode                         : DWord;
  selectFileDlg                    : TOpenDialog;
  CutApplication                   : TCutApplicationAsfbin;
BEGIN
  result := false;
  IF NOT (movieinfo.MovieType IN [mtWMV]) THEN exit;

  CutApplication := Settings.GetCutApplicationByName('Asfbin') AS TCutApplicationAsfbin;
  IF NOT assigned(CutApplication) THEN BEGIN
    IF NOT batchmode THEN
      showmessage('Could not get Object CutApplication Asfbin.');
    exit;
  END;

  IF MovieInfo.current_filename = '' THEN BEGIN
    selectFileDlg := TOpenDialog.Create(self);
    selectFileDlg.Filter := 'Asf Movie files|*.wmv;*.asf|All files|*.*';
    selectFileDlg.Options := selectFileDlg.Options + [ofPathMustExist, ofFileMustExist, ofNoChangeDir];
    selectFileDlg.Title := 'Select File to be repaired:';
    IF selectFileDlg.Execute THEN BEGIN
      filename_temp := selectFileDlg.FileName;
      FreeAndNIL(selectFileDlg);
    END ELSE BEGIN
      FreeAndNIL(selectFileDlg);
      exit;
    END;
  END ELSE BEGIN
    filename_temp := MovieInfo.current_filename;
  END;

  file_ext := extractfileExt(filename_temp);
  filename_damaged := changeFileExt(filename_temp, '.damaged' + file_ext);

  message_string := 'Current movie will be repaired using ' + extractFileName(CutApplication.Path) + '.' + #13#10 +
    'Original file will be saved as ' + #13#10 + filename_damaged + #13#10 +
    'Continue?';
  IF NOT (application.messagebox(PChar(message_string), NIL, MB_YESNO + MB_ICONINFORMATION) = IDYES) THEN BEGIN
    exit;
  END;

  CloseMovie;

  IF NOT renameFile(filename_temp, filename_damaged) THEN BEGIN
    IF NOT batchmode THEN
      showmessage('Could not rename original file. Abort.');
    exit;
  END;

  command := '-i "' + filename_damaged + '" -o "' + filename_temp + '"';
  AppPath := '"' + CutApplication.Path + '"';
  TRY
    result := STO_ShellExecute(AppPath, Command, INFINITE, false, exitCode);
  FINALLY
    {    if ExitCode > 0 then begin
          showmessage('Could not repair file. ExitCode = ' + inttostr(ExitCode));
          result := false;
        end;      }
    IF NOT result THEN BEGIN
      renameFile(filename_damaged, filename_temp);
    END;

    IF result THEN BEGIN
      message_string := 'Finished repairing movie. Open repaired movie now?';
      IF (application.messagebox(PChar(message_string), NIL, MB_YESNO + MB_ICONINFORMATION) = IDYES) THEN BEGIN
        self.OpenFile(filename_temp);
      END;
    END;
  END;
END;

PROCEDURE TFMain.ARepairMovieExecute(Sender: TObject);
BEGIN
  self.RepairMovie;
END;

PROCEDURE TFMain.ACutlistInfoExecute(Sender: TObject);
BEGIN
  cutlist.EditInfo;
END;

PROCEDURE TFMain.ASaveCutlistExecute(Sender: TObject);
BEGIN
  IF cutlist.Save(false) THEN
    IF NOT batchmode THEN
      showmessage('Cutlist saved successfully to' + #13#10 + cutlist.SavedToFilename);
END;

PROCEDURE TFMain.ACalculateResultingTimesExecute(Sender: TObject);
VAR
  selectFileDlg                    : TOpenDialog;
BEGIN
  IF (MovieInfo.target_filename = '') THEN BEGIN
    selectFileDlg := TOpenDialog.Create(self);
    TRY
      selectFileDlg.Filter := 'Supported Movie files|*.wmv;*.asf;*.avi|All files|*.*';
      selectFileDlg.Options := selectFileDlg.Options + [ofPathMustExist, ofFileMustExist, ofNoChangeDir];
      selectFileDlg.Title := 'Select File to check:';
      selectFileDlg.InitialDir := settings.CutMovieSaveDir;
      IF selectFileDlg.Execute THEN
        MovieInfo.target_filename := selectFileDlg.FileName
      ELSE
        Exit;
    FINALLY
      FreeAndNIL(selectFileDlg);
    END;
  END;

  IF NOT fileexists(MovieInfo.target_filename) THEN BEGIN
    IF NOT batchmode THEN
      showmessage('Movie File not found.');
  END ELSE BEGIN
    TRY
      IF NOT FResultingTimes.loadMovie(MovieInfo.target_filename) THEN BEGIN
        IF NOT batchmode THEN
          showmessage('Could not load cut movie.');
        exit;
      END;
      FResultingTimes.calculate(cutlist);
      FResultingTimes.Show;
    EXCEPT
      ON E: Exception DO
        IF NOT batchmode THEN
          ShowMessage('Could not load cut movie!'#13#10'Error: ' + E.Message);
    END;

  END;
END;

PROCEDURE TFMain.ShowCutlistWorkWindow(Sender: TObject);
VAR
  info                             : STRING;
  CutApplication                   : TCutApplicationBase;
BEGIN
  info := '';

  CutApplication := Settings.GetCutApplicationByMovieType(mtWMV);
  IF assigned(CutApplication) THEN BEGIN
    info := info + 'WMV Cut Application' + #13#10;
    info := info + CutApplication.InfoString + #13#10;
  END;

  CutApplication := Settings.GetCutApplicationByMovieType(mtAVI);
  IF assigned(CutApplication) THEN BEGIN
    info := info + 'AVI Cut Application' + #13#10;
    info := info + CutApplication.InfoString + #13#10;
  END;

  CutApplication := Settings.GetCutApplicationByMovieType(mtHQAVI);
  IF assigned(CutApplication) THEN BEGIN
    info := info + 'HQ AVI Cut Application' + #13#10;
    info := info + CutApplication.InfoString + #13#10;
  END;

  CutApplication := Settings.GetCutApplicationByMovieType(mtMP4);
  IF assigned(CutApplication) THEN BEGIN
    info := info + 'MP4 Cut Application' + #13#10;
    info := info + CutApplication.InfoString + #13#10;
  END;

  CutApplication := Settings.GetCutApplicationByMovieType(mtUnknown);
  IF assigned(CutApplication) THEN BEGIN
    info := info + 'Other Cut Application' + #13#10;
    info := info + CutApplication.InfoString + #13#10;
  END;

  //showmessage(info);
  frmMemoDialog.Caption := 'Cut Application Settings';
  frmMemoDialog.memInfo.Clear;
  frmMemoDialog.memInfo.Text := info;
  frmMemoDialog.ShowModal;
END;

FUNCTION TFMain.SearchCutlistsByFileSize_XML: boolean;
CONST
  php_name                         = 'getxml.php';
  command                          = '?ofsb=';
VAR
  url, error_message               : STRING;
  Response                         : STRING;
  Node, CutNode                    : TJCLSimpleXMLElems;
  idx                              : integer;
BEGIN
  result := false;
  IF (MovieInfo.current_filesize = 0) OR (MovieInfo.current_filename = '') THEN
    exit;
  Error_message := 'Unknown error.';

  url := settings.url_cutlists_home + php_name + command + inttostr(MovieInfo.current_filesize) + '&version=' + Application_Version;
  Result := DoHttpGet(url, false, error_message, Response);

  TRY
    IF result AND (Length(response) > 5) THEN BEGIN
      XMLResponse.LoadFromString(Response);
      FCutlistSearchResults.LLinklist.Clear;

      IF XMLResponse.Root.ChildsCount > 0 THEN BEGIN
        Node := XMLResponse.Root.Items;
        FOR idx := 0 TO node.Count - 1 DO BEGIN
          CutNode := node.Item[idx].Items;
          WITH FCutlistSearchResults.LLinklist.Items.Add DO BEGIN
            Caption := CutNode.ItemNamed['id'].Value;
            SubItems.Add(CutNode.ItemNamed['name'].Value);
            SubItems.Add(CutNode.ItemNamed['rating'].Value);
            SubItems.Add(CutNode.ItemNamed['ratingcount'].Value);
            SubItems.Add(CutNode.ItemNamed['ratingbyauthor'].Value);
            SubItems.Add(CutNode.ItemNamed['author'].Value);
            SubItems.Add(CutNode.ItemNamed['usercomment'].Value);
            SubItems.Add(CutNode.ItemNamed['actualcontent'].Value);
          END;
        END;
      END;

      IF FCutlistSearchResults.ShowModal = mrOK THEN BEGIN
        result := self.DownloadCutlistByID(FCutlistSearchResults.Llinklist.Selected.Caption, FCutlistSearchResults.Llinklist.Selected.SubItems[0]);
        IF result THEN BEGIN
          cutlist.IDOnServer := FCutlistSearchResults.Llinklist.Selected.Caption;
          cutlist.RatingOnServer := StrToFloatDef(FCutlistSearchResults.Llinklist.Selected.SubItems[1], -1);
          self.ASendRating.Enabled := true;
        END;
      END;
    END ELSE BEGIN
      IF NOT batchmode THEN
        showmessage('Search Cutlist by File Size: No Cutlist found.');
    END;
  EXCEPT
    ON E: EJclSimpleXMLError DO BEGIN
      Error_message := 'XML-Error while getting cutlist infos.'#13#10 + E.Message;
      IF NOT batchmode THEN
        ShowMessage(Error_Message);
    END;
  END;
END;

PROCEDURE TFMain.ASearchCutlistByFileSizeExecute(Sender: TObject);
BEGIN
  self.SearchCutlistsByFileSize_XML;
END;


FUNCTION TFMain.SendRating(Cutlist: TCutlist): boolean;
CONST
  php_name                         = 'rate.php';
  command                          = '?rate=';
VAR
  Response, Error_message, url     : STRING;
BEGIN
  result := false;
  IF cutlist.IDOnServer = '' THEN BEGIN
    ASendRating.Enabled := false;
    IF NOT batchmode THEN
      Showmessage('Current cutlist was not downloaded. Rating not possible.');
    exit;
  END ELSE BEGIN
    IF (cutlist.RatingOnServer >= 0.0) AND cutlist.RatingByAuthorPresent THEN
      FCutlistRate.SelectedRating := Round(cutlist.RatingByAuthor + cutlist.RatingOnServer)
    ELSE IF cutlist.RatingOnServer >= 0.0 THEN
      FCutlistRate.SelectedRating := Round(cutlist.RatingOnServer)
    ELSE IF cutlist.RatingByAuthorPresent THEN
      FCutlistRate.SelectedRating := cutlist.RatingByAuthor
    ELSE
      FCutlistRate.SelectedRating := -1;
    IF FCutlistRate.ShowModal = mrOK THEN BEGIN
      Error_message := 'Unknown error.';
      url := settings.url_cutlists_home
        + php_name + command + cutlist.IDOnServer
        + '&rating=' + inttostr(FCutlistRate.SelectedRating)
        + '&userid=' + settings.UserID
        + '&version=' + Application_Version;
      Result := DoHttpGet(url, true, Error_message, Response);

      IF result THEN BEGIN
        IF AnsiContainsText(Response, '<html>') THEN BEGIN
          cutlist.RatingSent := true;
          IF NOT batchmode THEN
            showmessage('Rating done.');
        END ELSE BEGIN
          IF NOT batchmode THEN
            showmessage('Answer from Server:' + #13#10 + leftstr(response, 255));
        END;
      END;
    END;
  END;
END;


PROCEDURE TFMain.ASendRatingExecute(Sender: TObject);
BEGIN
  self.SendRating(cutlist);
END;

PROCEDURE TFMain.SampleGrabber1Buffer(sender: TObject; SampleTime: Double;
  pBuffer: Pointer; BufferLen: Integer);
VAR
  Target                           : TCutFrame;
  //TargetBitmap: TBitmap;
BEGIN
  IF SampleTarget = NIL THEN exit;
  Target := (SampleTarget AS TCutFrame);
  TRY
    //SampleGrabber1.GetBitmap(Target.Image.Picture.Bitmap, pBuffer, BufferLen);
    self.CustomGetSampleGrabberBitmap(Target.Image.Picture.Bitmap, pBuffer, BufferLen);
    Target.position := SampleTime;
  FINALLY
    SampleTarget := NIL;
  END;
END;

PROCEDURE TFMain.LcutlistDblClick(Sender: TObject);
BEGIN
  self.EditCut.Execute;
END;

FUNCTION TFMain.UploadCutlist(filename: STRING): boolean;
VAR
  Request                          : THttpRequest;
  Response, Answer                 : STRING;
  Cutlist_id                       : Integer;
  lines                            : TStringList;
  begin_answer                     : integer;
BEGIN
  result := false;

  IF fileexists(filename) THEN BEGIN
    Request := THttpRequest.Create(
      settings.url_cutlists_upload,
      true,
      'Error uploading cutlist: ');
    Request.IsPostRequest := true;
    TRY
      WITH Request.PostData DO BEGIN
        AddFormField('MAX_FILE_SIZE', '1587200');
        AddFormField('confirm', 'true');
        AddFormField('type', 'blank');
        AddFormField('userid', settings.UserID);
        AddFormField('version', application_version);
        AddFile('userfile[]', filename, 'multipart/form-data');
      END;
      Result := DoHttpRequest(Request);
      Response := Request.Response;

      lines := TStringList.Create;
      lines.Delimiter := #10;
      lines.NameValueSeparator := '=';
      lines.DelimitedText := Response;
      IF TryStrToInt(lines.values['id'], Cutlist_id) THEN BEGIN
        AddUploadDataEntry(Now, extractFileName(filename), Cutlist_id);
        UploadDataEntries.SaveToFile(UploadData_Path(true));
      END;
      begin_answer := LastDelimiter(#10, response) + 1;
      Answer := midstr(response, begin_answer, length(response) - begin_answer + 1); //Last Line
      FreeAndNIL(lines);
      IF NOT batchmode THEN
        showmessage('Server responded:' + #13#10 + answer);
    FINALLY
      FreeAndNil(Request);
    END;
  END;
END;

PROCEDURE TFMain.ADeleteCutlistFromServerExecute(Sender: TObject);
VAR
  datestring                       : STRING;
  idx                              : integer;
  entry                            : STRING;
  FUNCTION NextField(VAR s: STRING; CONST d: Char): STRING;
  BEGIN
    Result := '';
    WHILE (s <> '') DO BEGIN
      IF s[1] = d THEN BEGIN
        Delete(s, 1, 1);
        Break;
      END;
      Result := Result + s[1];
      Delete(s, 1, 1);
    END;
  END;
BEGIN
  //Fill ListView
  FUploadList.LLinklist.Clear;
  FOR idx := 0 TO UploadDataEntries.Count - 1 DO BEGIN
    entry := Copy(UploadDataEntries.Strings[idx], 1, MaxInt);
    WITH FUploadList.LLinklist.Items.Add DO BEGIN
      Caption := NextField(entry, '=');
      SubItems.Add(NextField(entry, ';'));
      dateTimeToString(DateString, 'ddddd tt', StrToFloat(NextField(entry, ';')));
      SubItems.Add(DateString);
    END;
  END;

  //Show Dialog and delete cutlist
  IF (FUploadList.ShowModal = mrOK) AND (FUploadList.LLinklist.SelCount = 1) THEN BEGIN
    IF self.DeleteCutlistFromServer(FUploadList.LLinklist.Selected.Caption) THEN BEGIN
      //Success, so delete Record in upload list
      UploadDataEntries.Delete(FUploadList.LLinklist.ItemIndex);
      UploadDataEntries.SaveToFile(UploadData_Path(true));
    END;
  END;
END;

FUNCTION TFMain.DeleteCutlistFromServer(CONST cutlist_id: STRING): boolean;
CONST
  php_name                         = 'delete_cutlist.php';
VAR
  url, Response, Error_message, Answer, val: STRING;
  lines                            : TStringList;
BEGIN
  result := false;
  IF cutlist_id = '' THEN exit;

  Error_message := 'Unknown error.';
  url := settings.url_cutlists_home + php_name + '?'
    + 'cutlistid=' + cutlist_id
    + '&userid=' + settings.UserID
    + '&version=' + Application_Version;

  Result := DoHttpGet(url, true, Error_message, Response);

  IF Result AND (response <> '') THEN BEGIN
    lines := TStringList.Create;
    TRY
      lines.Delimiter := #10;
      lines.NameValueSeparator := '=';
      lines.DelimitedText := Response;
      val := lines.Values['RemovedFile'];

      IF val = '' THEN BEGIN
        Result := false;
        IF NOT batchmode THEN
          ShowMessage('Delete command sent to server, but received unexpected response from server.');
      END
      ELSE BEGIN
        IF val = '1' THEN BEGIN
          answer := answer + 'File removed.' + #13#10;
        END ELSE BEGIN
          answer := answer + 'File NOT removed.' + #13#10;
          result := false;
        END;
        IF lines.Values['removedentry'] = '1' THEN BEGIN
          answer := answer + 'Database entry removed.' + #13#10;
        END ELSE BEGIN
          answer := answer + 'Database entry NOT removed.' + #13#10;
          result := false;
        END;
        IF NOT batchmode THEN
          ShowMessage(answer);
      END;
    FINALLY
      FreeAndNil(lines);
    END;
  END;
END;

PROCEDURE TFMain.TBFilePosChannelPostPaint(Sender: TDSTrackBarEx;
  CONST ARect: TRect);
VAR
  scale                            : double;
  iCut                             : INteger;
  CutRect                          : TRect;
BEGIN
  IF MovieInfo.current_file_duration = 0 THEN exit;
  IF cutlist.Mode = clmCrop THEN
    TBFilePos.ChannelCanvas.Brush.Color := clgreen
  ELSE
    TBFilePos.ChannelCanvas.Brush.Color := clred;
  scale := (ARect.Right - ARect.Left) / MovieInfo.current_file_duration; //pixel per second
  CutRect := ARect;
  FOR iCut := 0 TO cutlist.Count - 1 DO BEGIN
    CutRect.Left := ARect.Left + round(Cutlist[iCut].pos_from * scale);
    CutRect.Right := ARect.Left + round(Cutlist[iCut].pos_to * scale);
    IF CutRect.right >= CutRect.Left THEN
      TBFilePos.ChannelCanvas.FillRect(CutRect);
  END;
END;

FUNCTION TFMain.AskForUserRating(Cutlist: TCutlist): boolean;
//true = user rated or decided not to rate, or no rating necessary
//false = abort operation
VAR
  message_string                   : STRING;
  userIsAuthor                     : boolean;
BEGIN
  result := false;
  userIsAuthor := Cutlist.Author = settings.UserName;
  IF (Cutlist.UserShouldSendRating) AND NOT userIsAuthor THEN BEGIN
    message_string := 'Please send a rating for the current cutlist. Would you like to do that now?';
    CASE (application.messagebox(PChar(message_string), NIL, MB_YESNOCANCEL + MB_ICONQUESTION)) OF
      IDYES: BEGIN
          result := self.SendRating(Cutlist);
        END;
      IDNO: result := true;
    END;
  END ELSE result := true;
END;

PROCEDURE TFMain.WMCopyData(VAR msg: TWMCopyData);
BEGIN
  HandleSendCommandline(msg.CopyDataStruct^, HandleParameter);
END;

PROCEDURE TFMain.AddUploadDataEntry(CutlistDate: TDateTime; CutlistName: STRING; CutlistID: Integer);
BEGIN
  UploadDataEntries.Add(Format('%d=%s;%f', [CutlistID, CutlistName, CutlistDate]));
END;

PROCEDURE TFMain.HandleParameter(CONST param: STRING);
VAR
  FileList                         : TStringLIst;
BEGIN
  FileList := TStringList.Create;
  TRY
    FileList.Text := param;
    self.ProcessFileList(FileList, false);
  FINALLY
    FreeAndNIL(FileList);
  END;
END;

FUNCTION TFMain.GraphPlayPause: boolean;
BEGIN
  IF filtergraph.State = gsPlaying THEN BEGIN
    result := GraphPause;
  END ELSE BEGIN
    result := GraphPlay;
  END;
END;

FUNCTION TFMain.GraphPause: boolean;
CONST
  CaptionPlay                      = '>';
  HintPlay                         = 'Play';
  {var
    event: integer;  }
BEGIN
  result := filtergraph.Pause;
  {if assigned(FrameStep) then begin
    FrameStep.Step(1, nil);
    MediaEvent.WaitForCompletion(500, event);
  end;              }
  self.APlayPause.Caption := CaptionPlay;
  self.APlayPause.Hint := HintPlay;
  self.BFF.Enabled := false;
  TBFilePos.TriggerTimer;
END;

FUNCTION TFMain.GraphPlay: boolean;
CONST
  CaptionPause                     = '||';
  HintPause                        = 'Pause';
BEGIN
  result := filtergraph.Play;
  IF result THEN BEGIN
    self.APlayPause.Caption := CaptionPause;
    self.APlayPause.Hint := HintPause;
    self.BFF.Enabled := true;
  END;
END;

PROCEDURE TFMain.VideoWindowClick(Sender: TObject);
BEGIN
  IF self.APlayPause.Enabled THEN
    self.APlayPause.Execute;
END;

PROCEDURE TFMain.TBRateChange(Sender: TObject);
VAR
  NewRate                          : double;
BEGIN
  NewRate := Power(2, (TBRate.Position / 8));
  filtergraph.Rate := newRate;

  LRate.Caption := floattostrF(filtergraph.Rate, ffFixed, 15, 3) + 'x';
END;

FUNCTION TFMain.CalcTrueRate(Interval: double): double;
//Interval: Interval since last call to CalcTrue Rate (same unit as current_position)
VAR
  pos, diff                        : double;
BEGIN
  result := 0;
  IF interval <= 0 THEN exit;

  pos := self.CurrentPosition;
  diff := pos - last_pos;
  last_pos := pos;
  IF diff > 0 THEN
    result := diff / Interval;
END;

PROCEDURE TFMain.LRateDblClick(Sender: TObject);
BEGIN
  TBRate.Position := 0;
END;

PROCEDURE TFMain.ANextCutExecute(Sender: TObject);
VAR
  NewPos                           : double;
BEGIN
  NewPos := cutlist.NextCutPos(currentPosition + MovieInfo.frame_duration);
  IF NewPos >= 0 THEN jumpTo(NewPos);
  TrackMWheelFine.SetFocus;
END;

PROCEDURE TFMain.APrevCutExecute(Sender: TObject);
VAR
  NewPos                           : double;
BEGIN
  NewPos := cutlist.PreviousCutPos(currentPosition - MovieInfo.frame_duration);
  IF NewPos >= 0 THEN jumpTo(NewPos);
  TrackMWheelFine.SetFocus;
END;

PROCEDURE TFMain.BFFMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
BEGIN
  self.FF_Start;
END;

PROCEDURE TFMain.FF_Start;
BEGIN
  filtergraph.Rate := filtergraph.Rate * 2;
END;

PROCEDURE TFMain.FF_Stop;
BEGIN
  self.TBRateChange(self);
END;

PROCEDURE TFMain.BFFMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
BEGIN
  self.FF_Stop;
END;
{
function TFMain.SampleCB(SampleTime: double;
  MediaSample: IMediaSample): HRESULT;
begin
  if assigned(SampleTarget) then begin
    (SampleTarget as TCutFrame).IsKeyFrame := succeeded(MediaSample.IsSyncPoint);
  end;
  Result := S_OK;
end;

function TFMain.BufferCB(SampleTime: Double; pBuffer: PByte;
  BufferLen: Integer): HResult;
begin
  Result := S_OK;
end;
}

PROCEDURE TFMain.VideoWindowDblClick(Sender: TObject);
BEGIN
  ToggleFullScreen;
END;

FUNCTION TFMain.ToggleFullScreen: boolean;
//returns true if mode is now fullscreen
BEGIN
  IF MovieInfo.MovieLoaded THEN self.VideoWindow.FullScreen := NOT self.VideoWindow.FullScreen;
  result := self.VideoWindow.FullScreen;
END;

PROCEDURE TFMain.AFullScreenExecute(Sender: TObject);
BEGIN
  self.AFullScreen.Checked := ToggleFullScreen;
END;

PROCEDURE TFMain.VideoWindowKeyDown(Sender: TObject; VAR Key: Word;
  Shift: TShiftState);
BEGIN
  IF (Key = VK_ESCAPE) AND self.VideoWindow.FullScreen THEN BEGIN
    self.AFullScreenExecute(Sender);
  END;
END;


PROCEDURE TFMain.ACloseMovieExecute(Sender: TObject);
BEGIN
  self.CloseMovieAndCutlist;
END;

FUNCTION TFMain.CloseMovieAndCutlist: boolean;
BEGIN
  result := false;
  IF NOT AskForUserRating(cutlist) THEN exit;
  IF NOT cutlist.clear_after_confirm THEN exit;
  IF movieInfo.MovieLoaded THEN CloseMovie;
  result := true;
END;

FUNCTION TFMain.DownloadCutlistByID(cutlist_id, TargetFileName: STRING): boolean;
CONST
  php_name                         = 'getfile.php';
  Command                          = '?id=';
VAR
  Cutlist_File                     : TextFile;
  message_string, error_message, Response: STRING;
  url, target_file, cutlist_path   : STRING;
BEGIN
  result := false;
  CASE Settings.SaveCutlistMode OF
    smWithSource: BEGIN //with source
        cutlist_path := extractFilePath(MovieInfo.current_filename);
      END;
    smGivenDir: BEGIN //in given Dir
        cutlist_path := includeTrailingBackslash(Settings.CutlistSaveDir);
      END;
  ELSE BEGIN //with source
      cutlist_path := extractFilePath(MovieInfo.current_filename);
    END;
  END;
  target_file := cutlist_path + TargetFileName;

  IF cutlist.HasChanged AND (NOT batchmode) THEN BEGIN
    message_string := 'Trying to download this cutlist:' + #13#10 + TargetFileName + '[ID=' + cutlist_id + ']' + #13#10 +
      'Existing cutlist is not saved and will be overwritten.' + #13#10 +
      'Continue?';
    IF NOT (application.messagebox(PChar(message_string), NIL, MB_YESNO + MB_ICONINFORMATION) = IDYES) THEN BEGIN
      exit;
    END;
  END;

  Error_message := 'Unknown error.';
  url := settings.url_cutlists_home + php_name + command + cleanurl(cutlist_id);

  IF NOT DoHttpGet(url, false, error_message, Response) THEN BEGIN
    IF NOT batchmode THEN BEGIN
      message_string := Error_message + #13#10 + 'Open cutlist homepage in webbrowser?';
      IF (application.messagebox(PChar(message_string), NIL, MB_YESNO + MB_ICONQUESTION) = IDYES) THEN BEGIN
        ShellExecute(0, NIL, PChar(settings.url_cutlists_home), '', '', SW_SHOWNORMAL);
      END;
    END;
  END ELSE BEGIN
    IF (Length(Response) < 5) THEN BEGIN
      IF NOT batchmode THEN
        ShowMessage('Server did not return any valid data (' + inttostr(Length(Response)) + ' bytes). Abort.');
      Exit;
    END;
    IF NOT ForceDirectories(cutlist_path) THEN BEGIN
      IF NOT batchmode THEN
        ShowMessage('Could not create cutlist path ' + cutlist_path + '. Abort.');
      exit;
    END;
    IF fileexists(target_file) THEN BEGIN
      IF NOT batchmode THEN BEGIN
        message_string := 'Target File exists already:' + #13#10 + target_file + #13#10 +
          'Overwrite?';
        IF NOT (application.messagebox(PChar(message_string), NIL, MB_YESNO + MB_ICONQUESTION) = IDYES) THEN BEGIN
          exit;
        END;
      END;
      IF NOT DeleteFile(target_file) THEN BEGIN
        IF NOT batchmode THEN
          ShowMessage('Could not delete existing file ' + target_file + '. Abort.');
        exit;
      END;
    END;

    AssignFile(Cutlist_File, target_file);
    Rewrite(Cutlist_File);
    TRY
      Write(Cutlist_File, Response);
    FINALLY
      CloseFile(Cutlist_File);
    END;
    cutlist.LoadFromFile(target_file);
    Result := true;
  END;
END;

FUNCTION TFMain.ConvertUploadData: boolean;
VAR
  RowDataNode, RowNode             : TJCLSimpleXMLElem;
  idx, cntNew                      : integer;
  CutlistID                        : integer;
  CutlistDate                      : TDateTime;
  CutlistIDStr, CutlistName, CutlistDateStr: STRING;
  Error_message                    : STRING;
BEGIN
  Result := false;
  IF NOT FileExists(UploadData_Path(false)) THEN
    Exit;

  cntNew := 0;

  XMLResponse.LoadFromFile(UploadData_Path(false));
  TRY
    RowDataNode := XMLResponse.Root.Items.ItemNamed['ROWDATA'];
    IF RowDataNode <> NIL THEN BEGIN
      FOR idx := 0 TO RowDataNode.Items.Count - 1 DO BEGIN
        RowNode := RowDataNode.Items.Item[idx];
        IF RowNode <> NIL THEN BEGIN
          CutlistIDStr := RowNode.Properties.Value('id', '0');
          CutlistID := StrToIntDef(CutlistIDStr, 0);
          CutlistName := RowNode.Properties.Value('name', '');
          CutlistDateStr := RowNode.Properties.Value('DateTime', '');
          IF Length(CutlistDateStr) > 9 THEN BEGIN
            CutlistDate := DateTimeStrEval('YYYYMMDDTHH:NN:SSZZZ', CutlistDateStr);
          END
          ELSE BEGIN
            CutlistDate := DateTimeStrEval('YYYYMMDD', CutlistDateStr);
          END;
          IF (CutlistID > 0) AND (UploadDataEntries.IndexOfName(CutlistIDStr) < 0) THEN BEGIN
            AddUploadDataEntry(CutlistDate, CutlistName, CutlistID);
            Inc(cntNew);
          END;
        END;
      END;
    END;
    IF cntNew > 0 THEN BEGIN
      UploadDataEntries.SaveToFile(UploadData_Path(true));
    END;
    IF FileExists(UploadData_Path(false)) THEN BEGIN
      RenameFile(UploadData_Path(false), UploadData_Path(false) + '.BAK');
    END;
  EXCEPT
    ON E: EJclSimpleXMLError DO BEGIN
      Error_message := 'XML-Error while converting upload infos.'#13#10 + E.Message;
      IF NOT batchmode THEN
        ShowMessage(Error_Message);
    END;
  END;
END;

FUNCTION GetXMLMessage(CONST Node: TJCLSimpleXMLElem; CONST ItemName: STRING; CONST LastChecked: TDateTime): STRING;
VAR
  Msg                              : TJCLSimpleXMLElems;
  datum                            : TDateTime;
  FUNCTION ItemStr(CONST AName: STRING): STRING;
  VAR Item                         : TJCLSimpleXMLElem;
  BEGIN
    Item := Msg.ItemNamed[AName];
    IF Item = NIL THEN Result := ''
    ELSE Result := Item.Value;
  END;
  FUNCTION ItemInt(CONST AName: STRING): integer;
  BEGIN
    Result := StrToIntDef(ItemStr(AName), -1);
  END;
BEGIN
  Result := '';
  Msg := Node.Items;
  IF NOT TryEncodeDate(
    ItemInt('date_year'), ItemInt('date_month'), ItemInt('date_day'),
    Datum
    ) THEN exit;
  IF LastChecked <= Datum THEN BEGIN
    Result := '[' + DateToStr(Datum) + '] ' + ItemStr(ItemName);
  END;
END;

FUNCTION GetXMLMessages(CONST Node: TJCLSimpleXMLElem; CONST LastChecked: TDateTime; CONST name: STRING): STRING;
VAR
  MsgList                          : TJCLSimpleXMLElems;
  s                                : STRING;
  idx                              : integer;
BEGIN
  Result := '';
  MsgList := Node.Items.ItemNamed[name].Items;
  IF MsgList.Count > 0 THEN BEGIN
    FOR idx := 0 TO MsgList.Count - 1 DO BEGIN
      s := GetXMLMessage(MsgList.Item[idx], 'text', LastChecked);
      IF Length(s) > 0 THEN BEGIN
        Result := Result + #13#10#13#10 + s;
      END;
    END;
  END;
END;

FUNCTION TFMain.DownloadInfo(settings: TSettings; CONST UseDate, ShowAll: boolean): boolean;
VAR
  error_message, url, AText, ResponseText: STRING;
  lastChecked                      : TDateTime;
  //f: textFile;
BEGIN
  result := false;
  lastChecked := settings.InfoLastChecked;
  IF UseDate THEN
    IF NOT (daysBetween(lastChecked, SysUtils.Date) >= settings.InfoCheckInterval) THEN
      exit;
  IF ShowAll THEN
    lastChecked := 0;

  Error_message := 'Unknown error.';
  url := settings.url_info_file;

  Error_message := 'Error while checking for Information and new Versions on Server.' + #13#10;
  Result := DoHttpGet(url, false, Error_message, ResponseText);

  IF Result THEN BEGIN
    TRY
      IF Length(ResponseText) > 5 THEN BEGIN
        XMLResponse.LoadFromString(ResponseText);

        IF XMLResponse.Root.ChildsCount > 0 THEN BEGIN
          IF settings.InfoShowMessages THEN BEGIN
            AText := GetXMLMessages(XMLResponse.Root, lastChecked, 'messages');
            IF Length(AText) > 0 THEN
              IF NOT batchmode THEN
                ShowMessage('Information: ' + AText);
          END;
          IF settings.InfoShowBeta THEN BEGIN
            AText := GetXMLMessage(XMLResponse.Root.Items.ItemNamed['beta'], 'version_text', lastChecked);
            IF Length(AText) > 0 THEN
              IF NOT batchmode THEN
                ShowMessage('Beta-Information: ' + AText);
          END;
          IF settings.InfoShowStable THEN BEGIN
            AText := GetXMLMessage(XMLResponse.Root.Items.ItemNamed['stable'], 'version_text', lastChecked);
            IF Length(AText) > 0 THEN
              IF NOT batchmode THEN
                ShowMessage('Stable-Information: ' + AText);
          END;
          Result := true;
        END;
      END;
      settings.InfoLastChecked := sysutils.Date;
    EXCEPT
      ON E: EJclSimpleXMLError DO BEGIN
        Error_message := Error_message + 'XML-Error: ' + E.Message;
        IF NOT batchmode THEN
          ShowMessage(Error_Message);
      END;
    ELSE BEGIN
        RAISE;
      END;
    END;
  END;
END;

PROCEDURE TFMain.ASnapshotCopyExecute(Sender: TObject);
VAR
  tempBitmap                       : TBitmap;
  tempCutFrame                     : TCutFrame;
BEGIN
  IF MenuVideo.PopupComponent = VideoWindow THEN BEGIN
    IF NOT assigned(seeking) THEN exit;
    //tempBitmap := TBitmap.Create;
    tempCutFrame := TCutFrame.create(NIL);
    TRY
      sampleTarget := tempCutFrame;
      tempBitmap := tempCutFrame.Image.Picture.Bitmap;
      //      sampleTarget := tempBitmap;
      jumpto(currentPosition);
      WaitForFiltergraph;
      ClipBoard.Assign(tempBitmap);
    FINALLY
      //FreeAndNIL(tempBitmap);
      FreeAndNIL(tempCutFrame);
    END;
  END;
  IF MenuVideo.PopupComponent IS TImage THEN BEGIN
    clipboard.Assign((MenuVideo.PopupComponent AS TImage).Picture.Bitmap);
  END;
END;

PROCEDURE TFMain.ASnapshotSaveExecute(Sender: TObject);

  FUNCTION AskForFileName(VAR FileName: STRING; VAR FileType: Integer): boolean;
  VAR
    saveDlg                        : TSaveDialog;
    DefaultExt                     : STRING;
  BEGIN
    result := false;
    saveDlg := TSaveDialog.Create(Application.MainForm);
    TRY
      saveDlg.Filter := 'Bitmap|*.bmp|JPEG|*.jpg|All Files|*.*';
      saveDlg.FilterIndex := 2;
      saveDlg.Title := 'Save Snapshot as...';
      //saveDlg.InitialDir := '';
      saveDlg.filename := fileName;
      saveDlg.options := saveDlg.Options + [ofOverwritePrompt, ofPathMustExist];
      IF saveDlg.Execute THEN BEGIN
        result := true;
        FileName := saveDlg.FileName;
        FileType := saveDlg.FilterIndex;
        CASE FileType OF
          1: BEGIN
              DefaultExt := '.bmp';
            END;
        ELSE BEGIN
            FileType := 2;
            DefaultExt := '.jpg';
          END;
        END;
        IF extractFileExt(FileName) <> DefaultExt THEN FileName := FileName + DefaultExt;
      END;
    FINALLY
      FreeAndNIL(saveDlg);
    END;
  END;

VAR
  tempBitmap                       : TBitmap;
  tempCutFrame                     : TCutFrame;
  posString,
    fileName                       : STRING;
  FileType                         : Integer;
BEGIN
  IF filtergraph.State = gsPlaying THEN GraphPause;

  IF MenuVideo.PopupComponent = VideoWindow THEN BEGIN
    IF NOT assigned(seeking) THEN exit;

    //tempBitmap := TBitmap.Create;
    tempCutFrame := TCutFrame.create(NIL);
    TRY
      //sampleTarget := tempBitmap;
      sampleTarget := tempCutFrame;
      tempBitmap := tempCutFrame.Image.Picture.Bitmap;
      jumpto(currentPosition);
      WaitForFiltergraph;

      posString := movieInfo.FormatPosition(tempCutFrame.position);
      posString := ansireplacetext(posString, ':', '''');
      fileName := extractfilename(MovieInfo.current_filename);
      fileName := changeFileExt(fileName, '_' + cleanFileName(posString));

      IF NOT AskForFileName(FileName, FileType) THEN exit;

      IF FileType = 1 THEN BEGIN
        TempBitmap.SaveToFile(FileName);
      END ELSE BEGIN
        SaveBitmapAsJPEG(TempBitmap, FileName);
      END;
    FINALLY
      //FreeAndNIL(tempBitmap);
      FreeAndNIL(tempCutFrame);
    END;
  END;

  IF MenuVideo.PopupComponent IS TImage THEN BEGIN
    posString := MovieInfo.FormatPosition((MenuVideo.PopupComponent.Owner AS TCutFrame).position);
    posString := ansireplacetext(posString, ':', '''');
    fileName := extractfilename(MovieInfo.current_filename);
    fileName := changeFileExt(fileName, '_' + cleanFileName(posString));
    IF NOT AskForFileName(FileName, FileType) THEN exit;

    TempBitmap := (MenuVideo.PopupComponent AS TImage).Picture.Bitmap;
    IF FileType = 1 THEN BEGIN
      TempBitmap.SaveToFile(FileName);
    END ELSE BEGIN
      SaveBitmapAsJPEG(TempBitmap, FileName);
    END;
  END;
END;

FUNCTION TFMain.CreateMPlayerEDL(cutlist: TCutlist; Inputfile,
  Outputfile: STRING; VAR scriptfile: STRING): boolean;
VAR
  f                                : Textfile;
  i                                : integer;
  cutlist_tmp                      : TCutlist;
BEGIN
  IF scriptfile = '' THEN
    scriptfile := Inputfile + '.edl';
  assignfile(f, scriptfile);
  rewrite(f);
  TRY
    IF cutlist.Mode = clmCutOut THEN BEGIN
      cutlist.sort;
      FOR i := 0 TO cutlist.Count - 1 DO BEGIN
        writeln(f, FloatToStrInvariant(cutlist.Cut[i].pos_from) + ' ' + FloatToStrInvariant(cutlist.Cut[i].pos_to) + ' 0');
      END;
    END ELSE BEGIN
      cutlist_tmp := cutlist.convert;
      FOR i := 0 TO cutlist_tmp.Count - 1 DO BEGIN
        writeln(f, FloatToStrInvariant(cutlist_tmp.Cut[i].pos_from) + ' ' + FloatToStrInvariant(cutlist_tmp.Cut[i].pos_to) + ' 0');
      END;
      FreeAndNIL(cutlist_tmp);
    END;
  FINALLY
    closefile(f);
  END;
  result := true;
END;

PROCEDURE TFMain.APlayInMPlayerAndSkipExecute(Sender: TObject);
VAR
  edlfile, AppPath, command, message_string: STRING;
BEGIN
  edlfile := '';
  IF NOT MovieInfo.MovieLoaded THEN exit;
  AppPath := settings.MplayerPath;
  IF NOT fileexists(AppPath) THEN exit;
  command := MovieInfo.current_filename;
  IF cutlist.count > 0 THEN BEGIN
    IF NOT self.CreateMPlayerEDL(cutlist, MovieInfo.current_filename, '', edlfile) THEN exit;
    command := command + ' -edl ' + edlfile;
  END;
  IF NOT CallApplication(AppPath, Command, message_string) THEN BEGIN
    IF NOT batchmode THEN
      showmessage('Error while calling ' + extractFilename(AppPath) + ': ' + message_string);
  END;
END;

PROCEDURE TFMain.ResetForm;
BEGIN
  pos_from := 0;
  pos_to := 0;

  self.Caption := Application_Friendly_Name;
  application.Title := Application_Friendly_Name;

  self.OpenCutlist.Enabled := false;
  self.ASearchCutlistByFileSize.Enabled := false;
  self.EnableMovieControls(false);
  self.AStepForward.Enabled := false;

  self.LDuration.Caption := '0 / 0:00:00.000';
  self.UpdateMovieInfoControls;
END;

PROCEDURE TFMain.EnableMovieControls(value: boolean);
BEGIN
  self.ANextFrames.Enabled := value;
  self.APrevFrames.Enabled := value;
  self.TBFilePos.Enabled := value;
  self.TFinePos.Enabled := value;
  self.ASmallSkipForward.Enabled := value;
  self.ALargeSkipForward.Enabled := value;
  self.AStepBackward.Enabled := value;
  self.ASmallSkipBackward.Enabled := value;
  self.ALargeSkipBackward.Enabled := value;
  self.APlayPause.Enabled := value;
  self.AStop.Enabled := value;
  IF value AND MovieInfo.CanStepForward THEN BEGIN
    self.AStepForward.Enabled := true;
  END ELSE BEGIN
    self.AStepForward.Enabled := false;
  END;
  self.BJumpFrom.Enabled := value;
  self.BJumpTo.Enabled := value;
  self.BSetFrom.Enabled := value;
  self.BSetTo.Enabled := value;
  self.BFromStart.Enabled := value;
  self.BToEnd.Enabled := value;
END;

FUNCTION TFMain.BuildFilterGraph(FileName: STRING;
  FileType: TMovieType): boolean;
BEGIN
  result := false;
END;

FUNCTION TFMain.GetSampleGrabberMediaType(VAR MediaType: TAMMediaType): HResult;
//Fix because SampleGrabber does not set right media type:
//SampleGrabber has wrong resolution in MediaType if videowindow
//is smaller than native resolution
VAR
  SourcePin                        : IPin;
  InPin                            : IPin;
BEGIN
  InPin := SampleGrabber1.InPutPin;
  Result := InPin.ConnectedTo(SourcePin);
  IF Result <> S_OK THEN BEGIN
    exit;
  END;
  Result := SourcePin.ConnectionMediaType(MediaType)
END;

FUNCTION TFMain.CustomGetSampleGrabberBitmap(Bitmap: TBitmap; Buffer: Pointer; BufferLen: Integer): Boolean;
//Fix because SampleGrabber does not set right media type:
//SampleGrabber has wrong resolution in MediaType if videowindow
//is smaller than native resolution
//This function is copied from DSPack but uses MediaType from upstream filter
  FUNCTION GetDIBLineSize(BitCount, Width: Integer): Integer;
  BEGIN
    IF BitCount = 15 THEN
      BitCount := 16;
    Result := ((BitCount * Width + 31) DIV 32) * 4;
  END;
VAR
  hr                               : HRESULT;
  BIHeaderPtr                      : PBitmapInfoHeader;
  MediaType                        : TAMMediaType;
  BitmapHandle                     : HBitmap;
  DIBPtr                           : Pointer;
  DIBSize                          : LongInt;
BEGIN
  Result := False;
  IF NOT Assigned(Bitmap) THEN
    Exit;
  IF Assigned(Buffer) AND (BufferLen = 0) THEN
    Exit;
  hr := self.GetSampleGrabberMediaType(MediaType); // <-- Changed
  IF hr <> S_OK THEN
    Exit;
  TRY
    IF IsEqualGUID(MediaType.majortype, MEDIATYPE_Video) THEN BEGIN
      BIHeaderPtr := NIL;
      IF IsEqualGUID(MediaType.formattype, FORMAT_VideoInfo) THEN BEGIN
        IF MediaType.cbFormat = SizeOf(TVideoInfoHeader) THEN // check size
          BIHeaderPtr := @(PVideoInfoHeader(MediaType.pbFormat)^.bmiHeader);
      END
      ELSE IF IsEqualGUID(MediaType.formattype, FORMAT_VideoInfo2) THEN BEGIN
        IF MediaType.cbFormat = SizeOf(TVideoInfoHeader2) THEN // check size
          BIHeaderPtr := @(PVideoInfoHeader2(MediaType.pbFormat)^.bmiHeader);
      END;
      // check, whether format is supported by TSampleGrabber
      IF NOT Assigned(BIHeaderPtr) THEN
        Exit;
      BitmapHandle := CreateDIBSection(0, PBitmapInfo(BIHeaderPtr)^,
        DIB_RGB_COLORS, DIBPtr, 0, 0);
      IF BitmapHandle <> 0 THEN BEGIN
        TRY
          IF DIBPtr = NIL THEN
            Exit;
          // get DIB size
          DIBSize := BIHeaderPtr^.biSizeImage;
          IF DIBSize = 0 THEN BEGIN
            WITH BIHeaderPtr^ DO
              DIBSize := GetDIBLineSize(biBitCount, biWidth) * biHeight * biPlanes;
          END;
          // copy DIB
          IF NOT Assigned(Buffer) THEN BEGIN
            Exit; // <-- changed
          END
          ELSE BEGIN
            IF BufferLen > DIBSize THEN // copy Min(BufferLen, DIBSize)
              BufferLen := DIBSize;
            Move(Buffer^, DIBPtr^, BufferLen);
          END;
          Bitmap.Handle := BitmapHandle;
          Result := True;
        FINALLY
          IF Bitmap.Handle <> BitmapHandle THEN // preserve for any changes in Graphics.pas
            DeleteObject(BitmapHandle);
        END;
      END;
    END;
  FINALLY
    FreeMediaType(@MediaType);
  END;
END;

FUNCTION TFMain.FilterGraphSelectedFilter(Moniker: IMoniker;
  FilterName: WideString; ClassID: TGUID): Boolean;
BEGIN
  result := NOT settings.FilterIsInBlackList(ClassID);
END;

PROCEDURE TFMain.FramePopUpPrevious12FramesClick(Sender: TObject);
BEGIN
  IF MenuVideo.PopupComponent = VideoWindow THEN BEGIN
    self.APrevFrames.Execute;
  END;
  IF MenuVideo.PopupComponent IS TImage THEN BEGIN
    ((MenuVideo.PopupComponent AS TImage).Owner AS TCutFrame).ImageDoubleClick(MenuVideo.PopupComponent);
    self.APrevFrames.Execute;
  END;
END;

PROCEDURE TFMain.FramePopUpNext12FramesClick(Sender: TObject);
BEGIN
  IF MenuVideo.PopupComponent = VideoWindow THEN BEGIN
    self.ANextFrames.Execute;
  END;
  IF MenuVideo.PopupComponent IS TImage THEN BEGIN
    ((MenuVideo.PopupComponent AS TImage).Owner AS TCutFrame).ImageDoubleClick(MenuVideo.PopupComponent);
    self.ANextFrames.Execute;
  END;
END;

PROCEDURE TFMain.AShowLoggingExecute(Sender: TObject);
BEGIN
  IF NOT FLogging.Visible THEN BEGIN
    FLogging.Width := Self.Width;
    FLogging.Top := Self.Top + Self.Height + 1;
    FLogging.Left := Self.Left;
  END;
  FLogging.Visible := true;
END;

PROCEDURE TFMain.ATestExceptionHandlingExecute(Sender: TObject);
BEGIN
  RAISE Exception.Create('This is a exception handling test at ' + FormatDateTime('', Now));
END;

PROCEDURE TFMain.ACheckInfoOnServerExecute(Sender: TObject);
BEGIN
  self.DownloadInfo(Settings, false, Utils.ShiftDown);
END;

PROCEDURE TFMain.AOpenCutassistantHomeExecute(Sender: TObject);
BEGIN
  ShellExecute(0, NIL, 'http://sourceforge.net/projects/cutassistant/', '', '', SW_SHOWNORMAL);
END;

PROCEDURE TFMain.FormShow(Sender: TObject);
BEGIN
  IF settings.CheckInfos THEN
    self.DownloadInfo(settings, true, false);
  IF settings.NewSettingsCreated THEN
    EditSettings.Execute;
  // set to true after creation of form, for cutlist clear  HG
  mainformLoaded := true;

END;

FUNCTION TFMain.DoHttpGet(CONST url: STRING; CONST handleRedirects: boolean; CONST Error_message: STRING; VAR Response: STRING): boolean;
VAR
  data                             : THttpRequest;
BEGIN
  data := THttpRequest.Create(url, handleRedirects, Error_message);
  TRY
    Result := DoHttpRequest(data);
    Response := data.Response;
  FINALLY
    FreeAndNil(data);
  END;
END;

FUNCTION TFMain.DoHttpRequest(data: THttpRequest): boolean;
CONST
  SLEEP_TIME                       = 50;
  MAX_SLEEP                        = 10;
VAR
  idx                              : integer;
BEGIN
  RequestWorker.Start;
  RequestWorker.Data := data;

  idx := MAX_SLEEP;
  WHILE idx > 0 DO BEGIN
    Dec(idx);
    Sleep(SLEEP_TIME);
    IF RequestWorker.Stopped THEN
      Break;
  END;
  IF NOT RequestWorker.Stopped THEN
    RequestProgressDialog.Execute;

  Result := HandleWorkerException(data);
END;

FUNCTION TFMain.HandleWorkerException(data: THttpRequest): boolean;
VAR
  excClass                         : TClass;
  url, msg                         : STRING;
  idx                              : integer;
BEGIN
  IF RequestWorker.ReturnValue = 0 THEN BEGIN
    Result := true;
    Exit;
  END;

  Result := false;
  excClass := RequestWorker.TerminatingExceptionClass;
  IF excClass <> NIL THEN BEGIN
    msg := RequestWorker.TerminatingException;
    IF excClass.InheritsFrom(EIdProtocolReplyError) THEN BEGIN
      CASE RequestWorker.ReturnValue OF
        404, 302: BEGIN
            url := data.Url;
            idx := Pos('?', url);
            IF idx < 1 THEN idx := Length(url)
            ELSE Dec(idx);
            msg := 'File not found on server: ' + Copy(url, 1, idx) + '.';
          END;
      END;
    END;
    IF NOT batchmode THEN
      ShowMessage(data.ErrorMessage + msg);
  END;
END;

PROCEDURE TFMain.RequestProgressDialogShow(Sender: TObject);
VAR
  dlg                              : TJvProgressDialog;
BEGIN
  dlg := Sender AS TJvProgressDialog;
  Assert(Assigned(dlg));
  dlg.Position := 30;
END;

PROCEDURE TFMain.RequestProgressDialogCancel(Sender: TObject);
BEGIN
  IdHTTP1.DisconnectSocket;
  RequestWorker.WaitFor;
END;

PROCEDURE TFMain.RequestProgressDialogProgress(Sender: TObject;
  VAR AContinue: Boolean);
VAR
  dlg                              : TJvProgressDialog;
BEGIN
  dlg := Sender AS TJvProgressDialog;
  IF dlg.Position = dlg.Max THEN dlg.Position := dlg.Min
  ELSE dlg.Position := dlg.Position + 2;
  IF RequestWorker.ReturnValue >= 0 THEN
    dlg.Interval := 0;
  IF RequestWorker.ReturnValue > 0 THEN
    AContinue := false;
END;

PROCEDURE TFMain.RequestWorkerRun(Sender: TIdCustomThreadComponent);
VAR
  data                             : THttpRequest;
  Response                         : STRING;
BEGIN
  Assert(Assigned(Sender));
  IF Assigned(Sender.Thread) THEN
    NameThread(Sender.Thread.ThreadID, 'RequestWorker');
  data := Sender.Data AS THttpRequest;
  IF NOT Assigned(data) THEN {// busy wait for data object ...} BEGIN
    Sleep(10);
    Exit;
  END;
  Sender.ReturnValue := -1;
  TRY
    IdHttp1.HandleRedirects := data.HandleRedirects;
    IF data.IsPostRequest THEN
      Response := IdHTTP1.Post(data.Url, data.PostData)
    ELSE
      Response := IdHTTP1.Get(data.Url);
    data.Response := Response;
  FINALLY
    // Only for testing purposes
    //Sleep(10000);
    IF NOT Sender.Terminated THEN
      Sender.Stop;
    IF Sender.ReturnValue < 0 THEN ;
    Sender.ReturnValue := 0;
  END;
END;

PROCEDURE TFMain.RequestWorkerException(Sender: TIdCustomThreadComponent;
  AException: Exception);
VAR
  data                             : THttpRequest;
BEGIN
  Assert(Assigned(Sender));
  IF NOT Assigned(Sender.Data) THEN BEGIN
    RequestProgressDialog.Text := 'Transfer aborted ...';
  END
  ELSE BEGIN
    data := Sender.Data AS THttpRequest;
    RequestProgressDialog.Text := 'Transfer error. Aborting ...';
    data.Response := '';
  END;

  IF AException IS EIdProtocolReplyError THEN
    WITH AException AS EIdProtocolReplyError DO
      Sender.ReturnValue := ReplyErrorCode;
  IF Sender.ReturnValue <= 0 THEN
    Sender.ReturnValue := 1;

  Sender.Stop;
END;

PROCEDURE TFMain.InitHttpProperties;
BEGIN
  self.IdHTTP1.ConnectTimeout := 1000 * Settings.NetTimeout;
  self.IdHTTP1.ReadTimeout := 1000 * Settings.NetTimeout;
  self.IdHTTP1.ProxyParams.ProxyServer := Settings.proxyServerName;
  self.IdHTTP1.ProxyParams.ProxyPort := Settings.proxyPort;
  self.IdHTTP1.ProxyParams.ProxyUsername := Settings.proxyUserName;
  self.IdHTTP1.ProxyParams.ProxyPassword := Settings.proxyPassword;
END;

PROCEDURE TFMain.IdHTTP1Status(ASender: TObject; CONST AStatus: TIdStatus;
  CONST AStatusText: STRING);
BEGIN
  RequestProgressDialog.Text := AStatusText;
END;

PROCEDURE TFMain.IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
  CONST AWorkCount: Integer);
BEGIN
  CASE AWorkMode OF
    wmRead:
      RequestProgressDialog.Text := Format('Read %5d bytes from host.', [AWorkCount]);
    wmWrite:
      RequestProgressDialog.Text := Format('Wrote %5d bytes to host.', [AWorkCount]);
  END;
END;


PROCEDURE TFMain.ASupportRequestExecute(Sender: TObject);
VAR
  AException                       : IMEException;
  AAssistant                       : INVAssistant;
  ABugReport                       : STRING;
  AScreenShot                      : INVBitmap;
  AMemo                            : INVEdit;
BEGIN
  AException := NewException(etHidden);
  AException.ListThreads := false;
  //AException.MailAddr := 'cutassistant-help@lists.sourceforge.net';
  AException.MailSubject := 'CutAssistant ' + Application_Version + ' support request';
  AAssistant := AException.GetAssistant('SupportAssistant');
  AMemo := AAssistant.Form['SupportDetailsForm'].nvEdit('DetailsMemo');
  AScreenShot := AException.ScreenShot;
  IF AAssistant.ShowModal() = nvmOk THEN BEGIN
    ABugReport := AException.GetBugReport(true);
    AException.MailBody := AMemo.OutputName + #13#10 + StringOfChar('-', Length(AMemo.OutputName)) + #13#10 + AMemo.Text;
    SendBugReport(ABugReport, AScreenShot, self.Handle, AException);
  END;
END;

PROCEDURE TFMain.AStopExecute(Sender: TObject);
BEGIN
  GraphPause; //Set Play/Pause Button Caption
  jumpto(0);
  filtergraph.Stop;
END;

PROCEDURE TFMain.APlayPauseExecute(Sender: TObject);
BEGIN
  GraphPlayPause;
  //HG
  TrackMWheelFine.SetFocus;
  TFinePos.PageSize := 10;
  //HG
END;

PROCEDURE TFMain.TrackMWheelFineChange(Sender: TObject);

VAR
  timeToSkip                       : double;
  skipframes                       : integer;
BEGIN

  skipframes := 1;

  IF (GetKeyState(VK_SHIFT) < 0) THEN BEGIN

    skipframes := 5;

  END;


  //  lblTest1.caption :=   Format('%10d',[IlastPos]);



  IF (IlastPos > TrackMWheelFine.Position) THEN BEGIN
    IF NOT (FilterGraph.State = gsPaused) THEN GraphPause;
    IF assigned(FrameStep) THEN BEGIN
      IF Settings.AutoMuteOnSeek AND NOT CBMute.Checked THEN
        FilterGraph.Volume := 0;

      timeToSkip := MovieInfo.frame_duration * skipframes;

      JumpTo(currentPosition + timeToSkip);


      //   TBFilePos.TriggerTimer;
       //  if Settings.AutoMuteOnSeek and not CBMute.Checked then
       //    FilterGraph.Volume := TVolume.Position;


    END ELSE BEGIN
      self.AStepForward.Enabled := false;
    END


  END


  ELSE BEGIN
    IF NOT (FilterGraph.State = gsPaused) THEN GraphPause;


    timeToSkip := MovieInfo.frame_duration * skipframes;

    JumpTo(currentPosition - timeToSkip);

  END;

  IlastPos := longint(TrackMWheelFine.Position);


END;














PROCEDURE TFMain.btnScanToEndMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

VAR
  //  i1, i2: integer;
  pos1, pos2                       : double;
  c                                : TCursor;


BEGIN
  IF NOT MovieInfo.MovieLoaded THEN
    exit;


  pos1 := CurrentPosition;
  pos2 := MovieInfo.current_file_duration;


  IF (GetKeyState(VK_SHIFT) < 0) THEN BEGIN

    pos2 := int(MovieInfo.current_file_duration - ((MovieInfo.current_file_duration - CurrentPosition) / 2));


  END;

  IF (GetKeyState(VK_CONTROL) < 0) THEN BEGIN

    pos2 := int(MovieInfo.current_file_duration - (((MovieInfo.current_file_duration - CurrentPosition) / 4)) * 3);


  END;

  IF (GetKeyState(VK_MENU) < 0) THEN BEGIN

    pos2 := int(MovieInfo.current_file_duration  / 10 ) +  CurrentPosition ;


  END;





  c := self.Cursor;
  self.Cursor := crHourGlass;
  TRY
    EnableMovieControls(false);
    self.AScanInterval.Enabled := false;
    self.BtnScanToEnd.Enabled := false;
    Application.ProcessMessages;

    showframesabs(pos1, pos2, FFrames.Count);
  FINALLY
    EnableMovieControls(true);
    self.AScanInterval.Enabled := true;
    self.BtnScanToEnd.Enabled := true;
    self.Cursor := c;
  END;



END;

PROCEDURE TFMain.btnShowCutlistClick(Sender: TObject);


BEGIN

  frmClist.show;
END;







PROCEDURE TFMain.Button1Click(Sender: TObject);
BEGIN
  frmClist.Lcutlist.Clear;



END;



PROCEDURE TFMain.JvSpeedItem16Click(Sender: TObject);
BEGIN

  IF frmClist.Visible THEN BEGIN
    frmClist.hide;



  END
  ELSE BEGIN
    frmClist.show;
  END;




END;



INITIALIZATION
  BEGIN
    randomize;
    Settings := TSettings.Create;
    Settings.load;
    //RegisterDSAMessage(1, 'CutlistRated', 'Cutlist rated');
    MovieInfo := TMovieInfo.Create;
    Cutlist := TCutList.Create(Settings, MovieInfo);

    //HG
    iActiveCut := -1; //reset active cut id
    //*HG

  END;

FINALIZATION
  BEGIN
    FreeAndNIL(Cutlist);
    FreeAndNIL(MovieInfo);
    Settings.save;
    FreeAndNIL(Settings);
  END;

END.

