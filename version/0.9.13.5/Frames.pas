unit Frames;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Forms,
  Dialogs, ExtCtrls, StdCtrls, Controls, contnrs, main;

type

  TCutFrame = class(TComponent)
  private
    BStart, BStop: TButton;
    LTime: TLabel;
    LIndex: TLabel;
    FImage: TImage;
    FPosition : double;
    FIndex: Integer;
    FKeyFrame: boolean;
    FBorderVisible: boolean;
    FBorder: TShape;
    FUpdateLocked: integer;
    procedure setPosition(APosition: Double);
    procedure setKeyFrame(Value: boolean);
    procedure setBorderVisible(Value: boolean);
  public
    property IsKeyFrame: boolean read FKeyFrame write SetKeyFrame;
    property BorderVisible: boolean read FBorderVisible write SetBorderVisible;
    property index: integer read FIndex;
    property position: double read FPosition write setPosition;
    constructor Create(AParent: TWinControl); reintroduce;
    destructor Destroy; override;
    procedure DisableUpdate;
    procedure EnableUpdate;
    procedure UpdateFrame;
    procedure init(image_height, image_width: INteger);
    procedure Adjust_position(pos_top, pos_left: Integer);
    procedure BStartClick(Sender: TObject);
    procedure BStopClick(Sender: TObject);
    procedure ImageClick(Sender: TObject);
    procedure ImageDoubleClick(Sender: TObject);
    property Image:TImage read FImage;
  end;

  TFFrames = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FrameList: TObjectList;
    function getCutFrame(Index: integer): TCUtFrame;
    function getCount: integer;
    procedure adjust_frame_position;
  public
    { Public declarations }
    MainForm: TFMain;
    scan_1, scan_2: integer; //index of CutFrame
    CanClose: boolean;
    procedure Init(IFrames: Integer; FrameHeight, FrameWidth: Integer);
    procedure HideFrames;
    property Frame[Index: Integer]: TCutFrame read getCutFrame;
    property Count: Integer read getCount;
  end;

  const bdistance = 0.03; //distance between buttons as % of image_width
  const distance = 0.05; //distance between frames as % of framewidth


var
  FFrames: TFFrames;

implementation

  uses Utils, Math, DirectShow9;

{$R *.dfm}

{ TFFrames }
procedure TFFrames.HideFrames;
var
  iFrame: integer;
begin
  for iFrame := 0 to Framelist.Count-1 do
    with Frame[iFrame] do begin
      Image.Visible := false;
      Position := 0;
    end;
end;

function TFFrames.getCount: integer;
begin
  Result := FrameList.Count;
end;

procedure TFFrames.init(IFrames: Integer; FrameHeight, FrameWidth: Integer);
var
  iFrame, Line, F_per_line: integer;
  buttonheight, top_dist, hor_dist, LineHeight: integer;
  AFrame: TCutFrame;
begin
  scan_1 := -1;
  scan_2 := -1;
  buttonheight := round(Screen.PixelsPerInch / 4);
  top_dist := round(distance * FrameHeight);
  hor_dist := round(distance * FrameWidth);
  LineHeight := 2*top_dist + buttonHeight+FrameHeight;
  F_per_line := trunc(self.ClientWidth / ((1+distance) * FrameWidth));
  //self.ClientHeight := (trunc(IFrames-1 / F_per_Line) + 1) * LineHeight + top_dist;

  self.Constraints.MinWidth := Framewidth + 5* hor_dist + self.VertScrollBar.Size;

  for iFrame := 0 to IFrames-1 do begin
    Line := trunc(iFrame / F_per_line);
    AFrame := TCutFrame.Create(self);
    AFrame.Findex := Framelist.Add(AFrame);
    AFrame.Init(FrameHeight,FrameWidth);
    AFrame.Adjust_position(Line * LineHeight + top_dist,
                (iFrame mod F_per_Line) * (Framewidth + hor_dist) + hor_dist);
  end;

end;

