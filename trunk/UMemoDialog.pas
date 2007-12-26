unit UMemoDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmMemoDialog = class(TForm)
    cmdClose: TButton;
    memInfo: TMemo;
    procedure cmdCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMemoDialog: TfrmMemoDialog;

implementation

{$R *.dfm}


procedure TfrmMemoDialog.cmdCloseClick(Sender: TObject);
begin
  self.Hide;
end;

end.
