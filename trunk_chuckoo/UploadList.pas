UNIT UploadList;

INTERFACE

USES
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

TYPE
  TFUploadList = CLASS(TForm)
    Panel1: TPanel;
    LLinklist: TListView;
    BCancel: TButton;
    BDelete: TButton;
  PRIVATE
    { Private declarations }
  PUBLIC
    { Public declarations }
  END;

VAR
  FUploadLIst                      : TFUploadLIst;

IMPLEMENTATION

{$R *.dfm}

{ TFCutlistSearchResults }

END.