procedure TFFrames.adjust_frame_position;
var
  iFrame, Line, F_per_line: integer;
  framewidth, frameheight, buttonheight, top_dist, hor_dist, LineHeight: integer;
  AFrame: TCutFrame;
begin
  if framelist.Count = 0 then
    Exit;
  buttonheight := round(Screen.PixelsPerInch / 4);
  framewidth := (framelist[0] as TCutFrame).Image.Width;
  frameheight := (framelist[0] as TCutFrame).Image.Height;
  top_dist := round(distance * FrameHeight);
  hor_dist := round(distance * FrameWidth);
  LineHeight := 2*top_dist + buttonHeight+FrameHeight;
  F_per_line := trunc(self.ClientWidth / ((1+distance) * FrameWidth));

  self.VertScrollBar.Position := 0;
  for iFrame := 0 to Framelist.Count-1 do begin
    Line := trunc(iFrame / F_per_line);
    AFrame := (framelist[iFrame] as TCutFrame);
    AFrame.Adjust_position(Line * LineHeight + top_dist,
                (iFrame mod F_per_Line) * (Framewidth + hor_dist) + hor_dist);
  end;
end;

function TFFrames.getCutFrame(Index: integer): TCUtFrame;
begin
  result := (self.FrameList[Index] as TCutFrame)
end;

{ TCutFrame }

constructor TCutFrame.Create(AParent: TWinControl);
begin
  inherited create(AParent);
  BStart := TButton.Create(self);
  BStop := TButton.Create(self);
  LTime := TLabel.Create(self);
  LIndex := TLabel.Create(self);
  FBorder := TShape.Create(self);
  FImage := TIMage.Create(self);
  BStart.Parent := AParent;
  BStop.Parent := AParent;
  LTime.Parent := AParent;
  LIndex.Parent := AParent;
  FBorder.Parent := AParent;
  Image.Parent := Aparent;
  Image.PopupMenu := FMain.mnuVideo;
  IsKeyFrame := false;
end;

destructor TCutFrame.Destroy;
begin
  //FreeAndNIL(Bstart);
  //FreeAndNIL(Bstop);
  //FreeAndNIL(LTime);
  //FreeAndNIL(LIndex);
  //FreeAndNIL(FImage);
  //FreeAndNIL(FBorder);
  inherited;
end;

procedure TCutFrame.Adjust_position(pos_top, pos_left: integer);
const
  Index_width = 2.0/3.0;  //in width_units
  Time_width = 3;
  Button_width = 2;
  border_distance = 2;
  Border_Width = 2;
var
  top2: integer;
  width_unit, button_distance, image_height, image_width: integer;
begin

  image_height := image.Height;
  image_width := image.Width;
  button_distance := round(image_Width * bdistance);

  Image.Top := pos_top;
  image.Left := pos_left;

  FBorder.Top := pos_top - border_distance - border_width;
  FBorder.left := pos_left - border_distance - border_width;

  top2 := pos_top + image_height + button_distance;
  width_unit := round((image_width - 3*button_distance) / (Index_width + Time_width + Button_width + Button_width));
  LIndex.Top := top2;
  LIndex.Left := pos_Left;

  BStart.Top := top2;
  BStart.Left := pos_left + round((Index_width+TIme_width)*width_unit) + 2*button_distance;

  BStop.Top := top2;
  BStop.Left := pos_left + round((Index_width+TIme_width+Button_width)*width_unit) + 3*button_distance;

  LTime.Top := top2;
  LTime.Left := BStart.Left - LTime.Width - button_distance;
end;

procedure TFFrames.FormCreate(Sender: TObject);
var
  MainBounds: TRect;
