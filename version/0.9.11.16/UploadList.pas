unit UploadList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TFUploadList = class(TForm)
    Panel1: TPanel;
    LLinklist: TListView;
    BCancel: TButton;
    BDelete: TButton;
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
