unit Movie;

interface

Uses
  MMsystem;

const
  WMV_EXTENSIONS: array [0..1] of string  = ('.wmv', '.asf');
  AVI_EXTENSIONS: array [0..1] of string  = ('.avi', '.divx');
  MP4_EXTENSIONS: array [0..2] of string  = ('.mp4', '.m4v', '.mp4v');

//Class IDs
   CLSID_HAALI: TGUID = '{55DA30FC-F16B-49FC-BAA5-AE59FC65F82D}';  //Haali File Source and Media Splitter
//   CLSID_AVI_DECOMPRESSOR ='{CF49D4E0-1115-11CE-B03A-0020AF0BA770}';  //Use CLSID_AVIDec from DirectShow9

type

  TMovieType = (mtUnknown, mtWMV, mtAVI, mtMP4);

  TMovieInfo = class
  private
    FMovieType: TMovieType;
    procedure SetMovieType(const Value: TMovieType);
    function GetFrameCount: Int64;
    //movie params
  public
    MovieLoaded: boolean;
    CanStepForward: boolean;
    FFourCC: FOURCC;
    TimeFormat: TGUID;
    ratio: double;
    nat_w, nat_h: integer;
    current_file_duration, frame_duration: double;
    current_filename, target_filename: string;
    current_filesize: Longint;
    {current_position_seconds: double;
    function current_position_string: string;}
    property FrameCount: Int64 read GetFrameCount;
    property MovieType: TMovieType read FMovieType write SetMovieType;
    function FormatPosition(Position: double): String; overload;
    function FormatPosition(Position: double; TimeFormat: TGUID): String; overload;
    function MovieTypeString: string;
    function GetStringFromMovieType(aMovieType: TMovieType): string;
    function InitMovie(FileName: String): boolean;
    function GetAviFourCC(FileName: string): FOURCC;
  end;

implementation

uses
  Windows, SysUtils, StrUtils, VfW,
  DirectShow9, Utils;

{ TMovieInfo }

{function TMovieInfo.current_position_string: string;
begin
  result := secondsToTimeString(self.current_position_seconds);
end;     }

function TMovieInfo.GetFrameCount: Int64;
begin
  Result := Trunc(current_file_duration / frame_duration);
end;

function TMovieInfo.InitMovie(FileName: String): boolean;
var
  FileData: array [0..63] of byte;
  s: string;
  f: file of byte;
begin
  result := false;
  if not fileexists(filename) then
    exit;

  //determine filesize
  AssignFile(f, filename);
  FileMode := fmOpenRead;
  reset(f);
  try
    current_filename := filename;
    current_filesize := filesize(f);
    BlockRead(f, FileData, Length(FileData));
  finally
    closefile(f)
  end;

  MovieType := mtUnknown;
  FFourCC := 0;
  Result := true;

 //detect Avi File
  setstring(s, Pchar(@FileData[0]), 4);
  if s = 'RIFF' then begin
    setstring(s, Pchar(@FileData[8]), 4);
    if s = 'AVI ' then MovieType  := mtavi;
  end;

  //detect ISO FIle
  setstring(s, Pchar(@FileData[4]), 4);
  if s = 'ftyp' then MovieType  := mtMP4;

  //for OTR
  if MovieType = mtUnknown then begin
    if AnsiEndsText('.hq.avi', FileName) then MovieType := mtMP4;
  end;

   //Try to detect MovieType from file extension
  if MovieType = mtUnknown then begin
    if ansiMatchText(extractFileExt(FileName), WMV_EXTENSIONS) then MovieType  := mtwmv;
    if ansiMatchText(extractFileExt(FileName), AVI_EXTENSIONS) then MovieType  := mtavi;
    if ansiMatchText(extractFileExt(FileName), MP4_EXTENSIONS) then MovieType  := mtMP4;
  end;

  //Try to get Video FourCC from AVI
  if MovieType in [mtAVI] then begin
    FFourCC := GetAviFourCC(FileName);
    //showmessage('FourCC: ' + fcc2String(MovieInfo.FFourCC));
    if FFourCC = 0 then MovieType := mtUnknown;
  end;
end;

function TMovieInfo.FormatPosition(Position: double): String;
begin
  if isEqualGUID(self.TimeFormat, TIME_FORMAT_MEDIA_TIME) then
    result := secondsToTimeString(Position)
  else
    result := format('%.0n', [Position]);
end;

function TMovieInfo.FormatPosition(Position: double; TimeFormat: TGUID): String;
begin
  if isEqualGUID(TimeFormat, TIME_FORMAT_MEDIA_TIME) then
    result := secondsToTimeString(Position)
  else if IsEqualGUID(TimeFormat, TIME_FORMAT_FRAME) then
    result := format('%.0n', [Position])
  else
    result := format('%n', [Position]);
end;

function TMovieInfo.GetStringFromMovieType(aMovieType: TMovieType): string;
begin
  case aMovieType of
    mtUnknown: result := '[Unknown]';
    mtWMV: result := 'Windows Media File';
    mtAVI: result := 'AVI File';
    mtMP4: result := 'MP4 Iso File';
    else result := '[Unknown]';
  end;
end;

function TMovieInfo.MovieTypeString: string;
begin
  result := GetStringFromMovieType(FMovieType);
end;

procedure TMovieInfo.SetMovieType(const Value: TMovieType);
begin
  FMovieType := Value;
end;

function TMovieInfo.GetAviFourCC(FileName: string): FOURCC;
var
  AVIStream: IAVIStream;
  StreamInfo: TAVIStreamInfoW;
{  AInfo : TAVIFileInfo;
  AVIFile : IAVIFile;
  ErrorMsg : String;
  MsgBox : String;
  Height, Width: DWord;}
  hr : HRESULT;
begin
//  MsgBox := 'AVI Error:';
//  ErrorMsg := '';
  result := 0;
  // Init VfW API
  AVIFileInit;
  try
    hr := AVIStreamOpenFromFile(AVIStream, PAnsiChar(FileName), streamtypeVIDEO, 0, OF_READ, nil);
    if not succeeded(hr) then exit;
    AVIStream.Info(StreamInfo, sizeof(streamInfo));
    result := StreamInfo.fccHandler;

    {//AVIFileOpen
    Result := AVIFileOpen(AVIFile,PChar(Filename), OF_READ, nil);
    ErrorMsg := 'Bad AVI Format !';
    If (Result = AVIERR_BADFORMAT) Then ErrorMsg := 'Bad AVI Format !';
    If (Result = AVIERR_MEMORY) Then ErrorMsg := 'Insufficent Memory !';
    If (Result = AVIERR_FILEREAD) Then ErrorMsg := 'Error while reading from AVI file !';
    If (Result = AVIERR_FILEOPEN) Then ErrorMsg := 'Error while opening AVI file !';
    If (Result = REGDB_E_CLASSNOTREG) Then ErrorMsg := 'No process handle !';

    If (ErrorMsg <> '') Then Begin
      MessageBox(Application.Handle,PChar(ErrorMsg),PChar(MsgBox),MB_OK);
    End;

    // If AVIFile handle available then read AVI File Infos
    If (AVIFile <> NIL) Then begin;


      //AVIFileInfo
      Result := AVIFileInfo(AVIFile,AInfo,SizeOf(TAVIFILEINFO));
      Height := AInfo.dwHeight;
      Width := AInfo.dwWidth;
      //AVIFileRelease
      AVIFileRelease(AVIFile);
    end;  }
  finally
    AVIFileExit;
  end;
end;

end.