begin
  FrameList := TObjectlist.Create;
  Init(Settings.FramesCount, Settings.FramesHeight, Settings.FramesWidth);

  if ValidRect(Settings.FramesFormBounds) then
    self.BoundsRect := Settings.FramesFormBounds
  else
  begin
    MainBounds := Settings.MainFormBounds;
    if ValidRect(MainBounds) then begin
      // Use top of main form if possible
      if MainBounds.Top + self.Height <= Screen.DesktopHeight then
        self.Top := MainBounds.Top
      else // Center around main form if possible
        self.Top := Math.Max(0, MainBounds.Top + (MainBounds.Bottom - MainBounds.Top - self.Height) div 2);
      // force at least visible width of 100 pixels
      self.Left := Math.Min(MainBounds.Left + MainBounds.Right - MainBounds.Left, Screen.DesktopWidth - 100);
    end
    else
    begin
      self.Top := Screen.WorkAreaTop + Max(0, (Screen.WorkAreaHeight - self.Height) div 2);
      self.Left := Screen.WorkAreaLeft + Max(0, Screen.WorkAreaWidth - self.Width);
    end;
  end;
  self.WindowState := Settings.FramesFormWindowState;
  adjust_frame_position;
end;

procedure TFFrames.FormDestroy(Sender: TObject);
begin
  Settings.FramesFormBounds := self.BoundsRect;
  Settings.FramesFormWindowState := self.WindowState;
end;

procedure TCutFrame.init(image_height, image_width: INteger);
const
  Index_width = 1;  //in width_units
  Time_width = 3;
  Button_width = 2;
  Border_Distance = 2;
  Border_Style = psSolid;
  Border_Width = 2;
  Border_Color = clYellow;
var
  width_unit, button_height, button_distance: integer;
begin
  button_height := round(Screen.PixelsPerInch / 4);
  button_distance := round(image_Width * bdistance);
  position := 0;
  Image.Height := image_height;
  Image.Width := Image_width;
  Image.Proportional := true;
  Image.Stretch := true;
  image.Picture.Bitmap.Canvas.Brush.Color := clBlack;
  image.Picture.Bitmap.Canvas.Brush.Style := bsSolid;
  image.Picture.Bitmap.Canvas.FillRect(image.ClientRect);
  image.OnClick := ImageClick;
  image.OnDblClick := ImageDoubleClick;
{  FFrames.Canvas.Brush.Color := clBlack;
  FFrames.Canvas.Brush.Style := bsSolid;
  FFrames.Canvas.FillRect(Rect(0,0,100,100)); }

  width_unit := round((image_width - 3*button_distance) / (Index_width + Time_width + Button_width + Button_width));
  Lindex.Caption := inttostr(self.index);
  LIndex.Height := Button_height;

  //LTime.ParentFont := false;
  //LTime.Font.Assign(FFrames.Font);
  //LTime.Font.Size := Round(image_width / 40);
  LTIme.Caption := secondsToTimeString(0);
  LTime.Height := Button_height;
  LTime.Alignment := taRightJustify; 

  BStart.Caption := '[<-';
  BStart.Height := button_height;
  BStart.Width := button_width * width_Unit;
  BStart.OnClick := BStartClick;

  BStop.Caption := '->]';
  BStop.Height := button_height;
  BStop.Width := button_width * width_Unit;
  BStop.OnClick := BStopClick;

  FBorder.Visible := false;
  FBorder.Height := Image.Height + 2*Border_Distance+2*Border_width;
  FBorder.Width := Image.Width + 2*Border_Distance+2*Border_width;
  FBorder.Brush.Style := bsClear;
  FBorder.Pen.Style := Border_Style;
  FBorder.Pen.Width := Border_width;
  FBorder.Pen.Color := Border_Color;
  self.BorderVisible := false;
end;

procedure TFFrames.FormResize(Sender: TObject);
begin

  self.adjust_frame_position;
end;

procedure TCutFrame.BStartClick(Sender: TObject);
var
  _pos : double;
begin
  _pos := ((sender as TButton).Owner as TCutFrame).position;
  (self.Owner as TFFrames).MainForm.SetStartPosition(_pos);
end;

procedure TCutFrame.BStopClick(Sender: TObject);
var
  _pos : double;
