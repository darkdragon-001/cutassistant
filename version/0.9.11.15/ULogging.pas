UNIT ULogging;

INTERFACE

USES
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvFormMagnet, JvComponentBase, JvFormAutoSize, ExtCtrls,
  StdCtrls, ComCtrls;

TYPE
  TFLogging = CLASS(TForm)
    JvFormMagnet1: TJvFormMagnet;
    reMessages: TRichEdit;
    timScroll: TTimer;
    PROCEDURE timScrollTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  PRIVATE
    { Private-Deklarationen }
  PROTECTED
    PROCEDURE AddMessage(CONST ANow: TDateTime; CONST AMessage: STRING); OVERLOAD;
    PROCEDURE TimedScroll;
    PROCEDURE AppendToFile(CONST AFilename: STRING); OVERLOAD;
  PUBLIC
    { Public-Deklarationen }
    PROCEDURE AddMessage(CONST AMessage: STRING); OVERLOAD;
    PROCEDURE AppendToFile(CONST AFileBasename: STRING; CONST ADate: TDate); OVERLOAD;
    PROCEDURE AppendToFile(CONST ADate: TDate); OVERLOAD;
  END;

VAR
  FLogging                    : TFLogging;

IMPLEMENTATION

uses Main, Utils, Math;

{$R *.dfm}

PROCEDURE TFLogging.timScrollTimer(Sender: TObject);
BEGIN
  IF NOT reMessages.HandleAllocated THEN
    Exit;
  timScroll.Enabled := false;
  PostMessage(reMessages.Handle, WM_VSCROLL, SB_BOTTOM, 0); //Scroll down
END;

PROCEDURE TFLogging.AddMessage(CONST AMessage: STRING);
BEGIN
  AddMessage(Now, AMessage);
  IF Screen.ActiveForm = Self THEN
    Exit;
  TimedScroll;
END;

PROCEDURE TFLogging.AddMessage(CONST ANow: TDateTime; CONST AMessage: STRING);
BEGIN
  reMessages.Lines.Add(FormatDateTime('ddddd tt.zzz', ANow) + ': ' + AMessage);
END;

PROCEDURE TFLogging.AppendToFile(CONST ADate: TDate);
VAR
  fName                       : STRING;
begin
  fName := ExpandUNCFileName(Application.ExeName);
  //Delete(fName, Length(fName) - Length(ExtractFileExt(fName)) + 1, MaxInt);
  AppendToFile(ChangeFileExt(fName, ''), ADate);
end;

PROCEDURE TFLogging.AppendToFile(CONST AFileBasename: STRING; CONST ADate: TDate);
VAR
  fName                       : STRING;
BEGIN
  fName := AFileBasename + FormatDateTime('-yyyy-mm-dd', ADate) + '.log';
  AppendToFile(fName);
END;

PROCEDURE TFLogging.AppendToFile(CONST AFilename: STRING);
VAR
  stream                      : TFileStream;
BEGIN
  stream := TFileStream.Create(AFilename, fmCreate OR fmOpenReadWrite, fmShareDenyWrite);
  TRY
    stream.Seek(0, soFromEnd);
    reMessages.Lines.SaveToStream(stream);
  FINALLY
    FreeAndNil(stream);
  END;
END;

PROCEDURE TFLogging.TimedScroll;
BEGIN
  timScroll.Enabled := true;
END;

procedure TFLogging.FormCreate(Sender: TObject);
begin
  if ValidRect(Settings.LoggingFormBounds) then
    self.BoundsRect := Settings.LoggingFormBounds
  else
  begin
    self.Top := Screen.WorkAreaTop + Max(0, (Screen.WorkAreaHeight - self.Height) div 2);
    self.Left := Screen.WorkAreaLeft + Max(0, (Screen.WorkAreaWidth - self.Width) div 2);
  end;

  self.Visible := Settings.LoggingFormVisible;
end;

procedure TFLogging.FormDestroy(Sender: TObject);
begin
  Settings.LoggingFormBounds := self.BoundsRect;
  Settings.LoggingFormVisible := self.Visible;
end;

END.

