unit ResultingTimes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, ActiveX,
  main, CutlistINfo_dialog, UCutlist,
  DSPack, DirectShow9, DSUtil, Movie;

type
  TFResultingTimes = class(TForm)
    LTimeList: TListView;
    BClose: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    PanelVideoWindow2: TPanel;
    VideoWindow2: TVideoWindow;
    FilterGraph2: TFilterGraph;
    TVolume: TTrackBar;
    Label8: TLabel;
    BPause: TButton;
    BPlay: TButton;
    DSTrackBar1: TDSTrackBar;
    Label2: TLabel;
    ESeconds: TEdit;
    Label3: TLabel;
    UDSeconds: TUpDown;
    procedure BCloseClick(Sender: TObject);
    procedure LTimeListDblClick(Sender: TObject);
    procedure PanelVideoWindow2Resize(Sender: TObject);
    procedure TVolumeChange(Sender: TObject);
    procedure BPlayClick(Sender: TObject);
    procedure BPauseClick(Sender: TObject);
    procedure JumpTo(NewPosition: double);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure UDSecondsChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormDestroy(Sender: TObject);
    function FilterGraph2SelectedFilter(Moniker: IMoniker;
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
    self.LTimeList.Clear;
    exit;
  end;
  if cutlist.Mode = clmCrop then begin
    self.LTimeList.Clear;
    time := 0;
    setlength(To_Array, cutlist.Count);
    for icut := 0 to cutlist.Count-1 do begin
      cut := cutlist[icut];
      cut_view := self.LTimeList.Items.Add;
      cut_view.Caption := inttostr(cut.index);
      cut_view.SubItems.Add(MovieInfo.FormatPosition(time));
      time := time + cut.pos_to-cut.pos_from;
      cut_view.SubItems.Add(MovieInfo.FormatPosition(time));
      To_Array[iCut] := time;
      cut_view.SubItems.Add(MovieInfo.FormatPosition(cut.pos_to-cut.pos_from));
      time := time + MovieInfo.frame_Duration;
    end;

    //Auto-Resize columns
    for i_column := 0 to self.LTimeList.Columns.Count -1 do begin
      LTimeList.Columns[i_column].Width := -2;
    end;
  end else begin
    Converted_Cutlist := cutlist.convert;
    self.calculate(COnverted_cutlist);
    Converted_Cutlist.Free;
  end;
end;

procedure TFResultingTimes.BCloseClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFResultingTimes.LTimeListDblClick(Sender: TObject);
var
  target_Time: double;
begin
  if filtergraph2.Active then begin
    if self.LTimeList.ItemIndex < 0 then exit;
    target_Time := self.To_array[self.LTimeList.ItemIndex] - FOffset;
    if target_time > MovieInfo.current_file_duration then exit;
    if target_time < 0 then target_time := 0;
    JumpTo(Target_time);
    FilterGraph2.Play;
  end;
end;

procedure TFResultingTimes.JumpTo(NewPosition: double);
var
  _pos: int64;
begin
  if assigned(seeking) then  begin
    _pos := round(NewPosition * 10000000);
    seeking.SetPositions(_pos, AM_SEEKING_AbsolutePositioning,
                         _pos, AM_SEEKING_NoPositioning);
  end;
end;


procedure TFResultingTimes.PanelVideoWindow2Resize(Sender: TObject);
const
  AR = 4/3;
var
  my_ar: double;
begin
  my_ar := self.PanelVideoWindow2.Width / self.PanelVideoWindow2.Height;
  if my_ar > AR then begin
    self.VideoWindow2.Height := self.PanelVideoWindow2.Height;
    self.VideoWindow2.Width := round (self.videowindow2.Height * AR);
  end else begin
    self.VideoWindow2.Width := self.PanelVideoWindow2.Width;
    self.VideoWindow2.Height := round(self.VideoWindow2.Width / AR);
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

  if not FMovieInfo.InitMovie(filename) then
    Exit;

  filtergraph2.Active := true;

  AvailableFilters := TSysDevEnum.Create(CLSID_LegacyAmFilterCategory); //DirectShow Filters
  try
      //If MP4 then Try to Add AviDecompressor
    if (MovieInfo.MovieType in [mtMP4]) then begin
      AviDecompressorFilter := AvailableFilters.GetBaseFilter(CLSID_AVIDec); //Avi Decompressor
      if assigned(AviDecompressorFilter) then begin
        CheckDSError((FilterGraph2 as IGraphBuilder).AddFilter(AviDecompressorFilter, 'Avi Decompressor'));
      end;
    end;

    SourceAdded:= false;
    If Not (IsEqualGUID(Settings.GetPreferredSourceFilterByMovieType(MovieInfo.MovieType), GUID_NULL)) then begin
      SourceFilter := AvailableFilters.GetBaseFilter(Settings.GetPreferredSourceFilterByMovieType(MovieInfo.MovieType));
      if assigned(SourceFilter) then begin
        CheckDSError((SourceFilter as IFileSourceFilter).Load(StringToOleStr(FileName), nil));
        CheckDSError((FilterGraph2 as IGraphBuilder).AddFilter(SourceFilter, StringToOleStr('Source Filter [' + extractFileName(FileName) + ']')));
        SourceAdded := true;
      end;
    end;
  finally
    AvailableFilters.Free;
  end;

  if not sourceAdded then begin
    FilterGraph2.RenderFile(FileName);
  end else begin
    PinLIst := TPinLIst.Create(SourceFilter);
    try
      for iPin := 0 to PinList.Count-1 do begin
        CheckDSError((FilterGraph2 as IGraphBuilder).Render(PinList.Items[iPin]));
      end;
    finally
      PinList.free;
    end;
  end;

  if FilterGraph2.Active then begin
    if not succeeded(filtergraph2.QueryInterface(IMediaSeeking, Seeking)) then begin
      seeking := nil;
      filtergraph2.Active := false;
      result := false;
      exit;
    end;
    filtergraph2.Pause;
    filtergraph2.Volume := self.TVolume.Position;
    current_filename := filename;
    self.DSTrackBar1.Position := 0;
    result := true;
  end;
end;

procedure TFResultingTimes.TVolumeChange(Sender: TObject);
begin
  filtergraph2.Volume := self.TVolume.Position;
end;

procedure TFResultingTimes.BPlayClick(Sender: TObject);
begin
  if filtergraph2.Active then
    filtergraph2.Play;
end;

procedure TFResultingTimes.BPauseClick(Sender: TObject);
begin
  if filtergraph2.Active then
    filtergraph2.Pause
end;

procedure TFResultingTimes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  filtergraph2.Stop;
  filtergraph2.ClearGraph;
  filtergraph2.Active := false;
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

  self.UDSeconds.Position := settings.OffsetSecondsCutChecking;
  FOffset := settings.OffsetSecondsCutChecking;
  FMovieInfo := TMovieInfo.Create;
end;


procedure TFResultingTimes.UDSecondsChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  FOffset := self.UDSeconds.Position;
end;

procedure TFResultingTimes.FormDestroy(Sender: TObject);
begin
  Settings.PreviewFormBounds := self.BoundsRect;
  Settings.PreviewFormWindowState := self.WindowState;
  FMovieInfo.Free;
end;

function TFResultingTimes.FilterGraph2SelectedFilter(Moniker: IMoniker;
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
