unit Main;

interface

uses
  Windows, Messages, SysUtils, DateUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, OleCtrls, StdCtrls, contnrs, shellapi, Buttons, GIFImage,
  ExtCtrls, strutils, iniFiles, Registry, ComObj, Menus, math, ToolWin, Clipbrd,

  ActnMan, ActnCtrls, ActnMenus, ActnList, XPStyleActnCtrls, ImgList,
  StdStyleActnCtrls, ExtActns,

  XMLDoc, xmldom, XMLIntf, msxmldom, Provider, Xmlxform, DB, DBClient, MidasLib,

  IdBaseComponent, IdComponent,IdTCPConnection, IdTCPClient,IdHTTP,
  IdMultipartFormData, IdException,

  DSPack, DSUtil, DirectShow9, wmf9, ActiveX,

  Settings_dialog, ManageFilters, UploadList, CutlistInfo_dialog, UCutlist,
  Movie, trackBarEx,

  CodecSettings, JvComponentBase, JvCreateProcess, Unit_DSTrackBarEx;

const  
  //Registry Keys
  CutlistID = 'CutAssistant.Cutlist';
  CUTLIST_CONTENT_TYPE = 'text/plain';
  ProgID = 'Cut_Assistant.exe';
  ShellEditKey = 'CutAssistant.edit';

type

  TFMain = class(TForm{, ISampleGrabberCB})
    BStop: TButton;
    BPlayPause: TButton;
    Lcutlist: TListView;
    BAddCut: TButton;
    BDeleteCut: TButton;
    EFrom: TEdit;
    EDuration: TEdit;
    ETo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BSetFrom: TButton;
    BSetTo: TButton;
    BFromStart: TButton;
    BToEnd: TButton;
    BJumpFrom: TButton;
    BJumpTo: TButton;
    BReplaceCut: TButton;
    BEditCut: TButton;
    RCutMode: TRadioGroup;
    BPrev12: TButton;
    BStepBack: TButton;
    BStepForwards: TButton;
    TVolume: TTrackBar;
    Label8: TLabel;
    CBMute: TCheckBox;
    LPos: TLabel;
    BNext12: TButton;
    TFinePos: TtrackBarEx;
    Label11: TLabel;
    Label12: TLabel;
    LDuration: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    CutListOpenDialog: TOpenDialog;
    VideoWindow: TVideoWindow;
    LFinePos: TLabel;
    DSTrackBar1: TDSTrackBarEx;
    SampleGrabber1: TSampleGrabber;
    TeeFilter: TFilter;
    NullRenderer1: TFilter;
    Label7: TLabel;
    PanelVideoWindow: TPanel;
    B12FromTo: TButton;
    BConvert: TButton;
    ActionManager1: TActionManager;
    OpenMovie: TAction;
    OpenCutlist: TAction;
    File_Exit: TAction;
    ImageList1: TImageList;
    SaveCutlistAs: TAction;
    AddCut: TAction;
    ReplaceCut: TAction;
    EditCut: TAction;
    DeleteCut: TAction;
    ShowFramesForm: TAction;
    Next12: TAction;
    Prev12: TAction;
    ScanInterval: TAction;
    AStartCutting: TAction;
    EditSettings: TAction;
    MovieMetaData: TAction;
    About: TAction;
    UsedFilters: TAction;
    ActionMainMenuBar1: TActionMainMenuBar;
    ActionToolBar1: TActionToolBar;
    WriteToRegisty: TAction;
    RemoveRegistryEntries: TAction;
    CutlistUpload: TAction;
    IdHTTP1: TIdHTTP;
    StepForward: TAction;
    StepBackward: TAction;
    BrowseWWWHelp: TAction;
    OpenCutlistHome: TAction;
    ARepairMovie: TAction;
    BCutlistInfo: TBitBtn;
    ACutlistInfo: TAction;
    ICutlistWarning: TImage;
    ASaveCutlist: TAction;
    ACalculateResultingTimes: TAction;
    AAsfbinInfo: TAction;
    PAuthor: TPanel;
    LAuthor: TLabel;
    ASearchCutlistByFileSize: TAction;
    XMLDocument1: TXMLDocument;
    ASendRating: TAction;
    ADeleteCutlistFromServer: TAction;
    UploadData: TClientDataSet;
    UploadDataid: TStringField;
    UploadDataname: TStringField;
    UploadDataDateTime: TDateTimeField;
    LTotalCutoff: TLabel;
    LResultingDuration: TLabel;
    DownloadData: TClientDataSet;
    DownloadDataid: TStringField;
    DownloadDataname: TStringField;
    DownloadDataDateTime: TDateTimeField;
    DownloadDataMD5: TStringField;
    TBRate: TtrackBarEx;
    Label4: TLabel;
    LRate: TLabel;
    LTrueRate: TLabel;
    BNextCut: TButton;
    BPrevCut: TButton;
    ANextCut: TAction;
    APrevCut: TAction;
    BFF: TButton;
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
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure BPlayPauseClick(Sender: TObject);
    procedure BStopClick(Sender: TObject);
    procedure BSetFromClick(Sender: TObject);
    procedure BSetToClick(Sender: TObject);
    procedure BFromStartClick(Sender: TObject);
    procedure BToEndClick(Sender: TObject);
    procedure BJumpFromClick(Sender: TObject);
    procedure BJumpToClick(Sender: TObject);
    procedure StepForwardExecute(Sender: TObject);
    procedure StepBackwardExecute(Sender: TObject);

    procedure LcutlistSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure LcutlistDblClick(Sender: TObject);
    procedure RCutModeClick(Sender: TObject);

    procedure TVolumeChange(Sender: TObject);
    procedure CBMuteClick(Sender: TObject);

    procedure DSTrackBar1Timer(sender: TObject; CurrentPos,
      StopPos: Cardinal);
    procedure DSTrackBar1PositionChangedByMouse(Sender: TObject);
    procedure DSTrackBar1Change(Sender: TObject);
    procedure DSTrackBar1SelChanged(Sender: TObject);
    procedure DSTrackBar1ChannelPostPaint(Sender: TDSTrackBarEx;
      const ARect: TRect);
    procedure TFinePosMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TFinePosChange(Sender: TObject);
    procedure FilterGraphGraphStepComplete(Sender: TObject);
    procedure PanelVideoWindowResize(Sender: TObject);
    procedure SampleGrabber1Buffer(sender: TObject; SampleTime: Double;
      pBuffer: Pointer; BufferLen: Integer);

    procedure OpenMovieExecute(Sender: TObject);
    procedure OpenCutlistExecute(Sender: TObject);
    procedure ASaveCutlistExecute(Sender: TObject);
    procedure SaveCutlistAsExecute(Sender: TObject);
    procedure File_ExitExecute(Sender: TObject);
    procedure AddCutExecute(Sender: TObject);
    procedure ReplaceCutExecute(Sender: TObject);
    procedure EditCutExecute(Sender: TObject);
    procedure DeleteCutExecute(Sender: TObject);
    procedure BConvertClick(Sender: TObject);
    procedure ACutlistInfoExecute(Sender: TObject);
    procedure ASearchCutlistByFileSizeExecute(Sender: TObject);
    procedure CutlistUploadExecute(Sender: TObject);
    procedure ASendRatingExecute(Sender: TObject);
    procedure ADeleteCutlistFromServerExecute(Sender: TObject);

    procedure ShowFramesFormExecute(Sender: TObject);
    procedure Next12Execute(Sender: TObject);
    procedure Prev12Execute(Sender: TObject);
    procedure ScanIntervalExecute(Sender: TObject);

    procedure ARepairMovieExecute(Sender: TObject);
    procedure AStartCuttingExecute(Sender: TObject);
    procedure AAsfbinInfoExecute(Sender: TObject);
    procedure MovieMetaDataExecute(Sender: TObject);
    procedure EditSettingsExecute(Sender: TObject);
    procedure UsedFiltersExecute(Sender: TObject);
    procedure AboutExecute(Sender: TObject);
    procedure BrowseWWWHelpExecute(Sender: TObject);
    procedure OpenCutlistHomeExecute(Sender: TObject);

    procedure WriteToRegistyExecute(Sender: TObject);
    procedure RemoveRegistryEntriesExecute(Sender: TObject);

    procedure ACalculateResultingTimesExecute(Sender: TObject);
    procedure VideoWindowClick(Sender: TObject);
    procedure TBRateChange(Sender: TObject);
    procedure LRateDblClick(Sender: TObject);
    procedure ANextCutExecute(Sender: TObject);
    procedure APrevCutExecute(Sender: TObject);
    procedure BFFMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BFFMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VideoWindowDblClick(Sender: TObject);
    procedure AFullScreenExecute(Sender: TObject);
    procedure VideoWindowKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ACloseMovieExecute(Sender: TObject);
    procedure ASnapshotCopyExecute(Sender: TObject);
    procedure ASnapshotSaveExecute(Sender: TObject);
    procedure APlayInMPlayerAndSkipExecute(Sender: TObject);
    function FilterGraphSelectedFilter(Moniker: IMoniker; FilterName: WideString; ClassID: TGUID): Boolean;
    procedure FramePopUpNext12FramesClick(Sender: TObject);
    procedure FramePopUpPrevious12FramesClick(Sender: TObject);
  private
    { Private declarations }
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
    procedure refresh_Lcutlist(cutlist: TCutlist);
    function WaitForStep(TimeOut: INteger): boolean;
    procedure WaitForFilterGraph;
    procedure HandleParameter(const param: string);
    function CalcTrueRate(Interval: double): double;
    procedure FF_Start;
    procedure FF_Stop; 
  public
    { Public declarations }
    procedure ProcessFileList(FileList: TStringList; IsMyOwnCommandLine: boolean);
    procedure refresh_times;
    procedure enable_del_buttons(value: boolean);
    function CurrentPosition: double;
    procedure JumpTo(NewPosition: double);
    procedure SetStartPosition(Position: double);
    procedure SetStopPosition(Position: double);

    procedure showframes(startframe, endframe: Integer);
    procedure showframesAbs(startframe, endframe: double; numberOfFrames: Integer);

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

    function DownloadInfo(settings: TSettings): boolean;
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
  uses Utils, Frames,  CutlistRate_Dialog, ResultingTimes, CutlistSearchResults, 
    PBOnceOnly, UfrmCutting, UCutApplicationBase, UCutApplicationAsfbin, UCutApplicationMP4Box, UMemoDialog;

{$R *.dfm}

procedure TFMain.BPlayPauseClick(Sender: TObject);
begin
  GraphPlayPause;
