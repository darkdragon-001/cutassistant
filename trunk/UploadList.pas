unit UploadList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TFUploadList = class(TForm)
    pnlButtons: TPanel;
    lvLinklist: TListView;
    cmdCancel: TButton;
    cmdDelete: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FUploadLIst: TFUploadLIst;

implementation

{$R *.dfm}

{ TFCutlistSearchResults }

end.
