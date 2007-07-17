unit UfrmCutting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponentBase, JvCreateProcess, StdCtrls,
  UCutApplicationBase;

type
  TfrmCutting = class(TForm)
    memOutput: TMemo;
    btnClose: TButton;
    btnAbort: TButton;
    btnCopyClipbrd: TButton;
    btnEmergencyExit: TButton;
    procedure CutAppTerminate(Sender: TObject; ExitCode: Cardinal);
    procedure btnAbortClick(Sender: TObject);
    procedure btnCopyClipbrdClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnEmergencyExitClick(Sender: TObject);
  private
    { Private declarations }
    FCommandLineCounter: Integer;
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

{$R *.dfm}

function TfrmCutting.ExecuteCutApp: Integer;
begin
  result := mrNone;
  if not assigned(CutApplication) then exit;

  //self.memOutput.Clear;
  btnAbort.Enabled := true;
  btnEmergencyExit.Enabled := true;
  btnClose.Enabled := false;

  CutApplication.StartCutting;
  self.ShowModal;
  if CutApplication.CleanUp then begin
    if not CutApplication.CleanUpAfterCutting then
      showmessage('Error while cleaning up after cutting.');
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
  beep;
end;

procedure TfrmCutting.btnAbortClick(Sender: TObject);
begin
  if assigned(self.FCutApplication) then FCutApplication.AbortCutProcess;
end;

procedure TfrmCutting.btnCopyClipbrdClick(Sender: TObject);
begin
  memOutput.SelectAll;
  memOutput.CopyToClipboard;
end;

procedure TfrmCutting.FormCreate(Sender: TObject);
begin
  self.CommandLines := TStringList.Create;
end;

procedure TfrmCutting.FormDestroy(Sender: TObject);
begin
  self.CommandLines.Free;
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
var
  message_string: string;
begin
  message_string := 'The Cut Application will be terminated immediately!'+#13#10
                  + 'This may result in unexpected behaviour of the Cut Application.'+#13#10
                  + 'Do you really want to terminate the Application?';
  if (application.messagebox(PChar(message_string), nil, MB_YESNO + MB_ICONQUESTION) = IDYES) then begin
    CutApplication.EmergencyTerminateProcess;
    self.CutAppTerminate(self, Cardinal(-1));
  end;
end;

end.