end;

procedure TFMain.BStopClick(Sender: TObject);
begin
  GraphPause; //Set Play/Pause Button Caption
  jumpto(0);
  filtergraph.Stop;
end;

procedure TFMain.BSetFromClick(Sender: TObject);
begin
  SetStartPosition(CurrentPosition);
end;

procedure TFMain.BSetToClick(Sender: TObject);
begin
  SetStopPosition(CurrentPosition);
end;

procedure TFMain.refresh_times;
begin
  self.EFrom.Text := MovieInfo.FormatPosition(pos_from);
  self.ETo.Text := MovieInfo.FormatPosition(pos_to);
  if pos_to >= pos_from then begin
    self.EDuration.Text := MovieInfo.FormatPosition(pos_to-pos_from);
    self.AddCut.Enabled := true;
  end else begin
    self.EDuration.Text := '';
    self.AddCut.Enabled := false;
  end;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  if screen.Width < self.Constraints.MinWidth then begin
    self.Constraints.MinWidth := screen.Width;
    self.WindowState := wsMaximized;
  end;
  if screen.height < self.Constraints.MinHeight then begin
    self.Constraints.MinHeight := screen.Height;
    self.WindowState := wsMaximized;
  end;

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
  DSTrackBar1.FilterGraph := FilterGraph;   }

  if fileexists(UploadData_Path) then
    UploadData.LoadFromFile(UploadData_Path);

  self.IdHTTP1.ProxyParams.ProxyServer := settings.proxyServerName;
  self.IdHTTP1.ProxyParams.ProxyPort := settings.proxyPort;
  self.IdHTTP1.ProxyParams.ProxyUsername := settings.proxyUserName;
  self.IdHTTP1.ProxyParams.ProxyPassword := settings.proxyPassword;

  Cutlist.RefreshCallBack := self.refresh_Lcutlist;
  cutlist.RefreshGUI;

  filtergraph.Volume := 5000;
  TVolume.PageSize := TVOlume.Frequency;
  TVOlume.LineSize := round(TVolume.PageSize /10);
  TVolume.Position := filtergraph.Volume;

  self.DownloadInfo(settings);

  //self.WindowState := wsMaximized;
end;

procedure TFMain.BFromStartClick(Sender: TObject);
begin
  pos_from := 0;
  refresh_times;
end;

procedure TFMain.BToEndClick(Sender: TObject);
begin
  pos_to := MovieInfo.current_file_duration;
  refresh_times;
end;

procedure TFMain.BJumpFromClick(Sender: TObject);
begin
  JumpTo(pos_from);
end;

procedure TFMain.BJumpToClick(Sender: TObject);
begin
  JumpTo(pos_to);
end;

procedure TFMain.LcutlistSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  self.enable_del_buttons(true);
end;

procedure TFMain.enable_del_buttons(value: boolean);
begin
  self.DeleteCut.enabled := value;
  self.EditCut.Enabled := value;
  self.ReplaceCut.Enabled := value;
end;


function TFMain.StartCutting: boolean;
var
  CutAppName,
  command : string;
  message_string: string;
  AppPath, sourcefile, sourceExtension, targetfile, targetpath, scriptfile: string;
  AskForPath: boolean;
  saveDlg: TSaveDialog;
//  exitCode: DWord;
  CutApplication: TCutApplicationBase;
begin
  result := false;
  if cutlist.Count = 0 then begin
    if not batchmode then showmessage('No cuts defined.');
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
         targetpath := includeTrailingBackslash(Settings.CutMovieSaveDir);
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
  MovieInfo.target_filename := targetpath + targetfile;

  //Display Save Dialog?
  AskForPath := Settings.MovieNameAlwaysConfirm;


  if fileexists(MovieInfo.target_FileName) AND (NOT AskForPath) and (not batchmode) then begin
    message_string := 'Target file already exists:' + #13#10 + #13#10 + MovieInfo.target_filename + #13#10 +  #13#10 + 'Overwrite?' ;
    if application.messagebox(PChar(message_string), nil, MB_YESNO + MB_DEFBUTTON2 + MB_ICONWARNING) <> IDYES then AskForPath := true;
  end;
  if AskForPath and (not batchmode) then begin
    saveDlg := TSaveDialog.Create(self);
    saveDlg.Filter := '*' + SourceExtension + '|*' + SourceExtension;
    saveDlg.Title := 'Save cut movie as...';
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
      if not batchmode then showmessage('Could not delete existing file ' + MovieInfo.target_filename + '. Abort.');
      exit;
    end;
  end;

  CutApplication := Settings.GetCutApplicationByMovieType(MovieInfo.MovieType);

  if assigned(CutApplication) then begin
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

procedure TFMain.CBMuteClick(Sender: TObject);
begin
  if CBMUte.Checked then begin
    filtergraph.Volume := 0;
  end else begin
    filtergraph.Volume := TVolume.Position;
  end;

end;

procedure TFMain.TVolumeChange(Sender: TObject);
begin
  if not CBMute.Checked then
    FilterGraph.Volume := TVolume.Position;
end;

procedure TFMain.showframes(startframe, endframe: Integer);
//startframe, endframe relative to current frame
var
  iImage : integer;
  pos, temp_pos: double;
  Target: TCutFrame;
begin
  if endframe < startframe then exit;
  while endframe - startframe + 1 >12 do begin
    if -startframe > endframe then startframe := startframe+1 else endframe := endframe-1;
  end;

  FFrames.Show;

  pos := currentPosition;
  temp_pos := pos + (startframe - 0) * MovieInfo.frame_duration;
  if (temp_pos > MovieInfo.current_file_duration) then temp_pos := MovieInfo.current_file_duration;
  if temp_pos<0 then temp_pos := 0;
  jumpto(temp_pos);


  for iImage := 0 to endframe - startframe do begin
    Target := FFrames.Frame[iImage];
    if (temp_pos >= 0) and (temp_pos <= MovieInfo.current_file_duration) then begin

      self.StepComplete := false;
      SampleTarget := Target;  //Set SampleTarget to trigger sampleGrabber.onbuffer method;
      FrameStep.Step(1, nil);
      if not waitforStep(5000) then break;

      temp_pos := currentPosition;
      Target.image.visible := true;
    end else begin
      Target.image.visible := false;
      Target.position := 0;
    end;
  end;

  JumpTo(pos);
end;

procedure TFMain.TFinePosMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  new_pos: double;
begin
  new_pos := currentPosition +  TFinePos.Position * MovieInfo.frame_duration;
  if new_pos<0 then new_pos := 0;
  if new_pos > MovieInfo.current_file_duration then new_pos := MovieInfo.current_file_duration;
  JumpTo(new_pos);
  TFinePos.Position := 0;
end;

procedure TFMain.refresh_Lcutlist(cutlist: TCutlist);
var
  icut: integer;
  cut: tcut;
  cut_view : tlistitem;
  i_column: integer;
  total_cutoff, resulting_duration: Double;
