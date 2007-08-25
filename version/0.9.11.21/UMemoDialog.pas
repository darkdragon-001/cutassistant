unit UMemoDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmMemoDialog = class(TForm)
    BClose: TButton;
    memInfo: TMemo;
    procedure BCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMemoDialog: TfrmMemoDialog;

implementation

{$R *.dfm}


procedure TfrmMemoDialog.BCloseClick(Sender: TObject);
begin
  self.Hide;
end;

end.