begin
  _pos := ((sender as TButton).Owner as TCutFrame).position;
  (self.Owner as TFFrames).MainForm.SetStopPosition(_pos);
end;

procedure TCutFrame.DisableUpdate;
begin
  Inc(FUpdateLocked);
end;

procedure TCutFrame.EnableUpdate;
begin
  Dec(FUpdateLocked);
  if FUpdateLocked > 0 then
    exit;
  FUpdateLocked := 0;
  UpdateFrame;
end;

procedure TCutFrame.UpdateFrame;
var
  _pos: double;
begin
  if MovieInfo.frame_duration = 0 then
    _pos := index
  else
    _pos := FPosition / MovieInfo.frame_duration;
  LIndex.Caption := MovieInfo.FormatPosition(_pos, TIME_FORMAT_FRAME);
  LTime.Caption := MovieInfo.FormatPosition(FPosition);
end;

procedure TCutFrame.setPosition(APosition: Double);
begin
  FPosition := APosition;
  if FUpdateLocked > 0 then
    exit;
  UpdateFrame;
end;

procedure TCutFrame.setKeyFrame(Value: boolean);
begin
  FKeyFrame := Value;
  if Value then begin
    self.LTime.Color := clYellow;
//    self.LTime.Transparent := false;
  end else
    self.LTime.ParentColor := true;
//    self.LTime.Transparent := true;
end;

procedure TCutFrame.ImageDoubleClick(Sender: TObject);
var
  _pos : double;
begin
  _pos := ((sender as TImage).Owner as TCutFrame).position;
  (self.Owner as TFFrames).MainForm.JumpTo(_pos);
end;

procedure TCutFrame.setBorderVisible(Value: boolean);
begin
  self.FBorderVisible := Value;
  self.FBorder.Visible := value;
end;

procedure TCutFrame.ImageClick(Sender: TObject);
begin
  if self.BorderVisible then begin
    with (self.Owner as TFFrames) do begin
      if scan_1 = self.index  then begin
        scan_1 := scan_2;
        scan_2 := -1;
      end;
      if scan_2 = self.index then scan_2 := -1;
    end;
    self.BorderVisible := false;
  end else begin
    with (self.Owner as TFFrames) do begin
      if scan_1 = -1  then begin
        scan_1 := self.index;
      end else begin
        if scan_2 = -1 then begin
          scan_2 := self.index;
        end else begin
          Frame[scan_1].BorderVisible := false;
          scan_1 := scan_2;
          scan_2 := self.index;
        end;
        if frame[scan_1].position < frame[scan_2].position then begin
          (self.Owner as TFFrames).MainForm.TBFilePos.SelStart := round(frame[scan_1].position);
          (self.Owner as TFFrames).MainForm.TBFilePos.SelEnd := round(frame[scan_2].position);
        end else begin
          (self.Owner as TFFrames).MainForm.TBFilePos.SelStart := round(frame[scan_2].position);
          (self.Owner as TFFrames).MainForm.TBFilePos.SelEnd := round(frame[scan_1].position);
        end;
        (self.Owner as TFFrames).MainForm.actScanInterval.Enabled := true;
      end;
    end;
    self.BorderVisible := true;
  end;
end;

procedure TFFrames.FormShow(Sender: TObject);
begin
  // Show taskbar button for this form ...
  SetWindowLong(Handle, GWL_ExStyle, WS_Ex_AppWindow);
  CanClose := true;
end;

procedure TFFrames.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := self.CanClose;
end;

procedure TFFrames.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_PRIOR:
      begin
        self.MainForm.JumpTo(self.Frame[0].position);
        self.MainForm.actPrevFrames.Execute;
      end;
    VK_NEXT:
      begin
        self.MainForm.JumpTo(self.Frame[self.Count - 1].position);
        self.MainForm.actNextFrames.Execute;
      end;
    VK_ESCAPE:
      begin
        Hide;
      end;
    VK_RETURN:
      begin
        self.MainForm.BringToFront;
      end;
  end;
end;

end.