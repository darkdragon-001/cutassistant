UNIT UMemoDialog;

INTERFACE

USES
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

TYPE
  TfrmMemoDialog = CLASS(TForm)
    BClose: TButton;
    memInfo: TMemo;
    PROCEDURE BCloseClick(Sender: TObject);
  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
  END;

VAR
  frmMemoDialog                    : TfrmMemoDialog;

IMPLEMENTATION

{$R *.dfm}


PROCEDURE TfrmMemoDialog.BCloseClick(Sender: TObject);
BEGIN
  self.Hide;
END;

END.
