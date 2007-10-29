unit UfrmCutting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponentBase, JvCreateProcess, StdCtrls,
  UCutApplicationBase, ExtCtrls;

type
  TfrmCutting = class(TForm)
    memOutput: TMemo;
    btnClose: TButton;
    btnAbort: TButton;
    btnCopyClipbrd: TButton;
    btnEmergencyExit: TButton;
    timAutoClose: TTimer;
    procedure CutAppTerminate(Sender: TObject; ExitCode: Cardinal);
    procedure btnAbortClick(Sender: TObject);
    procedure btnCopyClipbrdClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnEmergencyExitClick(Sender: TObject);
    procedure timAutoCloseTimer(Sender: TObject);
    procedure memOutputClick(Sender: TObject);
  private
    { Private declarations }
    FTerminateTime: TDateTime;
    //FCommandLineCounter: Integer;
    FCutApplication: TCutApplicationBase;
    procedure SetCutApplication(const Value: TCutApplicationBase);
  public
    { Public declarations }
    CommandLines: TStringList;
    function ExecuteCutApp: Integer;
    property CutApplication: TCutApplicationBase read FCutApplication write SetCutApplication;
  end;

var
  frmCutting: TfrmCutting;

implementation

uses Clipbrd, DateTools, DateUtils, Utils, Main, CAResources;

{$R *.dfm}

function TfrmCutting.ExecuteCutApp: Integer;
begin
  result := mrNone;
  if not assigned(CutApplication) then exit;

  //self.memOutput.Clear;
  btnAbort.Enabled := true;
  btnEmergencyExit.Enabled := true;
  btnClose.Enabled := false;
  timAutoClose.Enabled := false;
  btnClose.Caption := CAResources.RsCaptionCuttingClose;

  CutApplication.StartCutting;
  self.ShowModal;
  if CutApplication.CleanUp then
  begin
    if not CutApplication.CleanUpAfterCutting then
      if not batchmode then
        ShowMessage(CAResources.RsErrorCleanUpCutting);
  end;
end;

procedure TfrmCutting.CutAppTerminate(Sender: TObject;
  ExitCode: Cardinal);
begin
  if ExitCode=0 then begin
    btnClose.ModalResult := mrOK;
  end else begin
    btnClose.ModalResult := mrCancel;
  end;
  btnAbort.Enabled := false;
  btnEmergencyExit.Enabled := false;
  btnClose.Enabled := true;
  FTerminateTime := NowUTC;
  if Settings.CuttingWaitTimeout > 0 then
    timAutoClose.Enabled := true;
  Beep;
end;

procedure TfrmCutting.btnAbortClick(Sender: TObject);
begin
  if assigned(self.FCutApplication) then FCutApplication.AbortCutProcess;
end;

procedure TfrmCutting.btnCopyClipbrdClick(Sender: TObject);
begin
  Clipboard.AsText := memOutput.Text;
end;

procedure TfrmCutting.FormCreate(Sender: TObject);
begin
  self.CommandLines := TStringList.Create;
end;

procedure TfrmCutting.FormDestroy(Sender: TObject);
begin
  FreeAndNIL(self.CommandLines);
end;

procedure TfrmCutting.SetCutApplication(const Value: TCutApplicationBase);
begin
  FCutApplication := Value;
  if assigned(FCutApplication) then begin
    FCutApplication.OnCuttingTerminate := self.CutAppTerminate;
    FCutApplication.OutputMemo := self.memOutput;
  end else begin
    FCutApplication.OnCuttingTerminate := nil;
    FCutApplication.OutputMemo := nil;
  end;
end;

procedure TfrmCutting.btnEmergencyExitClick(Sender: TObject);
begin
  if (application.messagebox(PChar(CAResources.RsMsgWarnOnTerminateCutApplication), PChar(CAResources.RsTitleWarning), MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES) then
  begin
    CutApplication.EmergencyTerminateProcess;
    self.CutAppTerminate(self, Cardinal(-1));
  end;
end;

procedure TfrmCutting.timAutoCloseTimer(Sender: TObject);
var
  secsToWait: integer;
begin
  secsToWait := Settings.CuttingWaitTimeout - SecondsBetween(FTerminateTime, NowUTC);
  if secsToWait <= 0 then
  begin
    timAutoClose.Enabled := false;
    btnClose.Click;
  end
  else
  begin
    btnClose.Caption := Format(CAResources.RsCaptionCuttingAutoClose, [ secsToWait ]);
  end;
end;

procedure TfrmCutting.memOutputClick(Sender: TObject);
begin
  if timAutoClose.Enabled then
  begin
    timAutoClose.Enabled := false;
    btnClose.Caption := CAResources.RsCaptionCuttingClose;
  end;
end;

end.