begin
  self.Lcutlist.Clear;
  if cutlist.IDOnServer = '' then
    self.ASendRating.Enabled := false
  else
    self.ASendRating.Enabled := true;

  if cutlist.Count = 0 then begin
    self.AStartCutting.Enabled := false;
    self.ACalculateResultingTimes.Enabled := false;
    self.SaveCutlistAs.Enabled := false;
    self.ASaveCutlist.Enabled := false;
    self.CutlistUpload.Enabled := false;
    self.ANextCut.Enabled := false;
    self.APrevCut.Enabled := false;
    self.enable_del_buttons(false);
  end else begin
    self.AStartCutting.Enabled := true;
    self.ACalculateResultingTimes.Enabled := true;
    self.SaveCutlistAs.Enabled := true;
    self.ASaveCutlist.Enabled := true;
    self.CutlistUpload.Enabled := true;
    self.ANextCut.Enabled := true;
    self.APrevCut.Enabled := true;
    for icut := 0 to cutlist.Count-1 do begin
      cut := cutlist[icut];
      cut_view := self.Lcutlist.Items.Add;
      cut_view.Caption := inttostr(cut.index);
      cut_view.SubItems.Add(MovieInfo.FormatPosition(cut.pos_from));
      cut_view.SubItems.Add(MovieInfo.FormatPosition(cut.pos_to));
      cut_view.SubItems.Add(MovieInfo.FormatPosition(cut.pos_to-cut.pos_from + MovieInfo.frame_duration));
    end;

    //Auto-Resize columns
    for i_column := 0 to self.Lcutlist.Columns.Count -1 do begin
      lcutlist.Columns[i_column].Width := -2;
    end;

    if LCutlist.ItemIndex = -1 then
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
  LTotalCutoff.Caption := 'Total cutoff: ' + secondstotimestring(total_cutoff);
  self.LResultingDuration.Caption := 'Resulting movie duration: ' + secondsToTimeString(resulting_duration);

  //Cuts in Trackbar are taken from global var "cutlist"!
  self.DSTrackBar1.Perform(CM_RECREATEWND, 0, 0);    //Show Cuts in Trackbar

  case cutlist.Mode of
    clmCutOut: self.RCutMode.ItemIndex := 0;
    clmCrop: self.RCutMode.ItemIndex := 1;
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
    self.LAuthor.Caption := cutlist.Author;
    self.PAuthor.Visible := true;
  end else begin
    self.PAuthor.Visible := false;
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
      MovieInfo.InitMovie(FileName);

      if MovieInfo.MovieType = mtwmv then begin
        self.ARepairMovie.Enabled := true;
      end else begin
        self.ARepairMovie.Enabled := false;
      end;

      {if not batchmode then }begin
        SourceAdded := false;

        if MovieInfo.MovieType in [mtwmv] then begin
          SampleGrabber1.FilterGraph := nil;
        end else begin
          SampleGrabber1.FilterGraph := FilterGraph;
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

          {if MovieInfo.MovieType in [mtAVI, mtMP4, mtUnknown] then begin
            //Try to load Haali Source Filter
            SourceFilter := AvailableFilters.GetBaseFilter(CLSID_HAALI);
            if assigned(SourceFilter) then begin
              CheckDSError((SourceFilter as IFileSourceFilter).Load(StringToOleStr(FileName), nil));
              CheckDSError((FilterGraph as IGraphBuilder).AddFilter(SourceFilter, StringToOleStr('Haali FileSource [' + extractFileName(FileName) + ']')));
              SourceAdded := true;
            end;
          end;}
          If Not (IsEqualGUID(Settings.GetPreferredSourceFilterByMovieType(MovieInfo.MovieType), GUID_NULL)) then begin
            SourceFilter := AvailableFilters.GetBaseFilter(Settings.GetPreferredSourceFilterByMovieType(MovieInfo.MovieType));
            if assigned(SourceFilter) then begin
              CheckDSError((SourceFilter as IFileSourceFilter).Load(StringToOleStr(FileName), nil));
              CheckDSError((FilterGraph as IGraphBuilder).AddFilter(SourceFilter, StringToOleStr('Source Filter [' + extractFileName(FileName) + ']')));
              SourceAdded := true;
            end;
          end;
        finally
          AvailableFilters.Free;
        end;

        if not sourceAdded then begin
          FilterGraph.RenderFile(FileName);
        end else begin
          PinLIst := TPinLIst.Create(SourceFilter);
          try
            for iPin := 0 to PinList.Count-1 do begin
              CheckDSError((FilterGraph as IGraphBuilder).Render(PinList.Items[iPin]));
            end;
          finally
            PinList.free;
          end;
        end;

        initVideo;
        if SampleGrabber1.FilterGraph = nil then begin
          InsertSampleGrabber;
          if not filtergraph.Active then begin
            showmessage('Could not insert sample grabber.');
            MovieInfo.current_filename := '';
            MovieInfo.MovieLoaded := false;
            MovieInfo.current_filesize := -1;
            exit;
          end;
        end;
        FilterGraph.Volume := self.TVolume.Position;
        GraphPause;

        //SampleGrabber1.SampleGrabber.SetCallback(self, 0);

        DSTrackBar1.TriggerTimer;
        self.PanelVideoWindowResize(self);
      end;

      self.Caption := Application_Friendly_Name + ' ' + extractfilename(MovieInfo.current_filename);
      application.Title := extractfilename(MovieInfo.current_filename);

      MovieInfo.MovieLoaded := true;
      result := true;
    finally
      screen.Cursor := TempCursor;
    end;
  end else begin
    if not batchmode then showmessage('File not found: ' + #13#10 + filename);
      MovieInfo.current_filename := '';
      MovieInfo.MovieLoaded := false;
  end;
end;

procedure TFMain.LoadCutList;
var
  filename, cutlist_path, cutlist_filename: string;
  CutlistMode_old: TCutlistMode;
  newCutlist : TCutlist;
begin
  if MovieInfo.current_filename = '' then begin
    showmessage('Please load movie first.');
    exit;
  end;

  //Use same settings as for saving as default
  cutlist_filename := ChangeFileExt(extractfilename(MovieInfo.current_filename), cutlist_Extension);
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

  CutlistOpenDialog.InitialDir := cutlist_path;
  CutlistOpenDialog.FileName := cutlist_filename;
  CutlistOpenDialog.Options := CutlistOpenDialog.Options + [ofNoChangeDir];
  if self.CutlistOpenDialog.Execute then begin
    filename := self.CutlistOpenDialog.FileName;
    CutlistMode_old := cutlist.Mode;
    cutlist.LoadFromFile(filename);
    if CutlistMode_old <> cutlist.Mode then begin
      newCutlist := cutlist.convert;
      newCutlist.RefreshCallBack := cutlist.RefreshCallBack;
      cutlist.Free;
      cutlist := newCutlist;
      cutlist.RefreshGUI;
    end;
  end;
end;

procedure TFMain.InitVideo;
var
  _ARw, _ARh : integer;
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
      end;                              }                                   //does not work ???
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
      basicvideo.get_AvgTimePerFrame(MovieInfo.frame_duration);
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
    MovieInfo.frame_duration := 0;
    //dwFourCC := 0;
    if succeeded(videowindow.QueryInterface(IBaseFilter, filter)) then  begin

      APin := getInPin(filter, 0);
      APin.ConnectionMediaType(MediaType);
      if isEqualGUID(MediaType.formattype, FORMAT_VideoInfo2) then begin
//              self.Label13.Caption := 'Format VideoInfo2';
        if Mediatype.cbFormat >= sizeof(VIDEOINFOHEADER2) then begin
          pVIH2 := mediatype.pbFormat;
          MovieInfo.frame_duration := pVIH2^.AvgTimePerFrame / 10000000;
          //dwFourCC := pVIH2^.bmiHeader.biCompression;
        end;
      end else begin
        if isEqualGUID(MediaType.formattype, FORMAT_VideoInfo) then begin
    //            self.Label13.Caption := 'Format VideoInfo';
          if Mediatype.cbFormat >= sizeof(VIDEOINFOHEADER) then begin
            pVIH := mediatype.pbFormat;
            MovieInfo.frame_duration := pVIH^.AvgTimePerFrame / 10000000;
            //dwFourCC := pVIH^.bmiHeader.biCompression;
          end;
        end;
      end;
//         samplegrabber.SetBMPCompatible(@MediaType, 32);
      freeMediaType(@MediaType);
    end else showmessage('Could not retrieve Renderer Filter.');

    if MovieInfo.frame_duration = 0 then begin
      //try calculating
      if succeeded(seeking.IsFormatSupported(TIME_FORMAT_MEDIA_TIME))
      and succeeded(seeking.IsFormatSupported(TIME_FORMAT_FRAME)) then begin
        seeking.SetTimeFormat(TIME_FORMAT_MEDIA_TIME);
        seeking.GetDuration(_dur_time);
        seeking.SetTimeFormat(TIME_FORMAT_FRAME);
        seeking.GetDuration(_dur_frames);
        if (_dur_frames > 0) and (_dur_time <> _dur_frames) then
          MovieInfo.frame_duration := (_dur_time / 10000000) / _dur_frames
        else MovieInfo.frame_duration := 0;
        seeking.SetTimeFormat(MovieInfo.TimeFormat)
      end;

      //deafault if nothing worked so far
      if MovieInfo.frame_duration = 0 then MovieInfo.frame_duration := 0.04;
    end;

    self.OpenCutlist.Enabled := true;
    self.ASearchCutlistByFileSize.Enabled := true;
    self.LDuration.Caption := MovieInfo.FormatPosition(MovieInfo.current_file_duration);

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
  event: INteger;
begin
  if isEqualGUID(MovieInfo.TimeFormat, TIME_FORMAT_MEDIA_TIME) then
    _pos := round(NewPosition * 10000000)
  else
    _pos := round(NewPosition);
  seeking.SetPositions(_pos, AM_SEEKING_AbsolutePositioning,
                       _pos, AM_SEEKING_NoPositioning);
  //filtergraph.State
  MediaEvent.WaitForCompletion(500, event);
  DSTrackBar1.TriggerTimer;
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

procedure TFMain.DSTrackBar1Timer(sender: TObject; CurrentPos,
  StopPos: Cardinal);
var
  TrueRate: double;
begin
  TrueRate := CalcTrueRate(self.DSTrackBar1.TimerInterval / 1000);
  if TrueRate > 0 then
    self.LTrueRate.Caption := '['+floattostrF(TrueRate, ffFixed, 15, 3) + 'x]'
  else
    self.LTrueRate.Caption := '[ ? x]';
  self.LPos.Caption := MovieInfo.FormatPosition(currentPosition);
end;

procedure TFMain.DSTrackBar1Change(Sender: TObject);
begin
  if self.DSTrackBar1.IsMouseDown then begin
      self.LPos.Caption := MovieInfo.FormatPosition(self.DSTrackBar1.position);
  end;
//  else self.LPos.Caption := FormatPosition(currentPosition);
end;

procedure TFMain.FilterGraphGraphStepComplete(Sender: TObject);
begin
  self.LPos.Caption := MovieInfo.FormatPosition(currentPosition);
  self.StepComplete := true;
end;

procedure TFMain.DSTrackBar1PositionChangedByMouse(Sender: TObject);
var
  event: integer;
begin
  MEdiaEvent.WaitForCompletion(500, event);
  self.LPos.Caption := MovieInfo.FormatPosition(currentPosition);
end;

procedure TFMain.TFinePosChange(Sender: TObject);
begin
  self.LFinePos.Caption := inttostr(self.TFinePos.Position);
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
  SampleGrabber1.FilterGraph := filtergraph;
  NullRenderer1.FilterGraph := filtergraph;

  try
    //Disconnect Video Window
    OleCheck(GetPin((VideoWindow as IBaseFilter), PINDIR_INPUT, 0,Rpin));
    OleCheck(Rpin.ConnectedTo(Spin));
    OleCheck((FilterGraph as IGraphBuilder).Disconnect(Rpin));
    OleCheck((FilterGraph as IGraphBuilder).Disconnect(Spin));

    //Get Pins
    OleCheck(GetPin((SampleGrabber1 as IBaseFilter), PINDIR_INPUT, 0, SGInpin));
    OleCheck(GetPin((SampleGrabber1 as IBaseFilter), PINDIR_OUTPUT, 0, SGOutpin));
    OleCheck(GetPin((NullRenderer1 as IBaseFilter), PINDIR_INPUT, 0, NRInpin));
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
  counter: integer;
const
  interval =100;
begin
  counter := 0;
  application.ProcessMessages;
  while (not self.StepComplete) and (counter < TimeOut) do begin
    sleep(interval);
    counter := counter + Interval;
    application.ProcessMessages;
  end;
  result := self.StepComplete;
end;

procedure TFMain.PanelVideoWindowResize(Sender: TObject);
var
  movie_ar, my_ar: double;
begin
  movie_ar := MovieInfo.ratio;
  my_ar := self.PanelVideoWindow.Width / self.PanelVideoWindow.Height;
  if my_ar > movie_ar then begin
    self.VideoWindow.Height := self.PanelVideoWindow.Height;
    self.VideoWindow.Width := round (self.videowindow.Height * movie_ar);
  end else begin
    self.VideoWindow.Width := self.PanelVideoWindow.Width;
    self.VideoWindow.Height := round(self.VideoWindow.Width / movie_ar);
  end; 
end;

