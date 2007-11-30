UNIT UfrmCutting;

INTERFACE

USES
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponentBase, JvCreateProcess, StdCtrls,
  UCutApplicationBase, ExtCtrls;

TYPE
  TfrmCutting = CLASS(TForm)
    memOutput: TMemo;
    btnClose: TButton;
    btnAbort: TButton;
    btnCopyClipbrd: TButton;
    btnEmergencyExit: TButton;
    timAutoClose: TTimer;
    PROCEDURE CutAppTerminate(Sender: TObject; ExitCode: Cardinal);
    PROCEDURE btnAbortClick(Sender: TObject);
    PROCEDURE btnCopyClipbrdClick(Sender: TObject);
    PROCEDURE FormCreate(Sender: TObject);
    PROCEDURE FormDestroy(Sender: TObject);
    PROCEDURE btnEmergencyExitClick(Sender: TObject);
    PROCEDURE timAutoCloseTimer(Sender: TObject);
    PROCEDURE memOutputClick(Sender: TObject);
  PRIVATE
    { Private declarations }
    FTerminateTime: TDateTime;
    //FCommandLineCounter: Integer;
    FCutApplication: TCutApplicationBase;
    PROCEDURE SetCutApplication(CONST Value: TCutApplicationBase);
  PUBLIC
    { Public declarations }
    CommandLines: TStringList;
    FUNCTION ExecuteCutApp: Integer;
    PROPERTY CutApplication: TCutApplicationBase READ FCutApplication WRITE SetCutApplication;
  END;

VAR
  frmCutting                       : TfrmCutting;

IMPLEMENTATION

USES Clipbrd, DateTools, DateUtils, Main;

{$R *.dfm}

FUNCTION TfrmCutting.ExecuteCutApp: Integer;
BEGIN
  result := mrNone;
  IF NOT assigned(CutApplication) THEN exit;

  //self.memOutput.Clear;
  btnAbort.Enabled := true;
  btnEmergencyExit.Enabled := true;
  btnClose.Enabled := false;
  timAutoClose.Enabled := false;

  CutApplication.StartCutting;
  self.ShowModal;
  IF CutApplication.CleanUp THEN BEGIN
    IF NOT CutApplication.CleanUpAfterCutting THEN
      Showmessage('Error while cleaning up after cutting.');
  END;
END;

PROCEDURE TfrmCutting.CutAppTerminate(Sender: TObject;
  ExitCode: Cardinal);
BEGIN
  IF ExitCode = 0 THEN BEGIN
    btnClose.ModalResult := mrOK;
  END ELSE BEGIN
    btnClose.ModalResult := mrCancel;
  END;
  btnAbort.Enabled := false;
  btnEmergencyExit.Enabled := false;
  btnClose.Enabled := true;
  FTerminateTime := NowUTC;
  IF Settings.CuttingWaitTimeout > 0 THEN
    timAutoClose.Enabled := true;
  Beep;
END;

PROCEDURE TfrmCutting.btnAbortClick(Sender: TObject);
BEGIN
  IF assigned(self.FCutApplication) THEN FCutApplication.AbortCutProcess;
END;

PROCEDURE TfrmCutting.btnCopyClipbrdClick(Sender: TObject);
BEGIN
  Clipboard.AsText := memOutput.Text;
END;

PROCEDURE TfrmCutting.FormCreate(Sender: TObject);
BEGIN
  self.CommandLines := TStringList.Create;
END;

PROCEDURE TfrmCutting.FormDestroy(Sender: TObject);
BEGIN
  FreeAndNIL(self.CommandLines);
END;

PROCEDURE TfrmCutting.SetCutApplication(CONST Value: TCutApplicationBase);
BEGIN
  FCutApplication := Value;
  IF assigned(FCutApplication) THEN BEGIN
    FCutApplication.OnCuttingTerminate := self.CutAppTerminate;
    FCutApplication.OutputMemo := self.memOutput;
  END ELSE BEGIN
    FCutApplication.OnCuttingTerminate := NIL;
    FCutApplication.OutputMemo := NIL;
  END;
END;

PROCEDURE TfrmCutting.btnEmergencyExitClick(Sender: TObject);
VAR
  message_string                   : STRING;
BEGIN
  message_string := 'The Cut Application will be terminated immediately!' + #13#10
    + 'This may result in unexpected behaviour of the Cut Application.' + #13#10#13#10
    + 'Do you really want to terminate the Application?';
  IF (application.messagebox(PChar(message_string), 'Application warning.', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES) THEN BEGIN
    CutApplication.EmergencyTerminateProcess;
    self.CutAppTerminate(self, Cardinal(-1));
  END;
END;

PROCEDURE TfrmCutting.timAutoCloseTimer(Sender: TObject);
VAR
  secsToWait                       : integer;
BEGIN
  secsToWait := Settings.CuttingWaitTimeout - SecondsBetween(FTerminateTime, NowUTC);
  IF secsToWait <= 0 THEN BEGIN
    timAutoClose.Enabled := false;
    btnClose.Click;
  END
  ELSE BEGIN
    btnClose.Caption := '&Close (' + IntToStr(secsToWait) + ')';
  END;
END;

PROCEDURE TfrmCutting.memOutputClick(Sender: TObject);
BEGIN
  IF timAutoClose.Enabled THEN BEGIN
    timAutoClose.Enabled := false;
    btnClose.Caption := '&Close';
  END;
END;

END.
