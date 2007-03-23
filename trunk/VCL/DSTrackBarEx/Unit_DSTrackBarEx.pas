unit Unit_DSTrackBarEx;

interface

uses
  SysUtils, Classes, Controls, ComCtrls, DSPack, Forms, Graphics, Messages, Windows;

type
  TDSTrackBarEx = class;

  TTBCustomDrawEvent = procedure(Sender: TDSTrackBarEx; const ARect: TRect) of object;

  TDSTrackBarEx = class(TDSTrackBar)
  private
    { Private declarations }
    FOnPositionChangedByMouse: TNotifyEvent;
    FOnSelChanged: TNotifyEvent;
    FMouseDown: boolean;
    FUserIsMarking: boolean;
    FMarkingStart, FMarkingEnd: Integer;
    FChannelCanvas: TCanvas;
    FOnChannelPostPaint: TTBCustomDrawEvent;
    procedure SetOnChannelPostPaint(const Value: TTBCUstomDrawEvent);
  protected
    { Protected declarations }
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    property OnMouseUp;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure TriggerTimer;
    property IsMouseDown: boolean read FMouseDown;
    property UserIsMarking: boolean read FUserIsMarking;
  published
    { Published declarations }
    property OnPositionChangedByMouse: TNotifyEvent read FOnPositionChangedByMouse write FOnPositionChangedByMouse;
    property OnSelChanged: TNotifyEvent read FOnSelChanged write FOnSelChanged;
    property ChannelCanvas: TCanvas read FChannelCanvas;
    property OnChannelPostPaint: TTBCUstomDrawEvent  read FOnChannelPostPaint write SetOnChannelPostPaint;
  end;

procedure Register;

implementation

uses CommCtrl;

procedure Register;
begin
  RegisterComponents('DSPack', [TDSTrackBarEx]);
end;

{ TDSTrackBarEx }

constructor TDSTrackBarEx.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMouseDown    := false;
  FUserIsMarking := false;
  FChannelCanvas:= TCanvas.create;
end;

procedure TDSTrackBarEx.CNNotify(var Message: TWMNotify);
var
  Info: PNMCustomDraw;
  R: TRect;
//  Rgn: HRGN;
//  Details: TThemedElementDetails;
  Offset: Integer;
begin
  with Message do begin
    if NMHdr.code = NM_CUSTOMDRAW then begin
      Info := Pointer(NMHdr);
      case Info.dwDrawStage of
        CDDS_PREPAINT:
          // return CDRF_NOTIFYITEMDRAW so that we will get subsequent
          // CDDS_ITEMPREPAINT notifications
          Result := CDRF_NOTIFYITEMDRAW;
        CDDS_ITEMPREPAINT:
          begin
            case Info.dwItemSpec of
              TBCD_CHANNEL:
                Result := CDRF_DODEFAULT or CDRF_NOTIFYPOSTPAINT;
              else Result := CDRF_DODEFAULT;
            end;
          end;
        CDDS_ITEMPOSTPAINT:
          begin
            case Info.dwItemSpec of
              TBCD_CHANNEL:
                begin
                  //info.hdc  = DC Handle
                  //info.rc   = Rect
                  inflateRect(info.rc, -4, -2);
                  FChannelCanvas.Handle := info.hdc;
                  if Assigned(FOnChannelPostPaint) then FOnChannelPostPaint(self, info.rc);

                  {FChannelCanvas.Brush.Color := clred;
                  FChannelCanvas.Brush.Style := bsSolid;
                  FChannelCanvas.FillRect(info.rc);  }
                  FChannelCanvas.Handle := 0;

                  //fillrect(info.hdc, info.rc, hbrush(COLOR_ACTIVECAPTION +1));

                {
                  SendMessage(Handle, TBM_GETTHUMBRECT, 0, Integer(@R));
                  Offset := 0;
                  if Focused then
                    Inc(Offset);
                  if Orientation = trHorizontal then
                  begin
                    R.Left := ClientRect.Left + Offset;
                    R.Right := ClientRect.Right - Offset;
                  end
                  else
                  begin
                    R.Top := ClientRect.Top + Offset;
                    R.Bottom := ClientRect.Bottom - Offset;
                  end;
                  with R do
                    Rgn := CreateRectRgn(Left, Top, Right, Bottom);
                  SelectClipRgn(Info.hDC, Rgn);
                  Details := ThemeServices.GetElementDetails(ttbThumbTics);
                  ThemeServices.DrawParentBackground(Handle, Info.hDC, @Details, False);
                  DeleteObject(Rgn);
                  SelectClipRgn(Info.hDC, 0);
                 }
                  Result := CDRF_SKIPDEFAULT
                end;
              else Result := CDRF_DODEFAULT;
            end;
          end;
      else
        Result := CDRF_DODEFAULT;
      end;
    end else
      inherited;
  end;
end;

procedure TDSTrackBarEx.TriggerTimer;
begin
  self.Timer;
end;

procedure TDSTrackBarEx.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if Button = mbLeft then FMouseDown := False;
  if FUserIsMarking then begin
    FUserIsMarking := false;
    FOnSelChanged(self);
  end;
  FOnPositionChangedByMouse(self);
end;


procedure TDSTrackBarEx.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
    inherited MouseDown(Button, Shift, X, Y);
    if Button = mbLeft then FMouseDown := true;
    if ssShift in Shift then begin
      FMarkingStart := self.Position;
      FMarkingEnd := self.Position;
      FUserIsMarking := true;
    end;
end;

procedure TDSTrackBarEx.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (ssShift in Shift) and FUserIsMarking then begin
    FMarkingEnd := Position;
    if FMarkingStart <= FMarkingEnd then begin
      SelStart := FMarkingStart;
      SelEnd := FMarkingEnd;
    end else begin
      SelStart := FMarkingEnd;
      SelEnd := FMarkingStart;
    end;
  end;
end;

destructor TDSTrackBarEx.Destroy;
begin
  FChannelCanvas.Free;
  inherited;
end;

procedure TDSTrackBarEx.SetOnChannelPostPaint(const Value: TTBCUstomDrawEvent);
begin
  FOnChannelPostPaint := Value;
end;


end.
