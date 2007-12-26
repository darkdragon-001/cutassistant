unit ResultingTimes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, ActiveX,
  main, CutlistINfo_dialog, UCutlist,
  DSPack, DirectShow9, DSUtil, Movie;

type
  TFResultingTimes = class(TForm)
    lvTimeList: TListView;
    cmdClose: TButton;
    Panel1: TPanel;
    lblDuration: TLabel;
    pnlVideoWindow: TPanel;
    VideoWindow: TVideoWindow;
    FilterGraph: TFilterGraph;
    tbVolume: TTrackBar;
    Label8: TLabel;
    cmdPause: TButton;
    cmdPlay: TButton;
    tbPosition: TDSTrackBar;
    lblPosition: TLabel;
    edtDuration: TEdit;
    lblSeconds: TLabel;
    udDuration: TUpDown;
    procedure cmdCloseClick(Sender: TObject);
    procedure lvTimeListDblClick(Sender: TObject);
    procedure pnlVideoWindowResize(Sender: TObject);
    procedure tbVolumeChange(Sender: TObject);
    procedure cmdPlayClick(Sender: TObject);
    procedure cmdPauseClick(Sender: TObject);
    procedure JumpTo(NewPosition: double);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure udDurationChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormDestroy(Sender: TObject);
    function FilterGraphSelectedFilter(Moniker: IMoniker;
      FilterName: WideString; ClassID: TGUID): Boolean;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    To_Array: Array of double;
    seeking: IMediaSeeking;
    FOffset: INteger;
    current_filename: string;
    FMovieInfo: TMovieInfo;
  public
    { Public declarations }
    procedure calculate(Cutlist: TCutlist);
    function loadMovie(filename: string): boolean;
  end;

var
  FResultingTimes: TFResultingTimes;

implementation

  uses Utils, Math, Settings_dialog;
  
{$R *.dfm}

{ TFResultingTimes }
procedure TFResultingTimes.calculate(Cutlist: TCutlist);
var
  icut: integer;
  cut: tcut;
  cut_view : tlistitem;
  i_column: integer;
  converted_cutlist: TCutlist;
  time: double;
begin
  if cutlist.Count = 0 then begin
    self.lvTimeList.Clear;
    exit;
  end;
  if cutlist.Mode = clmTrim then begin
    self.lvTimeList.Clear;
    time := 0;
    setlength(To_Array, cutlist.Count);
    for icut := 0 to cutlist.Count-1 do begin
      cut := cutlist[icut];
      cut_view := self.lvTimeList.Items.Add;
      cut_view.Caption := inttostr(icut); //inttostr(cut.index);
      cut_view.SubItems.Add(MovieInfo.FormatPosition(time));
      time := time + cut.pos_to-cut.pos_from;
      cut_view.SubItems.Add(MovieInfo.FormatPosition(time));
      To_Array[iCut] := time;
      cut_view.SubItems.Add(MovieInfo.FormatPosition(cut.pos_to-cut.pos_from));
      time := time + MovieInfo.frame_Duration;
    end;

    //Auto-Resize columns
    for i_column := 0 to self.lvTimeList.Columns.Count -1 do begin
      lvTimeList.Columns[i_column].Width := -2;
    end;
  end else begin
    Converted_Cutlist := cutlist.convert;
    self.calculate(COnverted_cutlist);
    FreeAndNIL(Converted_Cutlist);
  end;
end;

procedure TFResultingTimes.cmdCloseClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFResultingTimes.lvTimeListDblClick(Sender: TObject);
var
  target_Time: double;
begin
  if filtergraph.Active then begin
    if self.lvTimeList.ItemIndex < 0 then exit;
    target_Time := self.To_array[self.lvTimeList.ItemIndex] - FOffset;
    if target_time > MovieInfo.current_file_duration then exit;
    if target_time < 0 then target_time := 0;
    JumpTo(Target_time);
    FilterGraph.Play;
  end;
end;