procedure TFMain.showframesAbs(startframe, endframe: double;
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

  numberOfFrames := 12;                     // not to change so far
  distance := (endframe - startframe) / (numberofFrames-1);

  filtergraph.Pause;
  WaitForFiltergraph;
  
  FFrames.Show;
  pos := currentPosition;

  //  counter:= 0;
  for iImage := 0 to numberOfFrames-1 do begin
    Target := FFrames.Frame[iImage];
    temp_pos := startframe + (iImage * distance);
    if (temp_pos >= 0) and (temp_pos <= MovieInfo.current_file_duration) then begin

      SampleTarget := Target; //set sampleTarget to trigger samplegrabber.onbuffer method
      jumpto(temp_pos);
      WaitForFiltergraph;

      Target.image.visible := true;
    end else begin
      Target.image.visible := false;
      Target.position := 0;
    end;
  end;
  JumpTo(pos);
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

procedure TFMain.BConvertClick(Sender: TObject);
var
  newCutlist: TCutlist;
begin
  if cutlist.Count = 0 then exit;
  newCutlist := cutlist.convert;
  newCutlist.RefreshCallBack := cutlist.RefreshCallBack;
  cutlist.Free;
  cutlist := newCutlist;
  cutlist.RefreshGUI;
end;

procedure TFMain.ShowMetaData;
const
  stream = $0;
var
//    MetaEditor: IWMMetadataEditor;
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

  frmMemoDialog.Caption := 'Movie Meta Data';
  frmMemoDialog.memInfo.Clear;
  frmMemoDialog.memInfo.Lines.Add('Filetype: ' + MovieInfo.MovieTypeString);
  frmMemoDialog.memInfo.Lines.Add('Filename: ' + MovieInfo.current_filename);
  frmMemoDialog.memInfo.Lines.Add('Frame Rate: ' + FloatToStrF(1/MovieInfo.frame_duration, ffFixed, 15, 4));

  if MovieInfo.MovieType = mtAVI then begin
    frmMemoDialog.memInfo.Lines.Add('Video FourCC: ' + fcc2string(MovieInfo.FFourCC));
  end;
  if MovieInfo.MovieType = mtWMV then begin
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
              else _text := '***unknown data format***';
            end;
            _text := widechartoString(PWidechar(_name)) +': ' + _text;
            frmMemoDialog.memInfo.Lines.Add(_text);
          end;
        end;
      finally
        filterlist.Free;
      end;
    end else begin
      frmMemoDialog.memInfo.Lines.Add('***Could not find interface***');
      filterlist.Free;
    end;
  end;
  frmMemoDialog.ShowModal;
end;

procedure TFMain.DSTrackBar1SelChanged(Sender: TObject);
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
  if self.DSTrackBar1.SelEnd-self.DSTrackBar1.SelStart > 0 then
    ScanInterval.Enabled := true
  else
    ScanInterval.Enabled := false;
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
    FileList.Free;
  end;
  inherited;
end;

procedure TFMain.ProcessFileList(FileList: TStringList; IsMyOwnCommandLine: boolean);
var
  iString: INteger;
  Pstring, filename_movie, filename_cutlist, filename_upload_cutlist: string;
  upload_cutlist, found_movie, found_cutlist, try_cutlist_download, get_empty_cutlist: boolean;
begin
  found_movie := false;
  found_cutlist := false;
  upload_cutlist := false;
  try_cutlist_download := false;
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
      if not batchmode then showmessage('Can not load Cutlist. Please load movie first.');
    end;
  end;

  if TryCutting then begin
    if MovieInfo.current_filename <>'' then begin
      if not StartCutting then
        if IsMyOwnCommandLine then ExitCode := 128;
    end;
  end;
end;

procedure TFMain.SaveCutlistAsExecute(Sender: TObject);
begin
  if cutlist.Save(true) then
    showmessage('Cutlist saved successfully to' +#13#10 + cutlist.SavedToFilename);
end;

procedure TFMain.OpenMovieExecute(Sender: TObject);

  function FilterStringFromExtArray(ExtArray: array of string): string;
  var
    i: Integer;
  begin
    result := '';
    for i := 0 to length(ExtArray) - 1 do begin
      if i> 0 then result := result + ';';
      result := result + '*' + ExtArray[i];
    end;
  end;

var
  OpenDialog: TOpenDialog;
  ExtList, ExtListAllSupported: string;
begin
  //if not AskForUserRating(cutlist) then exit;
  //if not cutlist.clear_after_confirm then exit;

  OpenDialog := TOpenDialog.Create(self);
  try
    OpenDialog.Options := OpenDialog.Options + [ofPathMustExist, ofFileMustExist];

    // Make Filter List
    ExtList := FilterStringFromExtArray(WMV_EXTENSIONS);
    ExtListAllSupported := extList;
    OpenDialog.Filter := 'Windows Media Files ('+ExtList+')|' + ExtList;
    ExtList := FilterStringFromExtArray(AVI_EXTENSIONS);
    ExtListAllSupported := ExtListAllSupported + ';' + extList;
    OpenDialog.Filter := OpenDialog.Filter + '|AVI Files ('+ExtList+')|' + ExtList;
    ExtList := FilterStringFromExtArray(MP4_EXTENSIONS);
    ExtListAllSupported := ExtListAllSupported + ';' + extList;
    OpenDialog.Filter := OpenDialog.Filter + '|MP4 Files ('+ExtList+')|' + ExtList;
    OpenDialog.Filter := 'All Supported Files ('+ExtListAllSupported+')|' + ExtListAllSupported + '|' + OpenDialog.Filter;
    OpenDialog.Filter := OpenDialog.Filter + '|All Files|*.*';
    OpenDialog.InitialDir := settings.CurrentMovieDir;
    if OpenDialog.Execute then begin
      settings.CurrentMovieDir := ExtractFilePath(openDialog.FileName);
      openfile(opendialog.FileName);
    end;
  finally
    OpenDialog.Free;
  end;
end;

procedure TFMain.OpenCutlistExecute(Sender: TObject);
begin
  LoadCutlist;
end;

procedure TFMain.File_ExitExecute(Sender: TObject);
begin
  self.Close;
end;

procedure TFMain.AddCutExecute(Sender: TObject);
begin
  if cutlist.AddCut(pos_from, pos_to) then begin
    pos_from := 0;
    pos_to := 0;
    refresh_times;
  end;
end;

procedure TFMain.ReplaceCutExecute(Sender: TObject);
var
  dcut: integer;
begin
  if self.Lcutlist.SelCount = 0 then begin
    self.enable_del_buttons(false);
    exit;
  end;
  dcut := strtoint(self.Lcutlist.Selected.caption);
  cutlist.ReplaceCut(pos_from, pos_to, dCut);
end;

procedure TFMain.EditCutExecute(Sender: TObject);
var
  dcut: integer;
begin
  if self.Lcutlist.SelCount = 0 then begin
    self.enable_del_buttons(false);
    exit;
  end;
  dcut := strtoint(self.Lcutlist.Selected.caption);
  pos_from := cutlist[dcut].pos_from;
  pos_to := cutlist[dcut].pos_to;
  refresh_times;
end;

procedure TFMain.DeleteCutExecute(Sender: TObject);
begin
  if self.Lcutlist.SelCount = 0 then begin
    self.enable_del_buttons(false);
    exit;
  end;
  cutlist.DeleteCut(strtoint(self.Lcutlist.Selected.caption));
end;

procedure TFMain.ShowFramesFormExecute(Sender: TObject);
begin
  FFrames.Show;
end;

procedure TFMain.Next12Execute(Sender: TObject);
var
  c: TCursor;
begin
  c := self.Cursor;
  try
    EnableMovieControls(false);
  //  self.Next12.Enabled := false;
    self.Cursor := crHourGlass;
    application.ProcessMessages;
    showframes(1, 12);
  finally
    EnableMovieControls(true);
    //self.Next12.Enabled := true;;
    self.Cursor := c;
  end;
end;

procedure TFMain.Prev12Execute(Sender: TObject);
var
  c: TCursor;
begin
  c := self.Cursor;
  try
    EnableMovieControls(false);
    //self.Prev12.Enabled := false;
    self.Cursor := crHourGlass;
    application.ProcessMessages;
    showframes(-12, -1);
  finally
    EnableMovieControls(true);
    //self.Prev12.Enabled := true;
    self.Cursor := c;
  end;
end;

procedure TFMain.ScanIntervalExecute(Sender: TObject);
var
  i1, i2: integer;
  pos1, pos2: double;
  c: TCursor;
begin
  i1 := FFrames.scan_1;
  i2 := FFrames.scan_2;

  if (i1 = -1) or (i2 =-1) then begin
    pos1 := self.DSTrackBar1.SelStart;
    pos2 := self.DSTrackBar1.SelEnd;
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
  self.ScanInterval.Enabled := false;
  self.Cursor := crHourGlass;
  application.ProcessMessages;

  showframesabs(pos1, pos2, 12);

  self.ScanInterval.Enabled := true;
  self.Cursor := c;
end;

procedure TFMain.EditSettingsExecute(Sender: TObject);
begin
  settings.edit;
  self.IdHTTP1.ProxyParams.ProxyServer := settings.proxyServerName;
  self.IdHTTP1.ProxyParams.ProxyPort := settings.proxyPort;
  self.IdHTTP1.ProxyParams.ProxyUsername := settings.proxyUserName;
  self.IdHTTP1.ProxyParams.ProxyPassword := settings.proxyPassword;    
end;

procedure TFMain.AStartCuttingExecute(Sender: TObject);
begin
  StartCutting;
end;

procedure TFMain.MovieMetaDataExecute(Sender: TObject);
begin
  ShowMetaData;
end;

procedure TFMain.UsedFiltersExecute(Sender: TObject);
begin
  FManageFilters.SourceGraph := FilterGraph;
  FManageFilters.show;
end;

procedure TFMain.AboutExecute(Sender: TObject);
begin
  showmessage('Cut Assistant' + #13#10 + 'Version ' + Application_version+ #13#10#13#10 + 'Author: 1248');
end;
           
procedure TFMain.WriteToRegistyExecute(Sender: TObject);
var
  reg : TRegistry;
  myDir: string;
begin
  myDir := application.ExeName;
  reg := Tregistry.Create;
  reg.RootKey := HKEY_CLASSES_ROOT;
  reg.OpenKey('\' + cutlist_Extension, true);
  reg.WriteString('', CutlistID);
  reg.WriteString('Content Type', CUTLIST_CONTENT_TYPE);
  reg.CloseKey;

  reg.OpenKey('\'+CutlistID, true);
  reg.WriteString('', 'Cutlist for Cut Assistant');
  reg.OpenKey('DefaultIcon', true);
  reg.WriteString('', '"' + myDir+'",0');
  reg.CloseKey;

  reg.OpenKey('\'+CutlistID+'\Shell\open', true);
  reg.WriteString('', 'Open with Cut Assistant');
  reg.OpenKey('command', true);
  reg.WriteString('', '"' + myDir + '" -cutlist:"%1"');
  reg.CloseKey;

  reg.OpenKey('\WMVFile\Shell', true);
  reg.OpenKey(ShellEditKey, true);
  reg.WriteString('', 'Edit with Cut Assistant');
  reg.OpenKey('command', true);
  reg.WriteString('', '"' + myDir + '" -open:"%1"');
  reg.CloseKey;

  reg.OpenKey('\AVIFile\Shell', true);
  reg.OpenKey(ShellEditKey, true);
  reg.WriteString('', 'Edit with Cut Assistant');
  reg.OpenKey('command', true);
  reg.WriteString('', '"' + myDir + '" -open:"%1"');
  reg.CloseKey;

  reg.OpenKey('\QuickTime.mp4\Shell', true);
  reg.OpenKey(ShellEditKey, true);
  reg.WriteString('', 'Edit with Cut Assistant');
  reg.OpenKey('command', true);
  reg.WriteString('', '"' + myDir + '" -open:"%1"');
  reg.CloseKey;

  reg.OpenKey('\Applications', true);
  reg.OpenKey(ProgID, true);
  reg.OpenKey('shell', true);
  reg.OpenKey('open', true);
  reg.WriteString('FriendlyAppName', 'Cut Assistant');
  reg.OpenKey('command', true);
  reg.WriteString('', '"' + myDir + '" -open:"%1"');
  reg.CloseKey;

  reg.Free;
end;

procedure TFMain.RemoveRegistryEntriesExecute(Sender: TObject);
var
  reg : TRegistry;
  myDir: string;
begin
  myDir := application.ExeName;
  reg := Tregistry.Create;
  reg.RootKey := HKEY_CLASSES_ROOT;
  reg.DeleteKey('\'+cutlist_Extension);
  reg.DeleteKey('\'+CutlistID);

  reg.OpenKey('\WMVFile\Shell', true);
  reg.DeleteKey(ShellEditKey);
  reg.CloseKey;

  reg.OpenKey('\AVIFile\Shell', true);
  reg.DeleteKey(ShellEditKey);
  reg.CloseKey;

  reg.OpenKey('\QuickTime.mp4\Shell', true);
  reg.DeleteKey(ShellEditKey);
  reg.CloseKey;

  reg.OpenKey('\Applications', true);
  reg.DeleteKey(ProgID);
  reg.CloseKey;

  reg.Free;
end;

procedure TFMain.RCutModeClick(Sender: TObject);
begin
  case self.RCutMode.ItemIndex of
    0: cutlist.Mode := clmCutOut;
    1: cutlist.Mode := clmCrop;
  end;
end;

procedure TFMain.CutlistUploadExecute(Sender: TObject);
var
  message_String: string;
begin
  if cutlist.HasChanged then begin
    if not cutlist.Save(false) then exit; //try to save it
  end;

	if not fileexists(cutlist.SavedToFilename) then exit;

  message_string := 'Your Cutlist ' + #13#10 + cutlist.SavedToFilename +#13#10+
                    'will now be uploaded to the following site: '+ #13#10 + settings.url_cutlists_upload +#13#10+
                    'Continue?';
  if not (application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONINFORMATION) = IDYES) then begin
    exit;
  end;

  UploadCutlist(cutlist.SavedToFilename);
end;

procedure TFMain.StepForwardExecute(Sender: TObject);
var
  event: integer;
begin
  if not (FilterGraph.State = gsPaused) then GraphPause;
  if assigned(FrameStep) then begin
    FrameStep.Step(1, nil);
    MediaEvent.WaitForCompletion(500, event);
    DSTrackBar1.TriggerTimer;
  end else
    self.StepForward.Enabled := false;
end;

procedure TFMain.StepBackwardExecute(Sender: TObject);
var
  new_pos: double;
begin
  if not (FilterGraph.State = gsPaused) then GraphPause;
  new_pos := currentPosition - MovieInfo.frame_duration;
  JumpTo(new_pos);
end;

procedure TFMain.BrowseWWWHelpExecute(Sender: TObject);
begin
    ShellExecute(0, nil, PChar(settings.url_help), '', '', SW_SHOWNORMAL);
end;

procedure TFMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
const
  VK_MEDIA_PLAY_PAUSE=$B3;
begin
//  showmessage(inttostr(key));
  case key of
    ord('K'), ord(' '), VK_MEDIA_PLAY_PAUSE: begin
        GraphPlayPause;
        Key := 0;
      end;
  end;
end;

procedure TFMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  message_string: string;
begin
  if cutlist.HasChanged then begin
    message_string := 'Save changes in current cutlist?';
    case application.messagebox(PChar(message_string), 'Cutlist not saved', MB_YESNOCANCEL + MB_DEFBUTTON3 + MB_ICONQUESTION) of
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

procedure TFMain.OpenCutlistHomeExecute(Sender: TObject);
begin
  ShellExecute(0, nil, PChar(settings.url_cutlists_home), '', '', SW_SHOWNORMAL);
end;

procedure TFMain.CloseMovie;
begin
  if filtergraph.Active then begin
    filtergraph.Stop;
    filtergraph.Active := false;
    filtergraph.ClearGraph;
    samplegrabber1.FilterGraph := nil;
    TeeFilter.FilterGraph := nil;
    NullRenderer1.FilterGraph := nil;
//    AviDecompressor.FilterGraph := nil;
  end;
  MovieInfo.current_filename := '';
  MovieInfo.current_filesize := -1;
  MovieInfo.MovieLoaded := false;

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
  if movieinfo.MovieType <> mtWMV then exit;
  
  CutApplication := Settings.GetCutApplicationByName('Asfbin') as TCutApplicationAsfbin;
  if not assigned (CutApplication) then begin
    showmessage('Could not get Object CutApplication Asfbin.');
    exit;
  end;

  if MovieInfo.current_filename = '' then begin
    selectFileDlg := TOpenDialog.Create(self);
    selectFileDlg.Filter := 'Asf Movie files|*.wmv;*.asf|All files|*.*';
    selectFileDlg.Options := selectFileDlg.Options + [ofPathMustExist, ofFileMustExist, ofNoChangeDir];
    selectFileDlg.Title := 'Select File to be repaired:';
    if selectFileDlg.Execute then begin
      filename_temp := selectFileDlg.FileName;
      selectFileDlg.Free;
    end else begin
      selectFileDlg.Free;
      exit;
    end;
  end else begin
    filename_temp := MovieInfo.current_filename;
  end;

  file_ext := extractfileExt(filename_temp);
  filename_damaged := changeFileExt(filename_temp, '.damaged' + file_ext);

  message_string := 'Current movie will be repaired using ' + extractFileName(CutApplication.Path) + '.' + #13#10 +
                    'Original file will be saved as ' +#13#10+ filename_damaged + #13#10 +
                    'Continue?';
  if not (application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONINFORMATION) = IDYES) then begin
    exit;
  end;

  CloseMovie;

  if not renameFile(filename_temp, filename_damaged) then begin
    showmessage('Could not rename original file. Abort.');
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
      message_string := 'Finished repairing movie. Open repaired movie now?';
      if (application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONINFORMATION) = IDYES) then begin
        self.OpenFile(filename_temp);
      end;
    end;
  end;
end;

procedure TFMain.ARepairMovieExecute(Sender: TObject);
begin
  self.RepairMovie;
end;


procedure TFMain.ACutlistInfoExecute(Sender: TObject);
begin
  cutlist.EditInfo;
end;


procedure TFMain.ASaveCutlistExecute(Sender: TObject);
begin
  if cutlist.Save(false) then
    showmessage('Cutlist saved successfully to' +#13#10 + cutlist.SavedToFilename);
end;

procedure TFMain.ACalculateResultingTimesExecute(Sender: TObject);
var
  selectFileDlg: TOpenDialog;
begin
  if (MovieInfo.target_filename = '') then begin
    selectFileDlg := TOpenDialog.Create(self);
    selectFileDlg.Filter := 'Supported Movie files|*.wmv;*.asf;*.avi|All files|*.*';
    selectFileDlg.Options := selectFileDlg.Options + [ofPathMustExist, ofFileMustExist, ofNoChangeDir];
    selectFileDlg.Title := 'Select File to check:';
    selectFileDlg.InitialDir := settings.CutMovieSaveDir;
    if selectFileDlg.Execute then begin
      MovieInfo.target_filename := selectFileDlg.FileName;
      selectFileDlg.Free;
    end else begin
      selectFileDlg.Free;
      exit;
    end;
  end;

  if not fileexists(MovieInfo.target_filename) then begin
    showmessage('Movie File not found.');
  end else begin
    if not FResultingTimes.loadMovie(MovieInfo.target_filename) then begin
      showmessage('Could not load cut movie.');
      exit;
    end;
    FResultingTimes.calculate(cutlist);
    FResultingTimes.Show;
  end;
end;

procedure TFMain.AAsfbinInfoExecute(Sender: TObject);
var
  info: string;
  CutApplication: TCutApplicationBase;
begin
  info := '';

  CutApplication := Settings.GetCutApplicationByMovieType(mtWMV);
  if assigned(CutApplication) then begin
    info := info + 'WMV Cut Application' + #13#10;
    info := info + CutApplication.InfoString + #13#10;
  end;

  CutApplication := Settings.GetCutApplicationByMovieType(mtAVI);
  if assigned(CutApplication) then begin
    info := info + 'AVI Cut Application' + #13#10;
    info := info + CutApplication.InfoString + #13#10;
  end;

  CutApplication := Settings.GetCutApplicationByMovieType(mtMP4);
  if assigned(CutApplication) then begin
    info := info + 'MP4 Cut Application' + #13#10;
    info := info + CutApplication.InfoString + #13#10;
  end;

  CutApplication := Settings.GetCutApplicationByMovieType(mtUnknown);
  if assigned(CutApplication) then begin
    info := info + 'Other Cut Application' + #13#10;
    info := info + CutApplication.InfoString + #13#10;
  end;

  //showmessage(info);
  frmMemoDialog.Caption := 'Cut Application Settings';
  frmMemoDialog.memInfo.Clear;
  frmMemoDialog.memInfo.Text := info;
  frmMemoDialog.ShowModal;
end;

function TFMain.SearchCutlistsByFileSize_XML: boolean;
const
  php_name = 'getxml.php';
  command = '?ofsb=';
var
  error_message: string;
  Response: TMemoryStream;
  CutlistNode: IXMLNode;
begin
  result := false;
  if (MovieInfo.current_filesize = 0) or (MovieInfo.current_filename = '') then exit;
  self.IdHTTP1.HandleRedirects := false;
  Error_message := 'Unknown error.';

  response := TMemoryStream.Create;

  try
    try
      self.IdHTTP1.Get(settings.url_cutlists_home + php_name + command + inttostr(MovieInfo.current_filesize) +'&version=' + Application_Version, Response);
      result := true;
    except
      on E: EIdProtocolReplyError do begin
        case E.ReplyErrorCode of
          404, 302: begin
                      Error_message := 'File not found on server: ' + settings.url_cutlists_home + php_name + ' .';
                    end;
          else raise;
        end;
      end;
      else begin
        raise;
      end;
    end;

    if result then begin
      if response.Size > 5 then begin
        XMLDocument1.LoadFromStream(Response);
        FCutlistSearchResults.LLinklist.Clear;

        if XMLDocument1.DocumentElement.ChildNodes.Count > 0 then begin
          CutlistNode := XMLDocument1.DocumentElement.ChildNodes.First;
          repeat
            with FCutlistSearchResults.LLinklist.Items.Add do begin
              Caption := CutlistNode.ChildNodes['id'].Text;
              SubItems.Add(CutlistNode.ChildNodes['name'].Text);
              SubItems.Add(CutlistNode.ChildNodes['rating'].Text);
              SubItems.Add(CutlistNode.ChildNodes['ratingcount'].Text);
              SubItems.Add(CutlistNode.ChildNodes['ratingbyauthor'].Text);
              SubItems.Add(CutlistNode.ChildNodes['author'].Text);
              SubItems.Add(CutlistNode.ChildNodes['usercomment'].Text);
              SubItems.Add(CutlistNode.ChildNodes['actualcontent'].Text);
            end;
            CutlistNode := CutlistNode.NextSibling;
          until CutlistNode = nil;

          if FCutlistSearchResults.ShowModal = mrOK then begin
            //result := self.DownloadCutlist(FCutlistSearchResults.Llinklist.Selected.SubItems[0]);
            result := self.DownloadCutlistByID(FCutlistSearchResults.Llinklist.Selected.Caption, FCutlistSearchResults.Llinklist.Selected.SubItems[0]);
            if result then begin
              //DownloadListAddCutlist(FCutlistSearchResults.Llinklist.Selected.SubItems[0], FCutlistSearchResults.Llinklist.Selected.Caption);

              cutlist.IDOnServer :=  FCutlistSearchResults.Llinklist.Selected.Caption;
              self.ASendRating.Enabled := true;
            end;
          end;
        end else begin
          showmessage('Search Cutlist by File Size: No Cutlist found.');
        end;
      end else begin
        showmessage('Search Cutlist by File Size: No Cutlist found.');
      end;
    end;
  finally
    response.Free;
  end;
end;

{function TFMain.DownloadCutlist(cutlist_name: string): boolean;
var
  MemoryStream: TMemoryStream;
  message_string, error_message: string;
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
  target_file := cutlist_path + cutlist_name;

  if cutlist.HasChanged and (not batchmode) then begin
    message_string := 'Trying to download this cutlist:' + #13#10 + cutlist_name +#13#10+
                      'Existing cutlist is not saved and will be overwritten.' +#13#10+
                      'Continue?';
    if not (application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONINFORMATION) = IDYES) then begin
      exit;
    end;
  end;

  MemoryStream := TMemoryStream.Create;
  //FileStream := TFileStream.Create(target_file, fmCreate);
  self.IdHTTP1.HandleRedirects := false;
  Error_message := 'Unknown error.';


  url := settings.url_cutlists_download_dir + cleanurl(cutlist_name);

  try
    try
      self.IdHTTP1.Get(url, MemoryStream);
      if fileexists(target_file) then begin
        if not batchmode then begin
          message_string := 'Target File exists already:' + #13#10 + target_file +#13#10+
                            'Overwrite?';
          if not (application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONQUESTION) = IDYES) then begin
            exit;
          end;
        end;
        if not deletefile(target_file) then begin
          if not batchmode then showmessage('Could not delete existing file ' + target_file + '. Abort.');
          exit;
        end;
      end;
      MemoryStream.SaveToFile(target_file);
      result := true;
    finally
      MemoryStream.Free;
    end;
  except
    on E: EIdProtocolReplyError do begin
      case E.ReplyErrorCode of
        404, 302: begin
                    Error_message := 'File not found on server: ' + settings.url_cutlists_download_dir + ' .';
                  end;
        else raise;
      end;
    end;
    else begin
      raise;
    end;
  end;

  if result then begin
    cutlist.LoadFromFile(target_file);
  end else begin
    if not batchmode then begin
      message_string := Error_message + #13#10 +  'Open cutlist homepage in webbrowser?';
      if (application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONQUESTION) = IDYES) then begin
        ShellExecute(0, nil, PChar(settings.url_cutlists_home), '', '', SW_SHOWNORMAL);
      end;
    end;
  end;
end; }

procedure TFMain.ASearchCutlistByFileSizeExecute(Sender: TObject);
begin
  self.SearchCutlistsByFileSize_XML;
end;


function TFMain.SendRating(Cutlist: TCutlist): boolean;
const
  php_name = 'rate.php';
  command = '?rate=';
var
  Response, Error_message: string;
begin
  result := false;
  if cutlist.IDOnServer = '' then begin
    ASendRating.Enabled := false;
    Showmessage('Current cutlist was not downloaded. Rating not possible.');
    exit;
  end else begin
{    if cutlist.RatingByAuthorPresent then
      FCutlistRate.RGRatingByAuthor.ItemIndex := cutlist.RatingByAuthor
    else}
      FCutlistRate.RGRatingByAuthor.ItemIndex := -1;
    FCutlistRate.ButtonOK.Enabled := false;
    if FCutlistRate.ShowModal = mrOK then begin

      self.IdHTTP1.HandleRedirects := true;
      Error_message := 'Unknown error.';

      try
        try
          Response := self.IdHTTP1.Get(settings.url_cutlists_home
                                        + php_name + command +cutlist.IDOnServer
                                        +'&rating=' + inttostr(FCutlistRate.RGRatingByAuthor.ItemIndex)
                                        +'&userid=' + settings.UserID
                                        +'&version=' + Application_Version);
          result := true;
        finally
        end;
      except
        on E: EIdProtocolReplyError do begin
          case E.ReplyErrorCode of
            404, 302: begin
                        Error_message := 'File not found on server: ' + settings.url_cutlists_home + php_name + ' .';
                      end;
            else raise;
          end;
        end;
        else begin
          raise;
        end;
      end;

      if result then begin
        if AnsiContainsText(Response, '<html>') then begin
          cutlist.RatingSent := true;
          showmessage ('Rating done.');
        end else begin
          showmessage('Answer from Server:' + #13#10 + leftstr(response, 255));
        end;
      end;
    end;
  end;
end;


procedure TFMain.ASendRatingExecute(Sender: TObject);
begin
  self.SendRating(cutlist);
end;

procedure TFMain.SampleGrabber1Buffer(sender: TObject; SampleTime: Double;
  pBuffer: Pointer; BufferLen: Integer);
var
  Target: TCutFrame;
  TargetBitmap: TBitmap;
begin
{  MovieInfo.current_position_seconds := SampleTime;
  LPos.Caption := MovieInfo.current_position_string;   }

  if SampleTarget = nil then exit;
  Target := (SampleTarget as TCutFrame);
  try
//    SampleGrabber1.GetBitmap(Target.Image.Picture.Bitmap, pBuffer, BufferLen);
    self.CustomGetSampleGrabberBitmap(Target.Image.Picture.Bitmap, pBuffer, BufferLen);
    Target.position := SampleTime;
  finally
    SampleTarget := nil;
  end;
end;

{function TFMain.CreateVDubScript(cutlist: TCutlist; Inputfile, Outputfile: String; var scriptfile: string): boolean;
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
  result := false;
  if scriptfile = '' then scriptfile := Inputfile + '.syl';
  assignfile(f, scriptfile);
  rewrite(f);
  writeln(f, '// Virtual Dub Sylia Script');
  writeln(f, '// Generated by ' + Application_friendly_name);
  writeln(f, 'VirtualDub.Open("' + EscapeString(Inputfile) + '",0,0);');
  writeln(f, 'VirtualDub.audio.SetMode(0);');
  if settings.VDUseSmartRendering then begin
    writeln(f, 'VirtualDub.video.SetMode(1);');      //fast Recompression
    writeln(f, 'VirtualDub.video.SetSmartRendering(1);');
    writeln(f, 'VirtualDub.video.SetCompression(0x' + IntToHex(settings.VDUseCodec, 8) + ',0,10000,0);');
    if settings.VDCodecSettings > '' then begin
      writeln(f, 'VirtualDub.video.SetCompData(' + inttostr(settings.VDCodecSettingsSize) + ',"' + settings.VDCodecSettings + '");');
    end;
  end else begin
    writeln(f, 'VirtualDub.video.SetMode(0);');
  end;
  writeln(f, 'VirtualDub.subset.Clear();');

  if cutlist.Mode = clmCrop then begin
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
  end else begin
    cutlist_tmp := cutlist.convert;
    for i := 0 to cutlist_tmp.Count -1 do begin
      if cutlist_tmp.FramesPresent and not cutlist_tmp.HasChanged then begin
        vdubstart := inttostr(cutlist_tmp.Cut[i].frame_from);
        vdubLength := inttostr(cutlist_tmp.Cut[i].DurationFrames);
      end else begin
        vdubstart := inttostr(round(cutlist_tmp.Cut[i].pos_from / MovieInfo.frame_duration));
        vdubLength := inttostr(round((cutlist_tmp.Cut[i].pos_to - cutlist_tmp.Cut[i].pos_from) / MovieInfo.frame_duration + 1));
      end;
      writeln(f, 'VirtualDub.subset.AddRange(' + vdubstart + ', ' + vdubLength + ');');
    end;
    cutlist_tmp.Free;
  end;

  writeln(f, 'VirtualDub.SaveAVI(U"'+OutputFile+'");');   //For OUTPUT use undecorated string!
  if not settings.VDNotClose then writeln(f, 'VirtualDub.Close();');

  closefile(f);
  result := true;
end;    }

procedure TFMain.LcutlistDblClick(Sender: TObject);
begin
  self.EditCut.Execute;
end;

function TFMain.UploadCutlist(filename: string): boolean;
var
  Stream:       TIdMultiPartFormDataStream;
  StringStream: TStringStream;
  Response, Answer: string;
  Cutlist_id: Integer;
  lines: TStringList;
  begin_answer: integer;
begin
  result := false;
  if fileexists(filename) then begin
    Stream := TIdMultiPartFormDataStream.Create;
    StringStream := TStringStream.Create('');
    self.IdHTTP1.HandleRedirects := true;
    try
      Stream.AddFormField('MAX_FILE_SIZE','1587200');
      Stream.AddFormField('confirm','true');
      Stream.AddFormField('type','blank');
      Stream.AddFormField('userid', settings.UserID);
      Stream.AddFormField('version', application_version);
      Stream.AddFile('userfile[]',filename, 'multipart/form-data');
      Response := FMain.IdHTTP1.Post(settings.url_cutlists_upload, Stream);

      result := true;

      lines := TStringLIst.Create;
      lines.Delimiter := #10;
      lines.NameValueSeparator := '=';
      lines.DelimitedText := response;
      if trystrtoInt(lines.values['id'], Cutlist_id) then begin
        self.UploadData.Append;
        self.UploadDataid.Value := inttostr(Cutlist_id);
        self.UploadDataname.Value := extractFileName(filename);
        self.UploadDataDateTime.Value := now();
        self.UploadData.Post;
        self.UploadData.SaveToFile(UploadData_Path, dfXMLUTF8);
      end;
      begin_answer := LastDelimiter(#10, response)+1;
      Answer := midstr(response, begin_answer, length(response)-begin_answer+1); //Last Line
      lines.Free;
      if not batchmode then showmessage('Server responded:' + #13#10 + answer);

    finally
      Stream.Free;
      StringStream.Free;
    end;
  end;
end;

procedure TFMain.ADeleteCutlistFromServerExecute(Sender: TObject);
var
  datestring: string;
begin
  //Fill ListView
  FUploadList.LLinklist.Clear;
  UploadData.First;
  while not uploadData.Eof do begin
    with FUploadList.LLinklist.Items.Add do begin
      Caption := self.UploadDataid.Value;
      SubItems.Add(self.UploadDataname.Value);
      dateTimeToString(DateString, 'ddddd tt', self.UploadDataDateTime.Value);
      SubItems.Add(DateString);
    end;
    UploadData.Next
  end;

  //Show Dialog and delete cutlist
  if (FUploadList.ShowModal = mrOK) and (FUploadList.LLinklist.SelCount = 1) then begin
    if self.DeleteCutlistFromServer(FUploadList.LLinklist.Selected.Caption) then begin
      //Success, so delete Record in upload list
      UploadData.RecNo := FUploadList.LLinklist.ItemIndex + 1;
      UploadData.Delete;
//      UploadData.ApplyUpdates(-1);
    end;
  end;
end;

function TFMain.DeleteCutlistFromServer(const cutlist_id: string): boolean;
const
  php_name = 'delete_cutlist.php';
var
  url, Response, Error_message, Answer: string;
  lines: TStringList;
begin
  result := false;
  if cutlist_id='' then exit;

  self.IdHTTP1.HandleRedirects := true;
  Error_message := 'Unknown error.';

  Response:='';
  url := settings.url_cutlists_home + php_name + '?'
       + 'cutlistid=' + cutlist_id
       + '&userid=' + settings.UserID
       + '&version=' + Application_Version;
  try
    try
      Response := self.IdHTTP1.Get(url);
    finally
    end;
  except
    on E: EIdProtocolReplyError do begin
      case E.ReplyErrorCode of
        404, 302: begin
                    Error_message := 'File not found on server: ' + settings.url_cutlists_home + php_name + ' .';
                  end;
        else raise;
      end;
    end;
    else begin
      raise;
    end;
  end;

  if response<>'' then begin
    response := ansilowercase(response);
    if AnsiContainsText(Response, 'removedfile') then begin
      result := true;
      lines := TStringLIst.Create;
      lines.Delimiter := #10;
      lines.NameValueSeparator := '=';
      lines.DelimitedText := response;
      if lines.Values['removedfile'] = '1' then begin
        answer := answer + 'File removed.' + #13#10;
      end else begin
        answer := answer + 'File NOT removed.' + #13#10;
        result := false;
      end;
      if lines.Values['removedentry'] = '1' then begin
        answer := answer + 'Database entry removed.' + #13#10;
      end else begin
        answer := answer + 'Database entry NOT removed.' + #13#10;
        result := false;
      end;
      lines.Free;
      showmessage(answer);
    end else begin
      result := false;
      showmessage ('Delete command sent to server, but recieved unexpected response from server.');
    end;
  end;
end;

procedure TFMain.DSTrackBar1ChannelPostPaint(Sender: TDSTrackBarEx;
  const ARect: TRect);
var
  scale: double;
  iCut: INteger;
  CutRect: TRect;
begin
  if MovieInfo.current_file_duration = 0 then exit;
  if cutlist.Mode = clmCrop then
    DSTrackbar1.ChannelCanvas.Brush.Color := clgreen
  else
    DSTrackbar1.ChannelCanvas.Brush.Color := clred;
  scale := (ARect.Right - ARect.Left) / MovieInfo.current_file_duration; //pixel per second
  CutRect := ARect;
  for iCut := 0 to cutlist.Count-1 do begin
    CutRect.Left := ARect.Left + round(Cutlist[iCut].pos_from * scale);
    CutRect.Right := ARect.Left + round(Cutlist[iCut].pos_to * scale);
    if CutRect.right >= CutRect.Left then
      DSTrackBar1.ChannelCanvas.FillRect(CutRect);
  end;
end;

function TFMain.AskForUserRating(Cutlist: TCutlist): boolean;
//true = user rated or decided not to rate, or no rating necessary
//false = abort operation
var
  message_string: String;
begin
  result := false;
  if Cutlist.UserShouldSendRating then begin
    message_string := 'Please send a rating for the current cutlist. Would you like to do that now?';
    case (application.messagebox(PChar(message_string), nil, MB_YESNOCANCEL + MB_ICONQUESTION)) of
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

procedure TFMain.HandleParameter(const param: string);
var
  FileList: TStringLIst;
begin
  FileList := TStringList.Create;
  try
    FileList.Text := param;
    self.ProcessFileList(FileList, false);
  finally
    FileList.Free;
  end;
end;

function TFMain.GraphPlayPause: boolean;
begin
  result := false;
  if filtergraph.State = gsPlaying then begin
    result := GraphPause;
  end else begin
    result := GraphPlay;
  end;
end;

function TFMain.GraphPause: boolean;
const
  CaptionPlay = '>';
  HintPlay = 'Play';
{var
  event: integer;  }
begin
  result := filtergraph.Pause;
  {if assigned(FrameStep) then begin
    FrameStep.Step(1, nil);
    MediaEvent.WaitForCompletion(500, event);
  end;              }
  self.BPlayPause.Caption := CaptionPlay;
  self.BPlayPause.Hint := HintPlay;
  self.BFF.Enabled := false;
  DSTrackBar1.TriggerTimer;
end;

function TFMain.GraphPlay: boolean;
const
  CaptionPause= '||';
  HintPause = 'Pause';
begin
  result := filtergraph.Play;
  if result then begin
    self.BPlayPause.Caption := CaptionPause;
    self.BPlayPause.Hint := HintPause;
    self.BFF.Enabled := true;
  end;
end;

procedure TFMain.VideoWindowClick(Sender: TObject);
begin
  self.BPlayPauseClick(self);
end;



procedure TFMain.TBRateChange(Sender: TObject);
var
  NewRate: double;
begin
  NewRate := Power(2, (TBRate.Position / 8));
  filtergraph.Rate := newRate;

  LRate.Caption :=  floattostrF(filtergraph.Rate, ffFixed, 15, 3) + 'x' ;
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

procedure TFMain.LRateDblClick(Sender: TObject);
begin
  TBRate.Position := 0;
end;

procedure TFMain.ANextCutExecute(Sender: TObject);
var
  NewPos: double;
begin
  NewPos := cutlist.NextCutPos(currentPosition);
  if NewPos >= 0 then jumpTo(NewPos);
end;

procedure TFMain.APrevCutExecute(Sender: TObject);
var
  NewPos: double;
begin
  NewPos := cutlist.PreviousCutPos(currentPosition);
  if NewPos >= 0 then jumpTo(NewPos);
end;

procedure TFMain.BFFMouseDown(Sender: TObject; Button: TMouseButton;
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

procedure TFMain.BFFMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  self.FF_Stop;
end;
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

procedure TFMain.AFullScreenExecute(Sender: TObject);
begin
  self.AFullScreen.Checked := ToggleFullScreen;
end;

procedure TFMain.VideoWindowKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and self.VideoWindow.FullScreen then begin
    self.AFullScreenExecute(Sender);
  end;
end;


procedure TFMain.ACloseMovieExecute(Sender: TObject);
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
  MemoryStream: TMemoryStream;
  message_string, error_message: string;
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
    message_string := 'Trying to download this cutlist:' + #13#10 + TargetFileName + '[ID='+ cutlist_id + ']' +#13#10+
                      'Existing cutlist is not saved and will be overwritten.' +#13#10+
                      'Continue?';
    if not (application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONINFORMATION) = IDYES) then begin
      exit;
    end;
  end;

  MemoryStream := TMemoryStream.Create;
  //FileStream := TFileStream.Create(target_file, fmCreate);
  self.IdHTTP1.HandleRedirects := false;
  Error_message := 'Unknown error.';


  url := settings.url_cutlists_home + php_name + command + cleanurl(cutlist_id);

  try
    try
      self.IdHTTP1.Get(url, MemoryStream);
      if fileexists(target_file) then begin
        if not batchmode then begin
          message_string := 'Target File exists already:' + #13#10 + target_file +#13#10+
                            'Overwrite?';
          if not (application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONQUESTION) = IDYES) then begin
            exit;
          end;
        end;
        if not deletefile(target_file) then begin
          if not batchmode then showmessage('Could not delete existing file ' + target_file + '. Abort.');
          exit;
        end;
      end;
      if memoryStream.Size < 5 then begin
        Error_message := 'Server did not return any valid data (' + inttostr(memoryStream.Size) + ' bytes). Abort.';
        result := false;
      end else begin
        MemoryStream.SaveToFile(target_file);
        result := true;
      end;
    finally
      MemoryStream.Free;
    end;
  except
    on E: EIdProtocolReplyError do begin
      case E.ReplyErrorCode of
        404, 302: begin
                    Error_message := 'File not found on server: ' + settings.url_cutlists_home + php_name + ' .';
                  end;
        else raise;
      end;
    end;
    else begin
      raise;
    end;
  end;

  if result then begin
    cutlist.LoadFromFile(target_file);
  end else begin
    if not batchmode then begin
      message_string := Error_message + #13#10 +  'Open cutlist homepage in webbrowser?';
      if (application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONQUESTION) = IDYES) then begin
        ShellExecute(0, nil, PChar(settings.url_cutlists_home), '', '', SW_SHOWNORMAL);
      end;
    end;
  end;
end;

function TFMain.DownloadInfo(settings: TSettings): boolean;
var
  error_message, url, AText: string;
  Response: TMemoryStream;
  Messages, AMessage, Stable, Beta: IXMLNode;
  Datum: TDate;
begin
  result := false;
  if not settings.CheckInfos then exit;
  if not (daysBetween(settings.InfoLastChecked, SysUtils.Date) >= settings.InfoCheckInterval) then exit;

  self.IdHTTP1.HandleRedirects := false;
  Error_message := 'Unknown error.';

  response := TMemoryStream.Create;

  url := settings.url_info_file;
  try
    try
      Error_message := 'Error while checking for Information and new Versions on Server.' +#13#10;
      self.IdHTTP1.Get(url, Response);
      result := true;
    except
      on E: EIdProtocolReplyError do begin
        case E.ReplyErrorCode of
          404, 302: begin
                      Error_message := Error_message+ 'File not found on server: ' + url + ' .';
                    end;
          else
            Error_message := Error_message + E.Message;
        end;
      end;
      on E: EIDSocketError do begin
        Error_message := Error_message + E.Message;
      end;
      else begin
        raise;
      end;
    end;

    if result then begin
      if response.Size > 5 then begin
        XMLDocument1.LoadFromStream(Response);

        if XMLDocument1.DocumentElement.ChildNodes.Count > 0 then begin
          if settings.InfoShowMessages then begin
            Messages := XMLDocument1.DocumentElement.ChildNodes.FindNode('messages');
            if Messages.ChildNodes.Count > 0 then begin
              AMessage := Messages.ChildNodes.First;
              repeat
                //AMessage.ChildNodes['id'].Text;
                Datum := EncodeDate((StrToInt(AMessage.ChildNodes['date_year'].Text)),
                                    (StrToInt(AMessage.ChildNodes['date_month'].Text)),
                                    (StrToInt(AMessage.ChildNodes['date_day'].Text)));
                if settings.InfoLastChecked <= Datum then begin
                  AText := AMessage.ChildNodes['text'].Text;
                  Showmessage('Information:' + #13#10 + '[' + DateToStr(Datum) + '] ' +  AText);
                end;
                AMessage := AMessage.NextSibling;
              until AMessage = nil;
            end;
          end;
          if settings.InfoShowBeta then begin
            Beta := XMLDocument1.DocumentElement.ChildNodes.FindNode('beta');
            if Beta.ChildNodes.Count > 0 then begin
              Datum := EncodeDate((StrToInt(Beta.ChildNodes['date_year'].Text)),
                                  (StrToInt(Beta.ChildNodes['date_month'].Text)),
                                  (StrToInt(Beta.ChildNodes['date_day'].Text)));
              if settings.InfoLastChecked <= Datum then begin
                //Beta.ChildNodes['version'].Text;
                AText := Beta.ChildNodes['version_text'].Text;
                Showmessage('Information:' + #13#10 + '[' + DateToStr(Datum) + '] '+ AText);
              end;
            end;
          end;
          if settings.InfoShowStable then begin
            Stable := XMLDocument1.DocumentElement.ChildNodes.FindNode('stable');
            if Stable.ChildNodes.Count > 0 then begin
              Datum := EncodeDate((StrToInt(Stable.ChildNodes['date_year'].Text)),
                                  (StrToInt(Stable.ChildNodes['date_month'].Text)),
                                  (StrToInt(Stable.ChildNodes['date_day'].Text)));
              if settings.InfoLastChecked <= Datum then begin
                //Stable.ChildNodes['version'].Text;
                AText := Stable.ChildNodes['version_text'].Text;
                Showmessage('Information:' + #13#10 + '[' + DateToStr(Datum) + '] '+ AText);
              end;
            end;
          end;
          result := true;
        end;
      end;
      settings.InfoLastChecked := sysutils.Date;
    end else begin
      showmessage(Error_Message);
    end;
  finally
    response.Free;
  end;              
end;

procedure TFMain.ASnapshotCopyExecute(Sender: TObject);
var
  tempBitmap: TBitmap;
  tempCutFrame: TCutFrame;
begin
  if MenuVideo.PopupComponent = VideoWindow then begin
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
      //tempBitmap.Free;
      tempCutFrame.Free;
    end;
  end;
  if MenuVideo.PopupComponent is TImage then begin
    clipboard.Assign((MenuVideo.PopupComponent as TImage).Picture.Bitmap);
  end;
end;

procedure TFMain.ASnapshotSaveExecute(Sender: TObject);

  function AskForFileName(var FileName: string; var FileType: Integer): boolean;
  var
    saveDlg: TSaveDialog;
    DefaultExt: string;
  begin
    result := false;
    saveDlg := TSaveDialog.Create(Application.MainForm);
    try
      saveDlg.Filter := 'Bitmap|*.bmp|JPEG|*.jpg|All Files|*.*';
      saveDlg.FilterIndex := 2;
      saveDlg.Title := 'Save Snapshot as...';
      //saveDlg.InitialDir := '';
      saveDlg.filename := fileName;
      saveDlg.options := saveDlg.Options + [ofOverwritePrompt, ofPathMustExist];
      if saveDlg.Execute then begin
        result := true;
        FileName := saveDlg.FileName;
        FileType := saveDlg.FilterIndex;
        case FileType of
          1: begin
               DefaultExt := '.bmp';
             end;
          else begin
            FileType := 2;
            DefaultExt := '.jpg';
          end;
        end;
        if extractFileExt(FileName) <> DefaultExt then FileName := FileName + DefaultExt;
      end;
    finally
      saveDlg.Free;
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

  if MenuVideo.PopupComponent  = VideoWindow then begin
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
      //tempBitmap.Free;
      tempCutFrame.Free;
    end;
  end;

  if MenuVideo.PopupComponent is TImage then begin
    posString := MovieInfo.FormatPosition((MenuVideo.PopupComponent.Owner as TCutFrame).position);
    posString := ansireplacetext(posString, ':', '''');
    fileName := extractfilename(MovieInfo.current_filename);
    fileName := changeFileExt(fileName, '_' + cleanFileName(posString));
    if not AskForFileName(FileName, FileType) then exit;

    TempBitmap := (MenuVideo.PopupComponent as TImage).Picture.Bitmap;
    if FileType = 1 then begin
      TempBitmap.SaveToFile(FileName);
    end else begin
      SaveBitmapAsJPEG(TempBitmap, FileName);
    end;
  end;
end;

function TFMain.CreateMPlayerEDL(cutlist: TCutlist; Inputfile,
  Outputfile: String; var scriptfile: string): boolean;
var
  f: Textfile;
  i: integer;
  cutlist_tmp: TCutlist;
  temp_DecimalSeparator: char;
begin
  result := false;
  if scriptfile = '' then scriptfile := Inputfile + '.edl';
  assignfile(f, scriptfile);
  Temp_DecimalSeparator := DecimalSeparator;
  DecimalSeparator := '.';
  try
    rewrite(f);
    if cutlist.Mode = clmCutOut then begin
      cutlist.sort;
      for i := 0 to cutlist.Count -1 do begin
        writeln(f, floatTostr(cutlist.Cut[i].pos_from)  + ' ' + floatTostr(cutlist.Cut[i].pos_to) + ' 0');
      end;
    end else begin
      cutlist_tmp := cutlist.convert;
      for i := 0 to cutlist_tmp.Count -1 do begin
        writeln(f, floatTostr(cutlist_tmp.Cut[i].pos_from)  + ' ' + floatTostr(cutlist_tmp.Cut[i].pos_to) + ' 0');
      end;
      cutlist_tmp.Free;
    end;
  finally
    DecimalSeparator := Temp_DecimalSeparator;
    closefile(f);
  end;
  result := true;
end;

procedure TFMain.APlayInMPlayerAndSkipExecute(Sender: TObject);
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
    showmessage('Error while calling ' + extractFilename(AppPath) + ': ' + message_string);
  end;   
end;

procedure TFMain.ResetForm;
begin
  pos_from := 0;
  pos_to := 0;

  self.Caption := Application_Friendly_Name;
  application.Title := Application_Friendly_Name;

  self.OpenCutlist.Enabled := false;
  self.ASearchCutlistByFileSize.Enabled := false;
  self.EnableMovieControls(false);
  self.StepForward.Enabled := false;

  self.LDuration.Caption := '0:00:00.000';
end;

procedure TFMain.EnableMovieControls(value: boolean);
begin
    self.Next12.Enabled := value;
    self.Prev12.Enabled := value;
    self.DSTrackBar1.Enabled := value;
    self.TFinePos.Enabled := value;
    self.StepBackward.Enabled := value;
    self.BPlayPause.Enabled := value;
    self.BStop.Enabled:= value;
    if value and MovieInfo.CanStepForward then begin
      self.StepForward.Enabled := true;
    end else begin
      self.StepForward.Enabled := false;
    end;     
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
  InPin := SampleGrabber1.InPutPin;
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
var
  i : integer;
begin
  result := not settings.FilterIsInBlackList(ClassID);
end;

procedure TFMain.FramePopUpPrevious12FramesClick(Sender: TObject);
var
  _pos: double;
begin
  if MenuVideo.PopupComponent = VideoWindow then begin
    self.Prev12.Execute;
  end;
  if MenuVideo.PopupComponent is TImage then begin
    ((MenuVideo.PopupComponent as TImage).Owner as TCutFrame).ImageDoubleClick(MenuVideo.PopupComponent);
    self.Prev12.Execute;
  end;
end;

procedure TFMain.FramePopUpNext12FramesClick(Sender: TObject);
begin
  if MenuVideo.PopupComponent = VideoWindow then begin
    self.Next12.Execute;
  end;
  if MenuVideo.PopupComponent is TImage then begin
    ((MenuVideo.PopupComponent as TImage).Owner as TCutFrame).ImageDoubleClick(MenuVideo.PopupComponent);
    self.Next12.Execute;
  end;
end;

initialization
begin
  randomize;
  Settings := TSettings.Create;
  Settings.load;
  MovieInfo := TMovieInfo.Create;
  Cutlist := TCutList.Create(Settings, MovieInfo);
end;

finalization
begin
  cutlist.Free;
  MovieInfo.Free;
  settings.save;
  Settings.Free;
end;

end.