procedure TFResultingTimes.JumpTo(NewPosition: double);
var
  _pos: int64;
  event: Integer;
begin
  if assigned(seeking) then  begin
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
  end;
end;


procedure TFResultingTimes.pnlVideoWindowResize(Sender: TObject);
var
  movie_ar: double;
  my_ar: double;
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

function TFResultingTimes.loadMovie(filename: string): boolean;
var
  AvailableFilters : TSysDevEnum;
  SourceFilter, AviDecompressorFilter: IBAseFilter;
  SourceAdded: boolean;
  PinList: TPinList;
  IPin: Integer;
begin
  result := false;

  FMovieInfo.target_filename := '';
  if not FMovieInfo.InitMovie(filename) then
    Exit;

  filtergraph.Active := true;

  AvailableFilters := TSysDevEnum.Create(CLSID_LegacyAmFilterCategory); //DirectShow Filters
  try
      //If MP4 then Try to Add AviDecompressor
    if (MovieInfo.MovieType in [mtMP4]) then begin
      AviDecompressorFilter := AvailableFilters.GetBaseFilter(CLSID_AVIDec); //Avi Decompressor
      if assigned(AviDecompressorFilter) then begin
        CheckDSError((FilterGraph as IGraphBuilder).AddFilter(AviDecompressorFilter, 'Avi Decompressor'));
      end;
    end;

    SourceAdded:= false;
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

  if FilterGraph.Active then begin
    if not succeeded(FilterGraph.QueryInterface(IMediaSeeking, Seeking)) then begin
      seeking := nil;
      filtergraph.Active := false;
      result := false;
      exit;
    end;
    filtergraph.Pause;
    filtergraph.Volume := self.tbVolume.Position;
    current_filename := filename;
    self.tbPosition.Position := 0;
    result := true;
  end;
end;

procedure TFResultingTimes.tbVolumeChange(Sender: TObject);
begin
  FilterGraph.Volume := self.tbVolume.Position;
end;

procedure TFResultingTimes.cmdPlayClick(Sender: TObject);
begin
  if FilterGraph.Active then
    FilterGraph.Play;
end;

procedure TFResultingTimes.cmdPauseClick(Sender: TObject);
begin
  if FilterGraph.Active then
    FilterGraph.Pause
end;

procedure TFResultingTimes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FilterGraph.Stop;
  FilterGraph.ClearGraph;
  FilterGraph.Active := false;
  settings.OffsetSecondsCutChecking := FOffset;
end;

procedure TFResultingTimes.FormCreate(Sender: TObject);
begin
  AdjustFormConstraints(Self);
  if ValidRect(Settings.PreviewFormBounds) then
    self.BoundsRect := Settings.PreviewFormBounds
  else
  begin
    self.Left := Max(0, FMain.Left + (FMain.Width - self.Width) div 2);
    self.Top := Max(0, FMain.Top + (FMain.Height - self.Height) div 2);
  end;
  self.WindowState := Settings.PreviewFormWindowState;

  self.udDuration.Position := settings.OffsetSecondsCutChecking;
  FOffset := settings.OffsetSecondsCutChecking;
  FMovieInfo := TMovieInfo.Create;
end;


procedure TFResultingTimes.udDurationChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  FOffset := self.udDuration.Position;
end;

procedure TFResultingTimes.FormDestroy(Sender: TObject);
begin
  Settings.PreviewFormBounds := self.BoundsRect;
  Settings.PreviewFormWindowState := self.WindowState;
  FreeAndNIL(FMovieInfo);
end;

function TFResultingTimes.FilterGraphSelectedFilter(Moniker: IMoniker;
  FilterName: WideString; ClassID: TGUID): Boolean;
begin
  result := not settings.FilterIsInBlackList(ClassID);
end;

procedure TFResultingTimes.FormShow(Sender: TObject);
begin
  // Show taskbar button for this form ...
  SetWindowLong(Handle, GWL_ExStyle, WS_Ex_AppWindow);
end;

end.
